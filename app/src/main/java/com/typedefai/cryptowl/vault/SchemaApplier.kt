package com.typedefai.cryptowl.vault

import android.content.Context
import net.zetetic.database.sqlcipher.SQLiteDatabase

/**
 * Executes a schema SQL asset against an open database, idempotently
 * (`CREATE ... IF NOT EXISTS`), the same way the desktop tool applies
 * `docs/moments.sql` — so a desktop-migrated vault and an Android-created
 * vault converge on the same schema.
 */
object SchemaApplier {

    fun apply(db: SQLiteDatabase, context: Context, asset: String) {
        val schema = context.assets.open(asset).bufferedReader().readText()
        val idempotent = schema
            .replace("CREATE TABLE ", "CREATE TABLE IF NOT EXISTS ")
            .replace("CREATE INDEX ", "CREATE INDEX IF NOT EXISTS ")
            .replace("CREATE TRIGGER ", "CREATE TRIGGER IF NOT EXISTS ")
        for (statement in idempotent.split(';')) {
            val trimmed = statement.trim()
            if (trimmed.isEmpty() || trimmed.startsWith("--")) continue
            db.execSQL(trimmed)
        }
    }
}
