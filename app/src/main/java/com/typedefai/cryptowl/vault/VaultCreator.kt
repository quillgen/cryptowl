package com.typedefai.cryptowl.vault

import android.content.Context
import com.typedefai.cryptowl.crypto.KdfParams
import com.typedefai.cryptowl.crypto.KdfService
import com.typedefai.cryptowl.crypto.ProtectedValue
import com.typedefai.cryptowl.crypto.RandomUtil
import net.zetetic.database.sqlcipher.SQLiteDatabase
import java.io.File

/**
 * Vault creation pipeline — see docs/design.md "Vault Meta File" and
 * "Vault Storage Layout".
 *
 * Order matters: vault.meta (with `vault_key:smk`) is written *before* the
 * DB is created, because the SQLCipher key comes from unwrapping it.
 * All intermediate keys are wiped on exit; only the wrapped copy and the
 * (ciphertext-only) schema data are persisted.
 */
class VaultCreator(
    private val context: Context,
    private val kdf: KdfService = KdfService(),
) {

    fun create(masterPassword: ProtectedValue, vaultId: String = VaultStore.DEFAULT_VAULT_ID): VaultMeta {
        val vaultDir = VaultStore.vaultDir(context, vaultId)
        require(!VaultStore.metaFile(context, vaultId).exists()) { "vault already exists: $vaultId" }
        vaultDir.mkdirs()

        val deviceSecret = DeviceSecretStore.getOrCreate(context)
        val argon2Salt = RandomUtil.generateSecureBytes(SALT_SIZE)
        val hkdfSalt = RandomUtil.generateSecureBytes(SALT_SIZE)
        val secondarySalt = RandomUtil.generateSecureBytes(SALT_SIZE)

        val tmk = kdf.createTransformedMasterKey(masterPassword, deviceSecret, argon2Salt)
        val smk = kdf.createStretchedMasterKey(tmk, vaultId.toByteArray(Charsets.UTF_8), hkdfSalt)
        val vaultKey = ProtectedValue.fromBinary(RandomUtil.generateSecureBytes(KEY_SIZE))
        val wrappedVaultKey = kdf.wrapKey(
            key = vaultKey,
            wrappingKey = kdf.vaultKey(smk),
            aad = WRAPPED_VAULT_KEY_SMK.toByteArray(Charsets.UTF_8),
        )

        val now = System.currentTimeMillis()
        val meta = VaultMeta(
            version = META_VERSION,
            vaultId = vaultId,
            createdAt = now,
            updatedAt = now,
            kdf = VaultMeta.Kdf(
                algorithm = KdfParams.OWASP.algorithm,
                mKib = KdfParams.OWASP.mCostKiB,
                t = KdfParams.OWASP.tCost,
                p = KdfParams.OWASP.parallelism,
            ),
            salts = VaultMeta.Salts(argon2 = argon2Salt, hkdf = hkdfSalt, secondary = secondarySalt),
            wrappedKeys = listOf(VaultMeta.WrappedKeyEntry.fromWrappedKey(WRAPPED_VAULT_KEY_SMK, wrappedVaultKey)),
        )
        val macKey = kdf.macKey(smk)
        val metaWithMac = meta.copy(mac = VaultMetaJson.computeMac(meta, macKey.binaryValue()))

        try {
            writeMetaAtomically(metaWithMac)
            createDatabase(vaultKey, vaultId)
            VaultStore.writeIndex(context, vaultId)
        } finally {
            tmk.clear()
            smk.clear()
            vaultKey.clear()
            macKey.clear()
            deviceSecret.clear()
            argon2Salt.fill(0)
            hkdfSalt.fill(0)
            secondarySalt.fill(0)
        }
        return metaWithMac
    }

    private fun writeMetaAtomically(meta: VaultMeta) {
        val metaFile = VaultStore.metaFile(context, meta.vaultId)
        val tmp = File(metaFile.parentFile, "vault.meta.tmp")
        tmp.writeText(VaultMetaJson.encode(meta))
        if (!tmp.renameTo(metaFile)) {
            tmp.delete()
            throw IllegalStateException("failed to write vault.meta atomically")
        }
    }

    private fun createDatabase(vaultKey: ProtectedValue, vaultId: String) {
        System.loadLibrary("sqlcipher")
        vaultKey.use { key ->
            val db = SQLiteDatabase.openOrCreateDatabase(VaultStore.dbFile(context, vaultId), key, null, null)
            try {
                val schema = context.assets.open(SCHEMA_ASSET).bufferedReader().readText()
                for (statement in schema.split(';')) {
                    val trimmed = statement.trim()
                    if (trimmed.isEmpty() || trimmed.startsWith("--")) continue
                    db.execSQL(trimmed)
                }
            } finally {
                db.close()
            }
        }
    }

    private companion object {
        const val META_VERSION = 2
        const val KEY_SIZE = 32
        const val SALT_SIZE = 32
        const val WRAPPED_VAULT_KEY_SMK = "vault_key:smk"
        const val SCHEMA_ASSET = "schema.sql"
    }
}
