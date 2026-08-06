package com.typedefai.cryptowl.crypto

import androidx.test.ext.junit.runners.AndroidJUnit4
import javax.crypto.AEADBadTagException
import org.junit.Assert.assertArrayEquals
import org.junit.Assert.assertEquals
import org.junit.Test
import org.junit.runner.RunWith

private fun String.hexToBytes(): ByteArray =
    ByteArray(length / 2) { Integer.parseInt(substring(it * 2, it * 2 + 2), 16).toByte() }

private fun ByteArray.toHex(): String =
    joinToString("") { "%02x".format(it.toInt() and 0xff) }

/**
 * Key-derivation chain tests against the real Argon2 JNI binding.
 * Vectors cross-verified with cryptowl-ref (Flutter) — both products must
 * derive identical keys from identical inputs (export/backup interop).
 */
@RunWith(AndroidJUnit4::class)
class KdfServiceTest {

    private val service = KdfService()

    // cryptowl-ref vectors:
    //   TMK  = Argon2id(HMAC-SHA256(key="123456", msg=deviceSecret), argon2Salt)
    //   SMK  = HKDF-SHA256(TMK, hkdfSalt, "WJB6W", 64)
    private val deviceSecret =
        "9a54bef1921ce1c89255dc67229ffffd2dd1efb5ef3cdd3da66ae9ab53fb974f".hexToBytes()
            .let { ProtectedValue.fromBinary(it) }
    private val argon2Salt = "b27f6e2bd596308c190c4f1d68660bc3".hexToBytes()

    @Test
    fun derivesTransformedMasterKeyMatchingCryptowlRefVector() {
        val tmk = service.createTransformedMasterKey(
            masterPassword = ProtectedValue.fromString("123456"),
            deviceSecret = deviceSecret,
            salt = argon2Salt,
        )

        assertEquals(
            "509f825b859521f72fe511d2c120f53ed52bf641932d92ba086b89be3d65153a",
            tmk.binaryValue().toHex(),
        )
    }

    @Test
    fun derivesStretchedMasterKeyMatchingCryptowlRefVector() {
        val tmk = ProtectedValue.fromBinary(
            "509f825b859521f72fe511d2c120f53ed52bf641932d92ba086b89be3d65153a".hexToBytes(),
        )
        val hkdfSalt = "8a7c01c0b81c8872e016d779486bc189".hexToBytes()

        val smk = service.createStretchedMasterKey(
            transformedMasterKey = tmk,
            vaultId = "WJB6W".toByteArray(),
            salt = hkdfSalt,
        )

        assertEquals(
            "6414d3f58fcaf252675f1544e4e7d5e389fd1dd319c6df9693b88b44e7363340" +
                "c38a015a41594d78650f501bd7e86fcd88ba7a21d4efb54dc3820056bd9039c9",
            smk.binaryValue().toHex(),
        )
    }

    @Test
    fun derivesSecondaryKeyWithOwaspParams() {
        val secondarySalt = "3f09ea13ceffb8e867a4af3ab17854f9".hexToBytes()

        val tsKek = service.createSecondaryKey(
            secondaryPassword = ProtectedValue.fromString("secondary-pass"),
            salt = secondarySalt,
        )

        assertEquals(
            "487adc4c030ba4a79773ba6a43d1282c075ba0428547d9b00748ec39df9738b2",
            tsKek.binaryValue().toHex(),
        )
    }

    @Test
    fun wrapsAndUnwrapsAVaultKeyWithTheDerivedChain() {
        val smk = service.createStretchedMasterKey(
            transformedMasterKey = service.createTransformedMasterKey(
                masterPassword = ProtectedValue.fromString("123456"),
                deviceSecret = deviceSecret,
                salt = argon2Salt,
            ),
            vaultId = "personal".toByteArray(),
            salt = "8a7c01c0b81c8872e016d779486bc189".hexToBytes(),
        )
        val wrappingKey = service.vaultKey(smk)
        val vaultKey = ProtectedValue.fromBinary(ByteArray(32) { 0x2a })
        val aad = "vault_key:smk".toByteArray()

        val wrapped = service.wrapKey(vaultKey, wrappingKey, aad)
        val unwrapped = service.unwrapKey(wrapped, wrappingKey, aad)

        assertArrayEquals(vaultKey.binaryValue(), unwrapped.binaryValue())
        assertEquals(WrappedKey.AES_256_GCM, wrapped.algorithm)
        assertEquals(12, wrapped.nonce.size)
        assertEquals(32, wrapped.cipherText.size)
    }

    @Test
    fun unwrapFailsWithWrongPassword() {
        val smk = service.createStretchedMasterKey(
            transformedMasterKey = service.createTransformedMasterKey(
                masterPassword = ProtectedValue.fromString("123456"),
                deviceSecret = deviceSecret,
                salt = argon2Salt,
            ),
            vaultId = "personal".toByteArray(),
            salt = "8a7c01c0b81c8872e016d779486bc189".hexToBytes(),
        )
        val wrapped = service.wrapKey(
            key = ProtectedValue.fromBinary(ByteArray(32) { 0x2a }),
            wrappingKey = service.vaultKey(smk),
            aad = "vault_key:smk".toByteArray(),
        )

        val wrongSmk = service.createStretchedMasterKey(
            transformedMasterKey = service.createTransformedMasterKey(
                masterPassword = ProtectedValue.fromString("654321"),
                deviceSecret = deviceSecret,
                salt = argon2Salt,
            ),
            vaultId = "personal".toByteArray(),
            salt = "8a7c01c0b81c8872e016d779486bc189".hexToBytes(),
        )

        try {
            service.unwrapKey(wrapped, service.vaultKey(wrongSmk), "vault_key:smk".toByteArray())
            throw AssertionError("expected AEADBadTagException")
        } catch (expected: AEADBadTagException) {
            // expected
        }
    }
}
