package com.riguz.cryptowl.crypto

import java.nio.charset.StandardCharsets

/**
 * Wrapper for sensitive byte data (passwords, keys). Prevents accidental
 * plaintext logging and allows scrubbing the backing buffer via [clear].
 */
class ProtectedValue private constructor(private var bytes: ByteArray) {

    fun binaryValue(): ByteArray = bytes.copyOf()

    fun getText(): String = CrockfordBase32.encode(bytes)

    fun clear() {
        bytes.fill(0)
    }

    companion object {
        fun fromString(value: String): ProtectedValue =
            ProtectedValue(value.toByteArray(StandardCharsets.UTF_8))

        fun fromBinary(value: ByteArray): ProtectedValue =
            ProtectedValue(value.copyOf())
    }
}
