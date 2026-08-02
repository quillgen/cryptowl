package com.riguz.cryptowl.db

import android.content.Context
import androidx.room.Database
import androidx.room.Room
import androidx.room.RoomDatabase
import androidx.sqlite.db.SupportSQLiteOpenHelper
import net.zetetic.database.sqlcipher.SupportOpenHelperFactory

/**
 * Encrypted vault database backed by SQLCipher.
 *
 * The [passphrase] is used by SQLCipher to derive the AES key. It should come
 * from the user's master password (e.g. via the Argon2 KDF in `Argon2.kt`).
 */
@Database(
    entities = [Password::class],
    version = 1,
    exportSchema = true,
)
abstract class VaultDatabase : RoomDatabase() {

    abstract fun passwordDao(): PasswordDao

    companion object {
        fun create(context: Context, name: String, passphrase: ByteArray): VaultDatabase {
            System.loadLibrary("sqlcipher")
            return Room.databaseBuilder(context, VaultDatabase::class.java, name)
                .openHelperFactory(sqlCipherFactory(passphrase))
                .build()
        }

        fun sqlCipherFactory(passphrase: ByteArray): SupportSQLiteOpenHelper.Factory =
            SupportOpenHelperFactory(passphrase)
    }
}
