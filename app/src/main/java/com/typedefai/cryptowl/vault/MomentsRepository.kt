package com.typedefai.cryptowl.vault

import net.zetetic.database.sqlcipher.SQLiteDatabase

/** Read model for the moments timeline (docs/moments.md §3). */
data class MomentPost(
    val id: String,
    val type: String,
    val authorName: String?,
    val authorUsername: String?,
    val content: String?,
    val location: String?,
    val visibility: String,
    val sourceCreatedAt: Long?,
    val likeCount: Int,
    val commentCount: Int,
    val cards: List<MomentCard> = emptyList(),
    val media: List<MomentMedia> = emptyList(),
    val comments: List<MomentComment> = emptyList(),
    val likes: List<MomentLike> = emptyList(),
) {
    val isPrivate: Boolean get() = visibility == "private"
}

data class MomentCard(
    val id: String,
    val cardType: String,
    val title: String?,
    val description: String?,
    val sourceName: String?,
    val url: String?,
    val thumbFilename: String?,
    val authorName: String?,
)

data class MomentMedia(
    val id: String,
    val mediaType: String,
    val filename: String,
    val originalName: String?,
    val mimeType: String?,
    val width: Int?,
    val height: Int?,
    val durationMs: Long?,
    val thumbnailFilename: String?,
    val sortOrder: Int,
)

data class MomentComment(
    val id: String,
    val parentId: String?,
    val authorName: String?,
    val authorUsername: String?,
    val content: String?,
    val createdAt: Long?,
)

data class MomentLike(
    val authorName: String?,
    val authorUsername: String?,
)

/**
 * Read access to the moments feature tables inside an unlocked vault.
 * C tier: everything here is L0/L1 plaintext inside the SQLCipher DB.
 */
class MomentsRepository(private val db: SQLiteDatabase) {

    /** Timeline: non-deleted moments, newest first (source timeline order). */
    fun timeline(): List<MomentPost> {
        val moments = db.rawQuery(
            """SELECT id, type, author_name, author_username, content, location,
                      visibility, source_created_at, like_count, comment_count
               FROM t_moment WHERE deleted_at IS NULL
               ORDER BY source_created_at DESC, created_at DESC""", null,
        ).use { cursor ->
            buildList {
                while (cursor.moveToNext()) {
                    add(MomentPost(
                        id = cursor.getString(0),
                        type = cursor.getString(1),
                        authorName = cursor.stringOrNull(2),
                        authorUsername = cursor.stringOrNull(3),
                        content = cursor.stringOrNull(4),
                        location = cursor.stringOrNull(5),
                        visibility = cursor.getString(6),
                        sourceCreatedAt = cursor.longOrNull(7),
                        likeCount = cursor.getInt(8),
                        commentCount = cursor.getInt(9),
                    ))
                }
            }
        }
        return moments.map { m ->
            m.copy(
                cards = cards(m.id),
                media = media(m.id),
                comments = comments(m.id),
                likes = likes(m.id),
            )
        }
    }

    fun moment(id: String): MomentPost? =
        timeline().firstOrNull { it.id == id }

    private fun cards(momentId: String): List<MomentCard> = db.rawQuery(
        """SELECT id, card_type, title, description, source_name, url,
                  thumb_filename, author_name
           FROM t_moment_card WHERE moment_id = ? AND deleted_at IS NULL
           ORDER BY created_at""",
        arrayOf(momentId),
    ).use { cursor ->
        buildList {
            while (cursor.moveToNext()) {
                add(MomentCard(
                    id = cursor.getString(0),
                    cardType = cursor.getString(1),
                    title = cursor.stringOrNull(2),
                    description = cursor.stringOrNull(3),
                    sourceName = cursor.stringOrNull(4),
                    url = cursor.stringOrNull(5),
                    thumbFilename = cursor.stringOrNull(6),
                    authorName = cursor.stringOrNull(7),
                ))
            }
        }
    }

    private fun media(momentId: String): List<MomentMedia> = db.rawQuery(
        """SELECT id, media_type, filename, original_name, mime_type, width,
                  height, duration_ms, thumbnail_filename, sort_order
           FROM t_moment_media WHERE moment_id = ? AND deleted_at IS NULL
           ORDER BY sort_order""",
        arrayOf(momentId),
    ).use { cursor ->
        buildList {
            while (cursor.moveToNext()) {
                add(MomentMedia(
                    id = cursor.getString(0),
                    mediaType = cursor.getString(1),
                    filename = cursor.getString(2),
                    originalName = cursor.stringOrNull(3),
                    mimeType = cursor.stringOrNull(4),
                    width = cursor.intOrNull(5),
                    height = cursor.intOrNull(6),
                    durationMs = cursor.longOrNull(7),
                    thumbnailFilename = cursor.stringOrNull(8),
                    sortOrder = cursor.getInt(9),
                ))
            }
        }
    }

    private fun comments(momentId: String): List<MomentComment> = db.rawQuery(
        """SELECT id, parent_id, author_name, author_username, content, created_at
           FROM t_moment_comment WHERE moment_id = ? AND deleted_at IS NULL
           ORDER BY created_at""",
        arrayOf(momentId),
    ).use { cursor ->
        buildList {
            while (cursor.moveToNext()) {
                add(MomentComment(
                    id = cursor.getString(0),
                    parentId = cursor.stringOrNull(1),
                    authorName = cursor.stringOrNull(2),
                    authorUsername = cursor.stringOrNull(3),
                    content = cursor.stringOrNull(4),
                    createdAt = cursor.longOrNull(5),
                ))
            }
        }
    }

    private fun likes(momentId: String): List<MomentLike> = db.rawQuery(
        "SELECT author_name, author_username FROM t_moment_like WHERE moment_id = ?",
        arrayOf(momentId),
    ).use { cursor ->
        buildList {
            while (cursor.moveToNext()) {
                add(MomentLike(
                    authorName = cursor.stringOrNull(0),
                    authorUsername = cursor.stringOrNull(1),
                ))
            }
        }
    }

    private fun android.database.Cursor.stringOrNull(index: Int): String? =
        if (isNull(index)) null else getString(index)

    private fun android.database.Cursor.longOrNull(index: Int): Long? =
        if (isNull(index)) null else getLong(index)

    private fun android.database.Cursor.intOrNull(index: Int): Int? =
        if (isNull(index)) null else getInt(index)
}
