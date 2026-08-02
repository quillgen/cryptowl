package com.riguz.cryptowl.db

import androidx.room.ColumnInfo
import androidx.room.Entity
import androidx.room.Index
import androidx.room.PrimaryKey

/** Mirrors the `t_password` table of the cryptowl-ref (Flutter) schema. */
@Entity(
    tableName = "t_password",
    indices = [Index("category_id"), Index("encrypted_data_id")],
)
data class Password(
    @PrimaryKey val id: String,
    val type: Int = 1,
    @ColumnInfo(name = "category_id") val categoryId: Int = 1,
    /** 'C' (confidential), 'S' (secret), 'T' (top secret). */
    val classification: String,
    val title: String?,
    @ColumnInfo(name = "encrypted_data_id") val encryptedDataId: String,
    @ColumnInfo(name = "expire_time") val expireTime: Long?,
    @ColumnInfo(name = "created_at") val createdAt: Long,
    @ColumnInfo(name = "updated_at") val updatedAt: Long,
    @ColumnInfo(name = "deleted_at") val deletedAt: Long? = null,
)
