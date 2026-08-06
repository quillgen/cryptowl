package com.typedefai.cryptowl.vault

import com.typedefai.cryptowl.crypto.HmacSha256
import org.junit.Assert.assertEquals
import org.junit.Assert.assertArrayEquals
import org.junit.Assert.assertNull
import org.junit.Test

class VaultMetaJsonTest {

    private val meta = VaultMeta(
        version = 2,
        vaultId = "personal",
        createdAt = 1780000000000,
        updatedAt = 1780000000001,
        kdf = VaultMeta.Kdf(algorithm = "argon2id", mKib = 19456, t = 2, p = 1),
        salts = VaultMeta.Salts(
            argon2 = byteArrayOf(0x01, 0x02, 0x03, 0x04),
            hkdf = byteArrayOf(0x05, 0x06, 0x07, 0x08),
            secondary = byteArrayOf(0x09, 0x0a),
        ),
        wrappedKeys = listOf(
            VaultMeta.WrappedKeyEntry(
                id = "vault_key:smk",
                role = "vault_key",
                wrapper = "smk",
                algorithm = "AES-256-GCM",
                cipherText = byteArrayOf(0x11, 0x12),
                nonce = byteArrayOf(0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28, 0x29, 0x2a, 0x2b, 0x2c),
                authTag = byteArrayOf(0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39, 0x3a, 0x3b, 0x3c, 0x3d, 0x3e, 0x3f, 0x40),
            ),
        ),
    )

    @Test
    fun `encodes canonical json with sorted keys and base32 binary fields`() {
        val json = VaultMetaJson.encode(meta.copy(mac = "MACVALUE"))
        assertEquals(
            "{\"version\":2,\"vault_id\":\"personal\",\"created_at\":1780000000000," +
                "\"updated_at\":1780000000001,\"kdf\":{\"algorithm\":\"argon2id\",\"m_kib\":19456,\"t\":2,\"p\":1}," +
                "\"salts\":{\"argon2\":\"04106-10\",\"hkdf\":\"0M30E-20\",\"secondary\":\"1450\"}," +
                "\"wrapped_keys\":[{\"id\":\"vault_key:smk\",\"role\":\"vault_key\",\"wrapper\":\"smk\"," +
                "\"algorithm\":\"AES-256-GCM\",\"ciphertext\":\"2490\",\"nonce\":\"44H26-9154R-KJGA9-A5CP0\"," +
                "\"auth_tag\":\"64S36-D1N6R-VKGE9-T7CY3-TFHZ8-0\"}]," +
                "\"mac\":\"MACVALUE\"}",
            json,
        )
    }

    @Test
    fun `decode round trips encode`() {
        val withMac = meta.copy(mac = "SOMEMAC")
        val decoded = VaultMetaJson.decode(VaultMetaJson.encode(withMac))

        assertEquals(withMac.version, decoded.version)
        assertEquals(withMac.vaultId, decoded.vaultId)
        assertEquals(withMac.createdAt, decoded.createdAt)
        assertEquals(withMac.updatedAt, decoded.updatedAt)
        assertEquals(withMac.kdf, decoded.kdf)
        assertArrayEquals(withMac.salts.argon2, decoded.salts.argon2)
        assertArrayEquals(withMac.salts.hkdf, decoded.salts.hkdf)
        assertArrayEquals(withMac.salts.secondary, decoded.salts.secondary)
        assertEquals(withMac.wrappedKeys.size, decoded.wrappedKeys.size)
        val original = withMac.wrappedKeys.first()
        val parsed = decoded.wrappedKeys.first()
        assertEquals(original.id, parsed.id)
        assertEquals(original.role, parsed.role)
        assertEquals(original.wrapper, parsed.wrapper)
        assertEquals(original.algorithm, parsed.algorithm)
        assertArrayEquals(original.cipherText, parsed.cipherText)
        assertArrayEquals(original.nonce, parsed.nonce)
        assertArrayEquals(original.authTag, parsed.authTag)
        assertEquals(withMac.mac, decoded.mac)
    }

    @Test
    fun `decode tolerates missing optional fields`() {
        val json = VaultMetaJson.encode(meta.copy(salts = meta.salts.copy(secondary = null), mac = null))
        val decoded = VaultMetaJson.decode(json)

        assertNull(decoded.salts.secondary)
        assertNull(decoded.mac)
    }

    @Test
    fun `decode handles whitespace and string numbers`() {
        val withSpace = VaultMetaJson.encode(meta)
            .replace("\"version\":2", "\"version\": \"2\"")
            .replace("{", "{\n  ")
            .replace(",", ",\n  ")
            .replace("}", "\n}")
        val decoded = VaultMetaJson.decode(withSpace)

        assertEquals(2, decoded.version)
        assertEquals(19456, decoded.kdf.mKib)
    }

    @Test
    fun `mac is hmac-sha256 over canonical json without the mac field`() {
        val macKey = "509f825b859521f72fe511d2c120f53ed52bf641932d92ba086b89be3d65153a".hexToBytes()
        val withoutMac = VaultMetaJson.canonicalWithoutMac(meta)

        val expected = HmacSha256.mac(macKey, withoutMac.toByteArray(Charsets.UTF_8))
        val expectedBase32 = com.typedefai.cryptowl.crypto.CrockfordBase32.encode(expected)

        assertEquals(expectedBase32, VaultMetaJson.computeMac(meta, macKey))
    }

    @Test
    fun `mac changes when meta content changes`() {
        val macKey = ByteArray(32) { 0x42 }
        val macA = VaultMetaJson.computeMac(meta, macKey)
        val macB = VaultMetaJson.computeMac(meta.copy(updatedAt = meta.updatedAt + 1), macKey)
        val macC = VaultMetaJson.computeMac(
            meta.copy(wrappedKeys = meta.wrappedKeys + meta.wrappedKeys.first()), macKey,
        )
        assertEquals(macA, VaultMetaJson.computeMac(meta, macKey))
        assertEquals(false, macA == macB)
        assertEquals(false, macA == macC)
    }

    @Test
    fun `wrapped key entry carries role and wrapper from id`() {
        val wrapped = com.typedefai.cryptowl.crypto.WrappedKey(
            cipherText = byteArrayOf(1), nonce = byteArrayOf(2), authTag = byteArrayOf(3),
        )
        val entry = VaultMeta.WrappedKeyEntry.fromWrappedKey("kek:biokey", wrapped)

        assertEquals("kek", entry.role)
        assertEquals("biokey", entry.wrapper)
        assertEquals("AES-256-GCM", entry.algorithm)
        assertEquals(wrapped, entry.toWrappedKey())
    }

    private fun String.hexToBytes(): ByteArray =
        ByteArray(length / 2) { Integer.parseInt(substring(it * 2, it * 2 + 2), 16).toByte() }
}
