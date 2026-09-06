package com.typedefai.cryptowl.vault

import android.content.Context
import com.typedefai.cryptowl.crypto.CrockfordBase32
import com.typedefai.cryptowl.crypto.HmacSha256
import com.typedefai.cryptowl.crypto.KdfParams
import com.typedefai.cryptowl.crypto.KdfService
import com.typedefai.cryptowl.crypto.ProtectedValue
import java.io.File
import java.security.MessageDigest

/** Thrown when the vault cannot be opened (wrong password, tampering...). */
class VaultOpenException(message: String) : Exception(message)

/**
 * Opens a vault with the master password — mirror of
 * `wechat_sns_export/vaultlib/vault.py::Vault.open`:
 *
 *   1. parse + version-check vault.meta
 *   2. Device Secret: Android Keystore, or the desktop `device_secret` file
 *      for a vault created/migrated on the desktop
 *   3. derive TMK → SMK, verify config.sig and vault.meta mac
 *   4. unwrap `vault_key:smk` → VaultKey → open the SQLCipher database
 *   5. re-bind desktop vaults: re-wrap VaultKey with the Android Device
 *      Secret and delete `device_secret` (design "re-bind on import")
 *
 * All intermediates are wiped before returning.
 */
class UnlockService(
    private val context: Context,
    private val kdf: KdfService = KdfService(),
) {

    fun unlock(
        masterPassword: ProtectedValue,
        vaultId: String = VaultStore.DEFAULT_VAULT_ID,
    ): VaultSession {
        val metaFile = VaultStore.metaFile(context, vaultId)
        if (!metaFile.exists()) throw VaultOpenException("not a vault: $vaultId")
        val meta = try {
            VaultMetaJson.decode(metaFile.readText())
        } catch (e: Exception) {
            throw VaultOpenException("corrupt vault.meta: ${e.message}")
        }
        if (meta.version > META_VERSION) {
            throw VaultOpenException("unsupported vault.meta version: ${meta.version}")
        }

        val params = KdfParams(
            algorithm = meta.kdf.algorithm,
            mCostKiB = meta.kdf.mKib,
            tCost = meta.kdf.t,
            parallelism = meta.kdf.p,
        )
        val desktopSecret = readDesktopSecret(vaultId)
        val deviceSecret = desktopSecret?.let { ProtectedValue.fromBinary(it) }
            ?: DeviceSecretStore.getOrCreate(context)

        val tmk = kdf.createTransformedMasterKey(masterPassword, deviceSecret, meta.salts.argon2, params)
        val smk = kdf.createStretchedMasterKey(tmk, vaultId.toByteArray(Charsets.UTF_8), meta.salts.hkdf)
        val macKey = kdf.macKey(smk)

        try {
            verifyConfig(meta, macKey)
            verifyMetaMac(meta, macKey)

            val wrappedVaultKey = meta.wrappedKeys.firstOrNull { it.id == WRAPPED_VAULT_KEY_SMK }
                ?: throw VaultOpenException("no vault_key:smk wrapped key in vault.meta")
            val vaultKey = kdf.unwrapKey(
                wrapped = wrappedVaultKey.toWrappedKey(),
                wrappingKey = kdf.vaultKey(smk),
                aad = WRAPPED_VAULT_KEY_SMK.toByteArray(Charsets.UTF_8),
            )

            val db = openDatabase(vaultId, vaultKey)
            val fek = kdf.fileKey(vaultKey)

            // Desktop-created vault: re-bind to this device before handing out.
            if (desktopSecret != null) {
                rebindVaultKey(meta, vaultId, masterPassword, vaultKey)
            }
            return VaultSession(vaultId, db, vaultKey, fek)
        } catch (e: VaultOpenException) {
            throw e
        } catch (e: Exception) {
            throw VaultOpenException("unlock failed: ${e.message}")
        } finally {
            tmk.clear()
            smk.clear()
            macKey.clear()
            deviceSecret.clear()
            desktopSecret?.fill(0)
        }
    }

    // ------------------------------------------------------------------ steps

    private fun readDesktopSecret(vaultId: String): ByteArray? {
        val file = VaultStore.deviceSecretFile(context, vaultId)
        if (!file.exists()) return null
        return try {
            file.readText().trim().let { hex ->
                hex.chunked(2).map { it.toInt(16).toByte() }.toByteArray()
            }
        } catch (e: Exception) {
            throw VaultOpenException("corrupt device_secret file")
        }
    }

    private fun verifyConfig(meta: VaultMeta, macKey: ProtectedValue) {
        val configFile = VaultStore.configFile(context, meta.vaultId)
        val sigFile = VaultStore.configSigFile(context, meta.vaultId)
        if (!configFile.exists() || !sigFile.exists()) {
            throw VaultOpenException("missing config.json or config.sig")
        }
        val configBytes = configFile.readBytes()
        val expected = macKey.use { HmacSha256.mac(it, configBytes) }
        val stored = try {
            CrockfordBase32.decode(sigFile.readText().trim())
        } catch (e: Exception) {
            throw VaultOpenException("corrupt config.sig")
        }
        if (!MessageDigest.isEqual(stored, expected)) {
            throw VaultOpenException("config.sig mismatch — vault config tampered")
        }
    }

    private fun verifyMetaMac(meta: VaultMeta, macKey: ProtectedValue) {
        val mac = meta.mac
        if (mac == null || mac.algorithm != "HMAC-SHA256") {
            throw VaultOpenException("vault.meta missing/invalid mac")
        }
        val expected = macKey.use { VaultMetaJson.computeMac(meta, it) }
        if (!MessageDigest.isEqual(expected.toByteArray(Charsets.UTF_8), mac.value.toByteArray(Charsets.UTF_8))) {
            throw VaultOpenException("vault.meta mac mismatch — metadata tampered")
        }
    }

    private fun openDatabase(vaultId: String, vaultKey: ProtectedValue): net.zetetic.database.sqlcipher.SQLiteDatabase {
        System.loadLibrary("sqlcipher")
        return vaultKey.use { key ->
            val db = net.zetetic.database.sqlcipher.SQLiteDatabase.openOrCreateDatabase(
                VaultStore.dbFile(context, vaultId), key, null, null,
            )
            try {
                // Probe: a wrong key makes every statement fail with
                // "file is not a database" (mirrors vaultlib verify_key).
                db.rawQuery("SELECT count(*) FROM sqlite_master", null).use { it.moveToFirst() }
                SchemaApplier.migrate(db, context)
                db
            } catch (e: Exception) {
                db.close()
                throw e
            }
        }
    }

    /**
     * Re-wraps `vault_key:smk` with the Android Keystore Device Secret and
     * deletes the desktop `device_secret` file — one-time binding on first
     * open of a desktop-created vault (docs/design.md "re-bind on import").
     */
    private fun rebindVaultKey(meta: VaultMeta, vaultId: String, masterPassword: ProtectedValue, vaultKey: ProtectedValue) {
        val androidSecret = DeviceSecretStore.getOrCreate(context)
        val tmk = kdf.createTransformedMasterKey(masterPassword, androidSecret, meta.salts.argon2, paramsOf(meta))
        val smk = kdf.createStretchedMasterKey(tmk, vaultId.toByteArray(Charsets.UTF_8), meta.salts.hkdf)
        try {
            val reWrapped = kdf.wrapKey(
                key = vaultKey,
                wrappingKey = kdf.vaultKey(smk),
                aad = WRAPPED_VAULT_KEY_SMK.toByteArray(Charsets.UTF_8),
            )
            val newEntry = VaultMeta.WrappedKeyEntry.fromWrappedKey(WRAPPED_VAULT_KEY_SMK, reWrapped)
            val updated = meta.copy(
                updatedAt = System.currentTimeMillis(),
                wrappedKeys = meta.wrappedKeys.map { if (it.id == WRAPPED_VAULT_KEY_SMK) newEntry else it },
            )
            val macBytes = kdf.macKey(smk).binaryValue()
            try {
                val updatedWithMac = updated.copy(
                    mac = VaultMeta.Mac(
                        algorithm = "HMAC-SHA256",
                        value = VaultMetaJson.computeMac(updated, macBytes),
                    ),
                )
                macBytes.fill(0)
                val metaFile = VaultStore.metaFile(context, vaultId)
                val tmp = File(metaFile.parentFile, "vault.meta.tmp")
                tmp.writeText(VaultMetaJson.encode(updatedWithMac))
                if (!tmp.renameTo(metaFile)) {
                    tmp.delete()
                    throw VaultOpenException("failed to re-write vault.meta")
                }
            } finally {
                macBytes.fill(0)
            }
            VaultStore.deviceSecretFile(context, vaultId).delete()
        } finally {
            tmk.clear()
            smk.clear()
            androidSecret.clear()
        }
    }

    private fun paramsOf(meta: VaultMeta): KdfParams = KdfParams(
        algorithm = meta.kdf.algorithm,
        mCostKiB = meta.kdf.mKib,
        tCost = meta.kdf.t,
        parallelism = meta.kdf.p,
    )

    private companion object {
        const val META_VERSION = 2
        const val WRAPPED_VAULT_KEY_SMK = "vault_key:smk"
    }
}
