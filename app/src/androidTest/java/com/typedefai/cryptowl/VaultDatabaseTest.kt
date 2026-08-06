package com.typedefai.cryptowl

import android.content.Context
import android.database.sqlite.SQLiteException
import androidx.test.core.app.ApplicationProvider
import androidx.test.ext.junit.runners.AndroidJUnit4
import com.typedefai.cryptowl.crypto.Argon2
import com.typedefai.cryptowl.db.Password
import com.typedefai.cryptowl.db.VaultDatabase
import kotlinx.coroutines.flow.first
import kotlinx.coroutines.runBlocking
import org.junit.After
import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertNotNull
import org.junit.Assert.assertTrue
import org.junit.Before
import org.junit.Test
import org.junit.runner.RunWith

@RunWith(AndroidJUnit4::class)
class VaultDatabaseTest {

    private lateinit var context: Context
    private val dbName = "vault-test.db"
    private val passphrase = "correct horse battery staple".toByteArray()

    @Before
    fun setUp() {
        context = ApplicationProvider.getApplicationContext()
        context.deleteDatabase(dbName)
    }

    @After
    fun tearDown() {
        context.deleteDatabase(dbName)
    }

    private fun password(id: String = "00000000-0000-0000-0000-000000000001") = Password(
        id = id,
        classification = "S",
        title = "Gmail",
        encryptedDataId = "00000000-0000-0000-0000-0000000000aa",
        expireTime = null,
        createdAt = 1L,
        updatedAt = 1L,
    )

    @Test
    fun insertAndQueryRoundTrip() = runBlocking {
        val db = VaultDatabase.create(context, dbName, passphrase)
        db.passwordDao().upsert(password())

        val items = db.passwordDao().observeAll().first()
        assertEquals(1, items.size)
        assertEquals("Gmail", items[0].title)
        assertEquals("S", items[0].classification)
        db.close()
    }

    @Test
    fun dataPersistsAfterReopen() = runBlocking {
        val first = VaultDatabase.create(context, dbName, passphrase)
        first.passwordDao().upsert(password())
        first.close()

        val reopened = VaultDatabase.create(context, dbName, passphrase)
        val item = reopened.passwordDao().findById("00000000-0000-0000-0000-000000000001")
        assertNotNull(item)
        assertEquals("Gmail", item?.title)
        reopened.close()
    }

    @Test
    fun updateAndDelete() = runBlocking {
        val db = VaultDatabase.create(context, dbName, passphrase)
        db.passwordDao().upsert(password())
        db.passwordDao().upsert(password().copy(title = "Gmail (work)", updatedAt = 2L))

        assertEquals("Gmail (work)", db.passwordDao().findById(password().id)?.title)

        db.passwordDao().delete(password().id)
        assertEquals(null, db.passwordDao().findById(password().id))
        db.close()
    }

    @Test
    fun databaseFileIsEncrypted() = runBlocking {
        val db = VaultDatabase.create(context, dbName, passphrase)
        db.passwordDao().upsert(password())
        db.close()

        val file = context.getDatabasePath(dbName)
        assertTrue(file.exists())
        val header = file.readBytes().take(16).toByteArray()
        val plainHeader = "SQLite format 3\u0000".toByteArray()
        assertFalse(header.contentEquals(plainHeader))
    }

    @Test
    fun wrongPassphraseFails() = runBlocking {
        val db = VaultDatabase.create(context, dbName, passphrase)
        db.passwordDao().upsert(password())
        db.close()

        val wrong = VaultDatabase.create(context, dbName, "wrong passphrase".toByteArray())
        try {
            wrong.passwordDao().findById("00000000-0000-0000-0000-000000000001")
            throw AssertionError("expected SQLiteException for wrong passphrase")
        } catch (expected: SQLiteException) {
            // password fails to decrypt -> SQLite treats it as corrupt
        } finally {
            wrong.close()
        }
    }

    @Test
    fun passphraseCanBeDerivedFromArgon2() = runBlocking {
        val salt = "vault-salt".toByteArray()
        val derived = Argon2.hash(
            password = "master-password".toByteArray(),
            salt = salt,
            mCost = 19456,
            tCost = 2,
            hashLen = 32,
        ).toHexString()

        val db = VaultDatabase.create(context, dbName, derived.toByteArray())
        db.passwordDao().upsert(password())
        assertNotNull(db.passwordDao().findById(password().id))
        db.close()

        val reopened = VaultDatabase.create(context, dbName, derived.toByteArray())
        assertNotNull(reopened.passwordDao().findById(password().id))
        reopened.close()
    }

    private fun ByteArray.toHexString(): String =
        joinToString("") { "%02x".format(it.toInt() and 0xff) }
}
