-- ============================================================================
-- Cryptowl vault schema — encryption core (version 1)
-- ----------------------------------------------------------------------------
-- Tables for the cryptographic infrastructure only. Feature tables
-- (t_password, t_album, t_note, ...) are out of scope and add their own
-- encrypted_data references later.
--
-- Conventions
--   * Keys, ciphertext, nonces and auth tags are BLOB (raw bytes). Base32
--     TEXT encoding is only used in the vault.meta JSON, never in the DB.
--   * AAD binding (prevents ciphertext-swap attacks): every AES-256-GCM
--     operation binds its row id as AAD —
--       DEK wrap   -> t_data_encrypt_key.id
--       content    -> t_encrypted_data.id
--       file       -> t_file.id
--   * Long-term wrapped-key ids are stable labels "role:wrapper".
--   * Timestamps are INTEGER epoch milliseconds (UTC).
--   * Soft delete via deleted_at; queries filter deleted_at IS NULL.
--
-- Application
--   * Runs against a freshly created SQLCipher database whose raw key is the
--     unwrapped VaultKey (SupportOpenHelperFactory / sqlite3_key).
--   * With Room: execute these statements in RoomDatabase.Callback.onCreate
--     (Room creates room_master_table itself); keep the version in the Room
--     @Database annotation, not user_version.
--   * Raw SQLCipher: execute after open; record PRAGMA user_version = 1.
-- ============================================================================

PRAGMA foreign_keys = ON;
PRAGMA secure_delete = ON;

-- ---------------------------------------------------------------------------
-- Wrapped long-term keys, one row per wrapped copy.
-- VaultKey copies are NOT here — they live in vault.meta (bootstrap material
-- needed before the DB can be opened). roles here are everything else:
--   kek:biokey            -> KEK wrapped by BioKey (per-access, Secret tier)
--   ts_kek:biokey         -> TS-KEK wrapped by BioKey
--   top_secret_kek:ts_kek -> TopSecretKEK wrapped by TS-KEK
-- AAD = id.
-- ---------------------------------------------------------------------------
CREATE TABLE t_wrapped_key (
    id         TEXT    NOT NULL PRIMARY KEY,  -- "role:wrapper", e.g. 'kek:biokey'
    role       TEXT    NOT NULL CHECK (role IN ('kek', 'ts_kek', 'top_secret_kek')),
    wrapper    TEXT    NOT NULL CHECK (wrapper IN ('smk', 'biokey', 'ts_kek', 'kek')),
    algorithm  TEXT    NOT NULL DEFAULT 'AES-256-GCM',
    ciphertext BLOB    NOT NULL,              -- AES-256-GCM(wrapper, key, nonce, AAD = id)
    nonce      BLOB    NOT NULL,              -- 12 B
    auth_tag   BLOB    NOT NULL,              -- 16 B
    created_at INTEGER NOT NULL,
    updated_at INTEGER NOT NULL,
    deleted_at INTEGER,
    UNIQUE (role, wrapper)
);

-- ---------------------------------------------------------------------------
-- Wrapped per-item DEKs. S/T-tier records and files reference one row here
-- (a single unwrap yields the key for both the record content and its files).
-- C-tier items have no DEK — they are SQLCipher-only (files use the FEK
-- derived from VaultKey), so no row exists here.
-- AAD = id.
-- ---------------------------------------------------------------------------
CREATE TABLE t_data_encrypt_key (
    id         CHAR(36) NOT NULL PRIMARY KEY,
    algorithm  TEXT     NOT NULL DEFAULT 'AES-256-GCM',
    ciphertext BLOB     NOT NULL,             -- AES-256-GCM(KEK | TopSecretKEK, DEK, nonce, AAD = id)
    nonce      BLOB     NOT NULL,             -- 12 B
    auth_tag   BLOB     NOT NULL,             -- 16 B
    created_at INTEGER  NOT NULL,
    updated_at INTEGER  NOT NULL
);

-- ---------------------------------------------------------------------------
-- Ciphertext payloads for S/T-tier record content. One row per encrypted
-- field/record. The owning feature row (e.g. t_password) references the row
-- id here from its encrypted_data_id column.
-- AAD = id.
-- ---------------------------------------------------------------------------
CREATE TABLE t_encrypted_data (
    id         CHAR(36) NOT NULL PRIMARY KEY,
    dek_id     CHAR(36) NOT NULL REFERENCES t_data_encrypt_key (id),
    algorithm  TEXT     NOT NULL DEFAULT 'AES-256-GCM',
    content    BLOB     NOT NULL,             -- AES-256-GCM(DEK, plaintext, nonce, AAD = id)
    nonce      BLOB     NOT NULL,             -- 12 B
    auth_tag   BLOB     NOT NULL,             -- 16 B
    created_at INTEGER  NOT NULL,
    updated_at INTEGER  NOT NULL,
    deleted_at INTEGER
);

CREATE INDEX index_t_encrypted_data_dek_id ON t_encrypted_data (dek_id);

-- ---------------------------------------------------------------------------
-- Encrypted file blobs (attachments / photos / videos), all tiers.
--   C tier: dek_id IS NULL -> file key is the FEK (HKDF-SHA256(VaultKey,
--           info="file")); the blob itself is encrypted with FEK.
--   S/T:    dek_id references the owning item's DEK — same key as the
--           record content, so one unwrap yields both.
-- The ciphertext lives at <vault>/attachments/<storage_name>.
-- AAD = id.
-- ---------------------------------------------------------------------------
CREATE TABLE t_file (
    id             CHAR(36) NOT NULL PRIMARY KEY,
    dek_id         CHAR(36) REFERENCES t_data_encrypt_key (id),  -- NULL = C tier (FEK)
    classification CHAR(1)  NOT NULL CHECK (classification IN ('C', 'S', 'T')),
    storage_name   TEXT     NOT NULL,         -- '<uuid>.enc' in attachments/
    original_name  TEXT,
    mime_type      TEXT,
    size_bytes     INTEGER  NOT NULL,
    created_at     INTEGER  NOT NULL,
    updated_at     INTEGER  NOT NULL,
    deleted_at     INTEGER
);

CREATE INDEX index_t_file_dek_id ON t_file (dek_id);
CREATE INDEX index_t_file_classification ON t_file (classification);

PRAGMA user_version = 1;
