-- ============================================================================
-- cryptowl — encrypted vault schema (moments edition)
--
-- Everything is re-implemented: this file is self-contained and owns the full
-- encryption plumbing + the moments domain model.
--
-- Conventions:
--   * t_* table names, CHAR(36) UUID primary keys
--   * classification C/S/T per item; SQLCipher is the L1 at-rest boundary
--   * soft delete via deleted_at
--   * AES-256-GCM everywhere, AAD = record id on every AEAD operation
--   * media files on disk are ALWAYS encrypted (whole-file GCM for images,
--     chunked 64 KiB GCM for video/audio); nothing plaintext at rest
--
-- Key hierarchy (see README):
--   masterPassword -> HMAC-SHA256(secretKey) -> Argon2id -> TMK
--   TMK -> HKDF-SHA256(master_seed, info=instanceId) -> SMK   (in memory)
--   SMK wraps VaultKey                          [t_wrapped_key 'vault']
--   BioKey wraps KEK  (L2)                      [t_wrapped_key 'kek']
--   BioKey wraps TS-KEK, TS-KEK wraps TopSecretKEK (L3)  [t_wrapped_key]
--   KEK / TopSecretKEK wraps per-item DEKs      [t_data_encrypt_key]
--   DEK encrypts content / files                [t_encrypted_data / files]
-- ============================================================================

-- ----------------------------------------------------------------------------
-- 1. Vault identity + KDF parameters (one row)
-- ----------------------------------------------------------------------------
CREATE TABLE t_vault (
    id                 TEXT    NOT NULL PRIMARY KEY,   -- instanceId (UUID)
    master_salt        BLOB    NOT NULL,               -- Argon2id salt (master pw)
    master_seed        BLOB    NOT NULL,               -- HKDF salt (masterSeed)
    secondary_salt     BLOB,                           -- Argon2id salt (secondary pw), NULL until set
    argon2_memory_kib  INTEGER NOT NULL DEFAULT 19456,
    argon2_iterations  INTEGER NOT NULL DEFAULT 2,
    argon2_lanes       INTEGER NOT NULL DEFAULT 1,
    created_at         DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at         DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- ----------------------------------------------------------------------------
-- 2. Vault-level wrapped keys
--    parent: smk (unlocked at login) | biokey (per-access biometric) | ts_kek
-- ----------------------------------------------------------------------------
CREATE TABLE t_wrapped_key (
    id           TEXT    NOT NULL PRIMARY KEY,   -- role: 'vault' | 'kek' | 'ts_kek' | 'top_secret'
    parent       TEXT    NOT NULL CHECK (parent IN ('smk','biokey','ts_kek')),
    algorithm_id TEXT    NOT NULL DEFAULT 'AES-256-GCM',
    wrapped_data BLOB    NOT NULL,
    nonce        BLOB    NOT NULL,
    auth_tag     BLOB    NOT NULL,                -- AAD = row id
    created_at   DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at   DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted_at   DATETIME DEFAULT NULL
);

-- ----------------------------------------------------------------------------
-- 3. Per-item data encryption keys (DEKs), wrapped by a tier key
--    wrapping: 'vault' (C items, unwrapped at login)
--              'kek' (S items, per-access biometric)
--              'top_secret' (T items, biometric + secondary password)
-- ----------------------------------------------------------------------------
CREATE TABLE t_data_encrypt_key (
    id           CHAR(36) NOT NULL PRIMARY KEY,
    classification CHAR(1) NOT NULL CHECK (classification IN ('C','S','T')),
    wrapping     TEXT     NOT NULL CHECK (wrapping IN ('vault','kek','top_secret')),
    algorithm_id TEXT     NOT NULL DEFAULT 'AES-256-GCM',
    wrapped_data BLOB     NOT NULL,
    nonce        BLOB     NOT NULL,
    auth_tag     BLOB     NOT NULL,                -- AAD = row id
    created_at   DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at   DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted_at   DATETIME DEFAULT NULL
);
CREATE INDEX idx_dek_wrapping ON t_data_encrypt_key(wrapping);

-- ----------------------------------------------------------------------------
-- 4. AEAD payloads (small content: moment body, comments, thumbnails of S/T)
--    AAD = row id (anti ciphertext-swap)
-- ----------------------------------------------------------------------------
CREATE TABLE t_encrypted_data (
    id           CHAR(36) NOT NULL PRIMARY KEY,
    dek_id       CHAR(36) NOT NULL,
    algorithm_id TEXT     NOT NULL DEFAULT 'AES-256-GCM',
    content      BLOB     NOT NULL,                -- ciphertext
    nonce        BLOB     NOT NULL,
    auth_tag     BLOB     NOT NULL,
    created_at   DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at   DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted_at   DATETIME DEFAULT NULL,
    FOREIGN KEY (dek_id) REFERENCES t_data_encrypt_key(id)
);
CREATE INDEX idx_encrypted_data_dek ON t_encrypted_data(dek_id);

-- ============================================================================
-- Moments domain model
-- ============================================================================

-- ----------------------------------------------------------------------------
-- a moment (post). `type` drives rendering; content is C by default.
-- ----------------------------------------------------------------------------
CREATE TABLE t_moment (
    id                CHAR(36) NOT NULL PRIMARY KEY,
    classification    CHAR(1)  NOT NULL CHECK (classification IN ('C','S','T')),
    type              TEXT     NOT NULL
                      CHECK (type IN ('text','media','link','location',
                                      'music','note','mini_program','live')),
    author_name       TEXT,                 -- L0 display name (红尘一人 / 云博优)
    author_username   TEXT,                 -- L0 original wxid
    author_avatar_filename TEXT,            -- L0 avatar file (optional)
    content           TEXT,                 -- L1 text body (NULL when classification > C)
    encrypted_data_id CHAR(36),             -- L2/L3 content payload
    location          TEXT,                 -- L0 JSON: {"lat":..,"lng":..,"poi_name":..}
    is_private        INTEGER NOT NULL DEFAULT 0,
    source_id         TEXT UNIQUE,          -- original WeChat feed id (import dedup)
    source_created_at INTEGER,              -- original unix ts (timeline sort)
    like_count        INTEGER NOT NULL DEFAULT 0,
    comment_count     INTEGER NOT NULL DEFAULT 0,
    extra             TEXT,                 -- JSON, reserved for future types
    created_at        DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at        DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted_at        DATETIME DEFAULT NULL,
    FOREIGN KEY (encrypted_data_id) REFERENCES t_encrypted_data(id)
);
CREATE INDEX idx_moment_source_created ON t_moment(source_created_at DESC);

-- ----------------------------------------------------------------------------
-- rich cards: link / video_link / finder(视频号) / music / mini_program /
-- live / note. Same shape; finder adds author_name/author_avatar.
-- ----------------------------------------------------------------------------
CREATE TABLE t_moment_card (
    id          CHAR(36) NOT NULL PRIMARY KEY,
    moment_id   CHAR(36) NOT NULL,
    card_type   TEXT     NOT NULL
                CHECK (card_type IN ('link','video_link','finder','music',
                                     'mini_program','live','note')),
    title       TEXT,
    description TEXT,                       -- e.g. "UP主: 正在新闻"
    source_name TEXT,                       -- 哔哩哔哩 / 腾讯新闻
    url         TEXT,
    thumb_filename TEXT,
    author_name TEXT,                       -- finder account (云博优)
    author_avatar_filename TEXT,
    extra       TEXT,                       -- JSON: appid/path for mini_program
    created_at  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted_at  DATETIME DEFAULT NULL,
    FOREIGN KEY (moment_id) REFERENCES t_moment(id) ON DELETE CASCADE
);
CREATE INDEX idx_moment_card_moment ON t_moment_card(moment_id);

-- ----------------------------------------------------------------------------
-- media attachments.
--   filename        : encrypted file on disk (never plaintext)
--   chunk_size NULL : whole-file GCM (images) — nonce in file header
--   chunk_size 65536: chunked GCM (video/audio) — counter nonces
--                     (8-byte chunk index || 4-byte iv_prefix); fixed chunk
--                     records => offset(N) = 22 + N * 65552, random access
--                     streaming without DB lookups
--   thumbnail       : BLOB plaintext-in-SQLCipher for C items
--   thumbnail_encrypted_data_id : S/T items — thumb encrypted with media DEK
--   encrypted_dek_id: per-file DEK, wrapped per classification tier
-- ----------------------------------------------------------------------------
CREATE TABLE t_moment_media (
    id             CHAR(36) NOT NULL PRIMARY KEY,
    moment_id      CHAR(36) NOT NULL,
    media_type     TEXT     NOT NULL CHECK (media_type IN ('image','video','audio')),
    classification CHAR(1)  NOT NULL DEFAULT 'C'
                   CHECK (classification IN ('C','S','T')),
    filename       TEXT     NOT NULL,       -- encrypted file on disk
    mime_type      TEXT,
    file_size      INTEGER,
    width          INTEGER,
    height         INTEGER,
    duration_ms    INTEGER,
    chunk_size     INTEGER,                 -- NULL = whole-file GCM; else 65536
    chunk_count    INTEGER,
    iv_prefix      BLOB,                    -- 4-byte random prefix (chunk nonces)
    thumbnail      BLOB,                    -- C items: thumbnail bytes
    thumbnail_encrypted_data_id CHAR(36),   -- S/T items: encrypted thumbnail
    encrypted_dek_id CHAR(36) NOT NULL,     -- wrapped DEK (t_data_encrypt_key)
    sort_order     INTEGER NOT NULL DEFAULT 0,
    created_at     DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at     DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted_at     DATETIME DEFAULT NULL,
    FOREIGN KEY (moment_id) REFERENCES t_moment(id) ON DELETE CASCADE,
    FOREIGN KEY (thumbnail_encrypted_data_id) REFERENCES t_encrypted_data(id),
    FOREIGN KEY (encrypted_dek_id) REFERENCES t_data_encrypt_key(id)
);
CREATE INDEX idx_moment_media_moment ON t_moment_media(moment_id, sort_order);

-- ----------------------------------------------------------------------------
-- comments. 回复 threading via parent_id; withdrawn = deleted_at.
-- ----------------------------------------------------------------------------
CREATE TABLE t_moment_comment (
    id             CHAR(36) NOT NULL PRIMARY KEY,
    moment_id      CHAR(36) NOT NULL,
    parent_id      CHAR(36),                -- NULL = top-level, else reply target
    author_name    TEXT,
    author_username TEXT,
    content        TEXT,                    -- L1 text
    encrypted_data_id CHAR(36),             -- L2/L3 comment
    classification CHAR(1) NOT NULL DEFAULT 'C'
                   CHECK (classification IN ('C','S','T')),
    created_at     DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted_at     DATETIME DEFAULT NULL,
    FOREIGN KEY (moment_id) REFERENCES t_moment(id) ON DELETE CASCADE,
    FOREIGN KEY (parent_id) REFERENCES t_moment_comment(id),
    FOREIGN KEY (encrypted_data_id) REFERENCES t_encrypted_data(id)
);
CREATE INDEX idx_moment_comment_moment ON t_moment_comment(moment_id, created_at);

-- ----------------------------------------------------------------------------
-- likes (unique per moment + user)
-- ----------------------------------------------------------------------------
CREATE TABLE t_moment_like (
    moment_id      CHAR(36) NOT NULL,
    author_username TEXT NOT NULL,
    author_name    TEXT,
    created_at     DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (moment_id, author_username),
    FOREIGN KEY (moment_id) REFERENCES t_moment(id) ON DELETE CASCADE
);

-- ----------------------------------------------------------------------------
-- denormalized counters (kept in sync by triggers)
-- ----------------------------------------------------------------------------
CREATE TRIGGER trg_moment_like_ai AFTER INSERT ON t_moment_like
BEGIN
    UPDATE t_moment SET like_count = like_count + 1, updated_at = CURRENT_TIMESTAMP
    WHERE id = NEW.moment_id;
END;

CREATE TRIGGER trg_moment_like_ad AFTER DELETE ON t_moment_like
BEGIN
    UPDATE t_moment SET like_count = MAX(0, like_count - 1), updated_at = CURRENT_TIMESTAMP
    WHERE id = OLD.moment_id;
END;

CREATE TRIGGER trg_moment_comment_ai AFTER INSERT ON t_moment_comment
BEGIN
    UPDATE t_moment SET comment_count = comment_count + 1, updated_at = CURRENT_TIMESTAMP
    WHERE id = NEW.moment_id;
END;

CREATE TRIGGER trg_moment_comment_ad AFTER UPDATE OF deleted_at ON t_moment_comment
WHEN NEW.deleted_at IS NOT NULL AND OLD.deleted_at IS NULL
BEGIN
    UPDATE t_moment SET comment_count = MAX(0, comment_count - 1), updated_at = CURRENT_TIMESTAMP
    WHERE id = NEW.moment_id;
END;
