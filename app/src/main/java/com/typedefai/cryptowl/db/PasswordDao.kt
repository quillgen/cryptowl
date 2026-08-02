package com.typedefai.cryptowl.db

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import androidx.room.Update
import kotlinx.coroutines.flow.Flow

@Dao
interface PasswordDao {

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun upsert(password: Password)

    @Update
    suspend fun update(password: Password)

    @Query("DELETE FROM t_password WHERE id = :id")
    suspend fun delete(id: String)

    @Query("SELECT * FROM t_password WHERE id = :id")
    suspend fun findById(id: String): Password?

    @Query("SELECT * FROM t_password WHERE deleted_at IS NULL ORDER BY updated_at DESC")
    fun observeAll(): Flow<List<Password>>
}
