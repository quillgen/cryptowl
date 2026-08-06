package com.typedefai.cryptowl.vault

import com.typedefai.cryptowl.crypto.CrockfordBase32
import com.typedefai.cryptowl.crypto.HmacSha256
import com.typedefai.cryptowl.crypto.WrappedKey

/**
 * Parsed `vault.meta`: bootstrap material readable before the DB opens —
 * per-vault salts, KDF parameters and the wrapped VaultKey copies.
 * See docs/design.md "Vault Meta File (vault.meta)".
 */
data class VaultMeta(
    val version: Int,
    val vaultId: String,
    val createdAt: Long,
    val updatedAt: Long,
    val kdf: Kdf,
    val salts: Salts,
    val wrappedKeys: List<WrappedKeyEntry>,
    val mac: String? = null,
) {
    data class Kdf(
        val algorithm: String,
        val mKib: Int,
        val t: Int,
        val p: Int,
    )

    data class Salts(
        val argon2: ByteArray,
        val hkdf: ByteArray,
        val secondary: ByteArray?,
    )

    data class WrappedKeyEntry(
        val id: String,
        val role: String,
        val wrapper: String,
        val algorithm: String,
        val cipherText: ByteArray,
        val nonce: ByteArray,
        val authTag: ByteArray,
    ) {
        fun toWrappedKey(): WrappedKey = WrappedKey(cipherText, nonce, authTag, algorithm)

        companion object {
            fun fromWrappedKey(id: String, wrapped: WrappedKey): WrappedKeyEntry =
                WrappedKeyEntry(id, role = id.substringBefore(':'), wrapper = id.substringAfter(':'), algorithm = wrapped.algorithm, cipherText = wrapped.cipherText, nonce = wrapped.nonce, authTag = wrapped.authTag)
        }
    }
}

/**
 * Canonical JSON encoding of [VaultMeta] (lexicographic key order, no
 * whitespace) plus a minimal recursive-descent parser. Binary fields are
 * Crockford Base32, matching the cryptowl-ref product encoding.
 *
 * The MAC (HMAC-SHA256 with the MAC Key) is computed over the canonical JSON
 * of the document excluding the `mac` field itself.
 */
object VaultMetaJson {

    fun encode(meta: VaultMeta): String {
        val keys = listOf("version", "vault_id", "created_at", "updated_at", "kdf", "salts", "wrapped_keys", "mac")
        val sb = StringBuilder()
        sb.append('{')
        var first = true
        for (key in keys) {
            val value: String? = when (key) {
                "version" -> meta.version.toString()
                "vault_id" -> quote(meta.vaultId)
                "created_at" -> meta.createdAt.toString()
                "updated_at" -> meta.updatedAt.toString()
                "kdf" -> encodeObject(listOf("algorithm", "m_kib", "t", "p")) {
                    listOf(quote(meta.kdf.algorithm), meta.kdf.mKib.toString(), meta.kdf.t.toString(), meta.kdf.p.toString())
                }
                "salts" -> {
                    val saltKeys = mutableListOf("argon2", "hkdf")
                    if (meta.salts.secondary != null) saltKeys.add("secondary")
                    encodeObject(saltKeys) {
                        mutableListOf(quote(CrockfordBase32.encode(meta.salts.argon2)), quote(CrockfordBase32.encode(meta.salts.hkdf))).apply {
                            if (meta.salts.secondary != null) add(quote(CrockfordBase32.encode(meta.salts.secondary)))
                        }
                    }
                }
                "wrapped_keys" -> {
                    val items = meta.wrappedKeys.joinToString(",") { entry ->
                        encodeObject(listOf("id", "role", "wrapper", "algorithm", "ciphertext", "nonce", "auth_tag")) {
                            listOf(
                                quote(entry.id),
                                quote(entry.role),
                                quote(entry.wrapper),
                                quote(entry.algorithm),
                                quote(CrockfordBase32.encode(entry.cipherText)),
                                quote(CrockfordBase32.encode(entry.nonce)),
                                quote(CrockfordBase32.encode(entry.authTag)),
                            )
                        }
                    }
                    "[$items]"
                }
                "mac" -> meta.mac?.let { quote(it) }
                else -> null
            }
            if (value != null) {
                if (!first) sb.append(',')
                sb.append(quote(key)).append(':').append(value)
                first = false
            }
        }
        sb.append('}')
        return sb.toString()
    }

    /** Canonical JSON of everything except the `mac` field (for MAC computation). */
    fun canonicalWithoutMac(meta: VaultMeta): String = encode(meta.copy(mac = null))

    /** HMAC-SHA256 over the canonical JSON, Crockford Base32 encoded. */
    fun computeMac(meta: VaultMeta, macKey: ByteArray): String =
        CrockfordBase32.encode(HmacSha256.mac(macKey, canonicalWithoutMac(meta).toByteArray(Charsets.UTF_8)))

    /** Parses [json], returning the meta with `mac` populated when present. */
    fun decode(json: String): VaultMeta {
        val root = Parser(json).parseObject()
        fun str(key: String): String = root[key] as? String ?: error("missing '$key'")
        fun num(key: String): Long = when (val v = root[key]) {
            is String -> v.toLong()
            is Number -> v.toLong()
            else -> error("missing '$key'")
        }
        val kdf = root["kdf"] as Map<String, Any>
        val salts = root["salts"] as Map<String, Any>
        val wrappedKeys = (root["wrapped_keys"] as? List<*>)?.map { e ->
            val entry = e as Map<String, Any>
            VaultMeta.WrappedKeyEntry(
                id = entry["id"] as String,
                role = entry["role"] as String,
                wrapper = entry["wrapper"] as String,
                algorithm = entry["algorithm"] as String,
                cipherText = CrockfordBase32.decode(entry["ciphertext"] as String),
                nonce = CrockfordBase32.decode(entry["nonce"] as String),
                authTag = CrockfordBase32.decode(entry["auth_tag"] as String),
            )
        } ?: emptyList()
        return VaultMeta(
            version = num("version").toInt(),
            vaultId = str("vault_id"),
            createdAt = num("created_at"),
            updatedAt = num("updated_at"),
            kdf = VaultMeta.Kdf(
                algorithm = kdf["algorithm"] as String,
                mKib = (kdf["m_kib"] as? String ?: kdf["m_kib"].toString()).toInt(),
                t = (kdf["t"] as? String ?: kdf["t"].toString()).toInt(),
                p = (kdf["p"] as? String ?: kdf["p"].toString()).toInt(),
            ),
            salts = VaultMeta.Salts(
                argon2 = CrockfordBase32.decode(salts["argon2"] as String),
                hkdf = CrockfordBase32.decode(salts["hkdf"] as String),
                secondary = (salts["secondary"] as? String)?.let(CrockfordBase32::decode),
            ),
            wrappedKeys = wrappedKeys,
            mac = root["mac"] as? String,
        )
    }

    private fun encodeObject(keys: List<String>, values: () -> List<String>): String {
        val list = values()
        require(keys.size == list.size)
        val sb = StringBuilder("{")
        for (i in keys.indices) {
            if (i > 0) sb.append(',')
            sb.append(quote(keys[i])).append(':').append(list[i])
        }
        sb.append('}')
        return sb.toString()
    }

    private fun quote(s: String): String {
        val sb = StringBuilder("\"")
        for (c in s) {
            when (c) {
                '"' -> sb.append("\\\"")
                '\\' -> sb.append("\\\\")
                '\n' -> sb.append("\\n")
                '\r' -> sb.append("\\r")
                '\t' -> sb.append("\\t")
                else -> sb.append(c)
            }
        }
        return sb.append('"').toString()
    }

    /** Minimal JSON parser: objects, arrays, strings, numbers, booleans, null. */
    private class Parser(private val input: String) {
        private var pos = 0

        fun parseObject(): Map<String, Any> {
            expect('{')
            val result = LinkedHashMap<String, Any>()
            skipWs()
            if (peek() == '}') { pos++; return result }
            while (true) {
                skipWs()
                val key = parseString()
                skipWs()
                expect(':')
                skipWs()
                result[key] = parseValue()
                skipWs()
                when (peek()) {
                    ',' -> pos++
                    '}' -> { pos++; return result }
                    else -> error("unexpected '${peek()}' at $pos")
                }
            }
        }

        private fun parseValue(): Any {
            return when (peek()) {
            '{' -> parseObject()
            '[' -> {
                pos++
                val list = mutableListOf<Any>()
                skipWs()
                if (peek() == ']') { pos++; return list }
                while (true) {
                    skipWs()
                    list.add(parseValue())
                    skipWs()
                    when (peek()) {
                        ',' -> pos++
                        ']' -> { pos++; return list }
                        else -> error("unexpected '${peek()}' at $pos")
                    }
                }
            }
            '"' -> parseString()
            't' -> { expectWord("true"); true }
            'f' -> { expectWord("false"); false }
            'n' -> { expectWord("null"); "null" }
            else -> parseNumber()
            }
        }

        private fun parseString(): String {
            expect('"')
            val sb = StringBuilder()
            while (pos < input.length) {
                val c = input[pos++]
                when (c) {
                    '"' -> return sb.toString()
                    '\\' -> {
                        val esc = input[pos++]
                        when (esc) {
                            '"' -> sb.append('"')
                            '\\' -> sb.append('\\')
                            '/' -> sb.append('/')
                            'n' -> sb.append('\n')
                            'r' -> sb.append('\r')
                            't' -> sb.append('\t')
                            'b' -> sb.append('\b')
                            'f' -> sb.append('\u000C')
                            'u' -> {
                                val hex = input.substring(pos, pos + 4)
                                pos += 4
                                sb.append(hex.toInt(16).toChar())
                            }
                            else -> error("invalid escape '\\$esc'")
                        }
                    }
                    else -> sb.append(c)
                }
            }
            error("unterminated string")
        }

        private fun parseNumber(): Number {
            val start = pos
            while (pos < input.length && (input[pos].isDigit() || input[pos] in ".-+eE")) pos++
            return input.substring(start, pos).toLongOrNull() ?: input.substring(start, pos).toDouble()
        }

        private fun expectWord(word: String) {
            if (pos + word.length <= input.length && input.substring(pos, pos + word.length) == word) pos += word.length
            else error("expected '$word' at $pos")
        }

        private fun expect(c: Char) {
            if (pos >= input.length || input[pos] != c) error("expected '$c' at $pos")
            pos++
        }

        private fun peek(): Char = if (pos < input.length) input[pos] else '\u0000'

        private fun skipWs() {
            while (pos < input.length && input[pos].isWhitespace()) pos++
        }
    }
}
