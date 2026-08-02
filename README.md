# Cryptowl (Android)

Local-first encrypted vault for Android (notes, passwords, photos/videos) — **no plaintext data at rest**. Android-native app (minSdk 36) with vendored C/C++ crypto (Argon2id via JNI) and SQLCipher-encrypted Room database.

Build/test conventions and hard-earned gotchas live in [AGENTS.md](AGENTS.md). This file documents the encryption design only.

## Encryption design

### Goals

- Nothing at rest is plaintext — neither the database file nor exported data
- Tiered access: notes are readable after login; sensitive passwords require per-access biometric auth; the user chooses the level per item
- Best-practice algorithms only (Argon2id, AES-256-GCM, HKDF-SHA256, HMAC-SHA256)
- Export/backup must be encrypted and portable

### Threat model

- **Primary threat:** device loss/theft — an attacker with the storage (DB files, exported bundles) learns nothing without the master password; top-secret items additionally require biometrics
- **Explicitly out of scope:** a compromised OS, malware running while the vault is unlocked, or physical attacks on the device TEE

### Key hierarchy

Everything derives from the master password via a chain of KDF steps; item data is protected by envelope encryption (per-item keys wrapped by higher-level keys).

```
masterPassword ──HMAC-SHA256──> pre-hash ──Argon2id(m=19 MiB, t=2, p=1)──> TMK
secretKey (device, Android Keystore) ────────────────────────────────────────┘

TMK ──HKDF-SHA256(salt=masterSeed, info=instanceId)──> SMK   (in memory only)

SMK ──AES-256-GCM──> wraps KEK (64 B, random)                    [stored in DB]
KEK ──AES-256-GCM──> wraps per-item DEK (32 B, random)           [stored in DB]
DEK ──AES-256-GCM──> item content (AAD = item id)                [stored in DB]

TopSecretKEK (Keystore, biometric-gated) ──> wraps DEKs of top-secret items
```

- **TMK** — *transformed master key*: Argon2id output. Argon2id params follow the OWASP minimum (19 MiB, 2 iterations, 1 lane) — the same settings used in the reference product and in `Argon2Test`.
- **SMK** — *stretched master key*: HKDF-SHA256 expansion of the TMK, domain-separated with `instanceId` (vault identity) and `masterSeed` (random, stored). Makes the vault re-derivable only for its own instance.
- **KEK** — 64-byte random *key encryption key*, wrapped by the SMK and stored. Unwraps per-item data encryption keys. Available after login (session key).
- **TopSecretKEK** — wrapped by a **non-exportable Android Keystore key** created with `setUserAuthenticationRequired(true)` (+ StrongBox when available). Every unwrap requires a fresh `BiometricPrompt` prompt — this is the "additional auth each time" gate.

### Encryption levels

Every item carries a classification (`C` / `S` / `T`, matching the sibling cryptowl-ref schema `t_password.classification`). Levels map to classifications and access policy:

| Level | Classification | Examples | Unlock trigger | At rest |
| --- | --- | --- | --- | --- |
| L0 | — | titles, categories, timestamps, searchable attributes | vault unlock (login) | inside SQLCipher DB only |
| L1 | `C` confidential | notes, note content, non-sensitive fields | vault unlock | inside SQLCipher DB (readable after login, no extra prompt) |
| L2 | `S` secret | passwords (default), sensitive fields | vault unlock (KEK unwrap, no extra prompt) | AEAD ciphertext in `t_encrypted_data`; DEK wrapped by KEK |
| L3 | `T` top secret | high-value passwords, private photos/videos | **biometric prompt per access** | AEAD ciphertext; DEK wrapped by biometric-gated TopSecretKEK |

Rules:

- L0/L1 data is plaintext *inside* the SQLCipher-encrypted database — encrypted at rest, decrypted on unlock. This is what "notes viewable after login" means; SQLCipher is the boundary.
- L2/L3 add defense-in-depth: content never exists in plaintext anywhere on disk, only transiently in memory while displayed.
- AAD on every AEAD operation is the ciphertext record id — prevents ciphertext-swap attacks between rows.
- Policies can be tightened later (e.g., "all passwords require biometric") without schema changes — classification is per-item.

### Algorithms

| Purpose | Algorithm | Notes |
| --- | --- | --- |
| Password KDF | Argon2id (m=19456 KiB, t=2, p=1) | OWASP minimum; JNI binding (vendored reference implementation) |
| Pre-hash | HMAC-SHA256(masterPassword, secretKey) | binds the device secret, feeds Argon2 |
| Key derivation | HKDF-SHA256 | TMK → SMK |
| Key wrapping + data | AES-256-GCM | hardware-accelerated on Android (TEE/Keystore); AAD = record id |
| Data (alternate) | XChaCha20-Poly1305 | cross-platform alternative where no hardware AES-GCM; not required on Android |
| Randomness | `SecureRandom` / Keystore-generated keys; UUIDv4 ids | |
| Encoding | Crockford Base32 | for stored nonces/tags/auth tags (ref convention) |

### Android specifics

- SQLCipher passphrase is derived from the key hierarchy (Argon2 → passphrase, see `passphraseCanBeDerivedFromArgon2` test) — never the raw master password.
- Device binding: the vault `secretKey` lives in Android Keystore (non-exportable). A backup restored onto another device requires its own device secret (see Export).
- Master password change = re-derive TMK/SMK, unwrap KEK with the old SMK, rewrap with the new SMK, then `PRAGMA rekey` the SQLCipher DB. Orthogonal to Room schema migrations.
- Top-secret unwrap flow: `BiometricPrompt` → Keystore key (`setUserAuthenticationRequired(true, duration 0)`) → TopSecretKEK → item DEK → content.

### Export / backup (planned)

- Single self-contained bundle: encrypted DB snapshot + media blobs + key-wrapping chain, wrapped by a **backup key** derived from a user-chosen backup passphrase (Argon2id + HKDF), not the master password — so a backup cannot be decrypted by vault-unlock state alone, and a master password change doesn't invalidate it.
- Versioned bundle header for forward-compatible upgrades.

### Open design items

- Photo/video: streaming/chunked AES-256-GCM (e.g., 64 KiB chunks) so large blobs are never fully in memory; chunk indices in DB
- Encrypted full-text search: FTS index trade-off (index plaintext vs tokenized ciphertext)
- Media classification defaults (`S`, user may escalate to `T`)
