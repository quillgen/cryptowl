-- ============================================================================
-- cryptowl — Moments feature schema (Confidential / C tier)
-- ----------------------------------------------------------------------------
-- Feature tables only. Built on top of the encryption core in schema.sql
-- (t_wrapped_key, t_data_encrypt_key, t_encrypted_data, t_file) — the vault
-- plumbing is NOT re-implemented here. Design: docs/moments.md.
--
-- Conventions (inherited from schema.sql):
--   * CHAR(36) UUID primary keys (TEXT in Room), INTEGER epoch-ms timestamps (UTC)
--   * soft delete via deleted_at; queries filter deleted_at IS NULL
--   * AAD binding: every AES-256-GCM operation binds the media row id as AAD
--     (whole-file AND per-chunk), preventing ciphertext-swap attacks
--   * C tier only: no per-item DEKs — record content is plaintext inside the
--     SQLCipher DB (L0/L1); media files are encrypted with FEK =
--     HKDF-SHA256(VaultKey, info="file") per design.md §File Encryption by Tier
--   * encrypted_data_id columns are reserved for a future S/T escalation and
--     are always NULL while a moment is C tier
--
-- Media file format (CWO1, see docs/moments.md §4):
--   whole-file (images/thumbnails/covers): b"CWO1" u16(1) u32(0) nonce(12)
--                                           || GCM(FEK, data, AAD=row id) || tag(16)
--   chunked (video/audio): b"CWO1" u16(1) u32(65536) u64(count) iv_prefix(4)
--                          || GCM(FEK, chunk N, nonce = u64(N)||iv_prefix) || tag(16)
--   record N starts at 22 + N * (chunk_size + 16)  -> random-access streaming
--
-- Application: execute alongside the core schema in RoomDatabase.Callback
-- (triggers included); the Room @Database version owns migration numbering.
-- ============================================================================

PRAGMA foreign_keys = ON;
PRAGMA secure_delete = ON;

-- ---------------------------------------------------------------------------
-- A moment (post). `type` mirrors WeChat content types so imports map 1:1.
-- Everything is C tier: content lives as plaintext columns inside the
-- SQLCipher-encrypted DB; only media bytes on disk are additionally FEK-
-- encrypted. `source_id` (WeChat feed id) is the idempotent re-import key.
-- ---------------------------------------------------------------------------
CREATE TABLE t_moment (
    id                   CHAR(36) NOT NULL PRIMARY KEY,
    classification       CHAR(1)  NOT NULL DEFAULT 'C'
                         CHECK (classification IN ('C', 'S', 'T')),
    type                 TEXT     NOT NULL
                         CHECK (type IN ('text', 'media', 'link', 'location',
                                         'music', 'note', 'mini_program', 'live')),
    author_name          TEXT,                 -- L0 display name (e.g. 三行)
    author_username      TEXT,                 -- L0 original wxid
    author_avatar_filename TEXT,               -- FEK-encrypted avatar in attachments/ (optional)
    content              TEXT,                 -- L1 body (C tier: plaintext in SQLCipher)
    encrypted_data_id    CHAR(36),             -- NULL at C tier; S/T escalation only
    location             TEXT,                 -- L0 JSON: {"lat":..,"lng":..,"poi_name":..}
    visibility           TEXT     NOT NULL DEFAULT 'private'
                         CHECK (visibility IN ('private', 'friends')),
    source_id            TEXT     UNIQUE,      -- original WeChat feed id (import dedup)
    source_created_at    INTEGER,              -- original timeline ts, epoch ms (timeline sort)
    like_count           INTEGER  NOT NULL DEFAULT 0,
    comment_count        INTEGER  NOT NULL DEFAULT 0,
    created_at           INTEGER  NOT NULL,
    updated_at           INTEGER  NOT NULL,
    deleted_at           INTEGER,
    FOREIGN KEY (encrypted_data_id) REFERENCES t_encrypted_data (id)
);

CREATE INDEX index_t_moment_source_created ON t_moment (source_created_at DESC);
CREATE INDEX index_t_moment_visibility ON t_moment (visibility);

-- ---------------------------------------------------------------------------
-- Rich cards: link / video_link / finder(视频号) / music / mini_program /
-- live / note. Same shape for all types; finder adds channel author fields.
-- C tier: all columns L0/L1 inside SQLCipher; covers are FEK-encrypted files.
-- ---------------------------------------------------------------------------
CREATE TABLE t_moment_card (
    id                     CHAR(36) NOT NULL PRIMARY KEY,
    moment_id              CHAR(36) NOT NULL,
    card_type              TEXT     NOT NULL
                           CHECK (card_type IN ('link', 'video_link', 'finder',
                                                'music', 'mini_program', 'live',
                                                'note')),
    title                  TEXT,
    description            TEXT,               -- e.g. "UP主: 正在新闻"
    source_name            TEXT,               -- e.g. 哔哩哔哩 / 腾讯新闻
    url                    TEXT,
    thumb_filename         TEXT,               -- FEK-encrypted cover in attachments/
    author_name            TEXT,               -- finder account (e.g. 云博优)
    author_avatar_filename TEXT,
    extra                  TEXT,               -- JSON: appid/path for mini_program
    created_at             INTEGER  NOT NULL,
    updated_at             INTEGER  NOT NULL,
    deleted_at             INTEGER,
    FOREIGN KEY (moment_id) REFERENCES t_moment (id) ON DELETE CASCADE
);

CREATE INDEX index_t_moment_card_moment ON t_moment_card (moment_id);

-- ---------------------------------------------------------------------------
-- Media attachments (photos / videos / audio).
--   filename           : '<uuid>.cwo' in <vault>/attachments/ — always
--                        FEK-encrypted (CWO1 header carries nonce/chunking;
--                        AAD = row id), never a plaintext path on disk
--   thumbnail_filename : '<uuid>_t.cwo' in <vault>/thumbnails/ — whole-file
--                        CWO1 with the same FEK (canonical: thumbnails share
--                        the original's key); always an image, even for video
--   No dek_id: C tier has no per-item DEKs (schema.sql: dek_id IS NULL = FEK)
-- ---------------------------------------------------------------------------
CREATE TABLE t_moment_media (
    id                 CHAR(36) NOT NULL PRIMARY KEY,
    moment_id          CHAR(36) NOT NULL,
    media_type         TEXT     NOT NULL CHECK (media_type IN ('image', 'video', 'audio')),
    classification     CHAR(1)  NOT NULL DEFAULT 'C'
                       CHECK (classification IN ('C', 'S', 'T')),
    filename           TEXT     NOT NULL,      -- '<uuid>.cwo' in attachments/
    original_name      TEXT,                   -- display-only original file name
    mime_type          TEXT,
    size_bytes         INTEGER,
    width              INTEGER,
    height             INTEGER,
    duration_ms        INTEGER,
    thumbnail_filename TEXT,                   -- '<uuid>_t.cwo' in thumbnails/
    sort_order         INTEGER  NOT NULL DEFAULT 0,
    created_at         INTEGER  NOT NULL,
    updated_at         INTEGER  NOT NULL,
    deleted_at         INTEGER,
    FOREIGN KEY (moment_id) REFERENCES t_moment (id) ON DELETE CASCADE
);

CREATE INDEX index_t_moment_media_moment ON t_moment_media (moment_id, sort_order);

-- ---------------------------------------------------------------------------
-- Comments. Reply threading via parent_id (NULL = top-level); WeChat
-- "withdrawn" comments import as deleted_at rows (threading preserved).
-- C tier: content is plaintext inside SQLCipher.
-- ---------------------------------------------------------------------------
CREATE TABLE t_moment_comment (
    id                  CHAR(36) NOT NULL PRIMARY KEY,
    moment_id           CHAR(36) NOT NULL,
    parent_id           CHAR(36),              -- NULL = top-level, else reply target
    author_name         TEXT,
    author_username     TEXT,
    content             TEXT,                  -- L1 text
    encrypted_data_id   CHAR(36),              -- NULL at C tier
    classification      CHAR(1)  NOT NULL DEFAULT 'C'
                        CHECK (classification IN ('C', 'S', 'T')),
    created_at          INTEGER  NOT NULL,
    deleted_at          INTEGER,
    FOREIGN KEY (moment_id) REFERENCES t_moment (id) ON DELETE CASCADE,
    FOREIGN KEY (parent_id) REFERENCES t_moment_comment (id),
    FOREIGN KEY (encrypted_data_id) REFERENCES t_encrypted_data (id)
);

CREATE INDEX index_t_moment_comment_moment ON t_moment_comment (moment_id, created_at);

-- ---------------------------------------------------------------------------
-- Likes (one per moment + user, matching WeChat semantics).
-- ---------------------------------------------------------------------------
CREATE TABLE t_moment_like (
    moment_id        CHAR(36) NOT NULL,
    author_username  TEXT     NOT NULL,
    author_name      TEXT,
    created_at       INTEGER  NOT NULL,
    PRIMARY KEY (moment_id, author_username),
    FOREIGN KEY (moment_id) REFERENCES t_moment (id) ON DELETE CASCADE
);

CREATE INDEX index_t_moment_like_author ON t_moment_like (author_username);

-- ---------------------------------------------------------------------------
-- Virtual friends (future: on-device AI agents; today: placeholders).
-- Enforcement is app-layer only — this is a personal vault, not a multi-
-- party trust boundary.
-- ---------------------------------------------------------------------------
CREATE TABLE t_friend (
    id          CHAR(36) NOT NULL PRIMARY KEY,
    kind        TEXT     NOT NULL CHECK (kind IN ('ai', 'human')),
    name        TEXT     NOT NULL,             -- display name
    model_id    TEXT,                          -- AI: local model id
    role_prompt TEXT,                          -- AI: persona/role description (L1)
    is_active   INTEGER  NOT NULL DEFAULT 1,
    created_at  INTEGER  NOT NULL,
    updated_at  INTEGER  NOT NULL,
    deleted_at  INTEGER
);

-- ---------------------------------------------------------------------------
-- Per-friend share grants/overrides for a moment.
-- Effective access = friend active AND not revoked AND
--                    (moment.visibility='friends' OR explicit grant row).
-- scope 'redacted' = friend views the redacted projection (no location,
-- author identity, URLs; app-layer policy, see docs/moments.md §5).
-- ---------------------------------------------------------------------------
CREATE TABLE t_moment_share (
    friend_id  CHAR(36) NOT NULL,
    moment_id  CHAR(36) NOT NULL,
    scope      TEXT     NOT NULL DEFAULT 'full'
               CHECK (scope IN ('full', 'redacted')),
    granted_at INTEGER  NOT NULL,
    revoked_at INTEGER,
    PRIMARY KEY (friend_id, moment_id),
    FOREIGN KEY (friend_id) REFERENCES t_friend (id) ON DELETE CASCADE,
    FOREIGN KEY (moment_id) REFERENCES t_moment (id) ON DELETE CASCADE
);

CREATE INDEX index_t_moment_share_moment ON t_moment_share (moment_id);

-- ---------------------------------------------------------------------------
-- Denormalized counters on t_moment, kept in sync by triggers.
-- ---------------------------------------------------------------------------
CREATE TRIGGER trigger_moment_like_ai AFTER INSERT ON t_moment_like
BEGIN
    UPDATE t_moment SET like_count = like_count + 1
    WHERE id = NEW.moment_id;
END;

CREATE TRIGGER trigger_moment_like_ad AFTER DELETE ON t_moment_like
BEGIN
    UPDATE t_moment SET like_count = MAX(0, like_count - 1)
    WHERE id = OLD.moment_id;
END;

CREATE TRIGGER trigger_moment_comment_ai AFTER INSERT ON t_moment_comment
BEGIN
    UPDATE t_moment SET comment_count = comment_count + 1
    WHERE id = NEW.moment_id;
END;

CREATE TRIGGER trigger_moment_comment_ad AFTER UPDATE OF deleted_at ON t_moment_comment
WHEN NEW.deleted_at IS NOT NULL AND OLD.deleted_at IS NULL
BEGIN
    UPDATE t_moment SET comment_count = MAX(0, comment_count - 1)
    WHERE id = OLD.moment_id;
END;
