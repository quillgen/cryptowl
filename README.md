# Cryptowl (Android)

Local-first encrypted vault for Android (notes, passwords, photos/videos) — **no plaintext data at rest**. Android-native app (minSdk 36) with vendored C/C++ crypto (Argon2id via JNI) and SQLCipher-encrypted Room database.

Build/test conventions and hard-earned gotchas live in [AGENTS.md](AGENTS.md). This file documents the encryption design only.

## Encryption design

### Goals

- Nothing at rest is plaintext — neither the database file nor exported data
- Tiered access: notes are readable after login; passwords require per-access biometric auth; top-secret items additionally require a separate secondary password
- Best-practice algorithms only (Argon2id, AES-256-GCM, HKDF-SHA256, HMAC-SHA256)
- Export/backup must be encrypted and portable

### Threat model

- **Primary threat:** device loss/theft — an attacker with the storage (DB files, exported bundles) learns nothing without the master password; top-secret items additionally require biometrics
- **Explicitly out of scope:** a compromised OS, malware running while the vault is unlocked, or physical attacks on the device TEE

### Key hierarchy

Everything derives from the master password via a chain of KDF steps; item data is protected by envelope encryption (per-item keys wrapped by higher-level keys). Each access tier unwraps one extra layer.

```
vault unlock (login):
  masterPassword ──HMAC-SHA256(secretKey)──> pre-hash ──Argon2id(m=19 MiB, t=2, p=1)──> TMK
  TMK ──HKDF-SHA256(salt=masterSeed, info=instanceId)──> SMK        (in memory only)
  SMK ──AES-256-GCM──> wraps VaultKey (random)                      [stored in DB]

per-access — secret (L2) items:
  BiometricPrompt ──> Keystore BioKey ──AES-256-GCM──> wraps KEK     [stored in DB]
  KEK ──AES-256-GCM──> wraps item DEK (32 B, random)                [stored in DB]
  DEK ──AES-256-GCM──> item content (AAD = item id)                 [stored in DB]

per-access — top-secret (L3) items:
  secondaryPassword ──Argon2id(m=19 MiB, t=2, p=1)──> TS-KEK        (derived per access)
  BiometricPrompt ──> BioKey ──AES-256-GCM──> wraps TS-KEK           [stored in DB]
  TS-KEK ──AES-256-GCM──> wraps TopSecretKEK                        [stored in DB]
  TopSecretKEK ──AES-256-GCM──> wraps item DEK                      [stored in DB]
  DEK ──AES-256-GCM──> item content (AAD = item id)                 [stored in DB]
```

- **TMK** — *transformed master key*: Argon2id output. Argon2id params follow the OWASP minimum (19 MiB, 2 iterations, 1 lane) — the same settings used in the reference product and in `Argon2Test`.
- **SMK** — *stretched master key*: HKDF-SHA256 expansion of the TMK, domain-separated with `instanceId` (vault identity) and `masterSeed` (random, stored). Unwraps the **VaultKey** (L1) at login.
- **BioKey** — non-exportable Android Keystore key created with `setUserAuthenticationRequired(true)` (+ StrongBox when available). Every use requires a fresh `BiometricPrompt` prompt. Wraps the KEK (L2) and the TS-KEK (L3).
- **KEK** — random key wrapped by BioKey, unwrapped per access; unwraps L2 item DEKs. Not cached between accesses (per-access policy).
- **TS-KEK** — Argon2id output of the **secondary password** (own salt, stored). The secondary password is a separate passphrase chosen by the user for top-secret items; it is never stored and never derived from the master password, so T items are a true two-factor gate (biometric + secondary password).
- **TopSecretKEK** — random key wrapped by TS-KEK (which is itself wrapped by BioKey). Unwraps L3 item DEKs. Kept separate from the KEK so changing the secondary password only rewraps this one key.

### Encryption levels

Every item carries a classification (`C` / `S` / `T`, matching the sibling cryptowl-ref schema `t_password.classification`). Levels map to classifications and access policy:

| Level | Classification | Examples | Unlock trigger | At rest |
| --- | --- | --- | --- | --- |
| L0 | — | titles, categories, timestamps, searchable attributes | vault unlock (login) | inside SQLCipher DB only |
| L1 | `C` confidential | notes, note content, non-sensitive fields | vault unlock (login) | inside SQLCipher DB (readable after login, no extra prompt) |
| L2 | `S` secret | passwords (default), sensitive fields | **biometric prompt per access**, then KEK unwrap | AEAD ciphertext in `t_encrypted_data`; DEK wrapped by KEK |
| L3 | `T` top secret | high-value passwords, private photos/videos | **biometric prompt + secondary password per access**, then TopSecretKEK unwrap | AEAD ciphertext; DEK wrapped by TopSecretKEK |

Rules:

- L0/L1 data is plaintext *inside* the SQLCipher-encrypted database — encrypted at rest, decrypted on unlock. This is what "notes viewable after login" means; SQLCipher is the boundary.
- L2/L3 add defense-in-depth: content never exists in plaintext anywhere on disk, only transiently in memory while displayed.
- L2 access is **per-access**: KEK is unwrapped fresh for each access and not cached, so every password view requires a biometric prompt.
- L3 is two-factor: biometric (BioKey) **and** the secondary password (TS-KEK) are both required for every access.
- AAD on every AEAD operation is the ciphertext record id — prevents ciphertext-swap attacks between rows.
- Policies can be tightened later (e.g., "all passwords require biometric") without schema changes — classification is per-item.

### Algorithms

| Purpose | Algorithm | Notes |
| --- | --- | --- |
| Password KDF | Argon2id (m=19456 KiB, t=2, p=1) | OWASP minimum; JNI binding (vendored reference implementation); used for master password (TMK) and secondary password (TS-KEK), each with its own salt |
| Pre-hash | HMAC-SHA256(masterPassword, secretKey) | binds the device secret, feeds Argon2 |
| Key derivation | HKDF-SHA256 | TMK → SMK |
| Key wrapping + data | AES-256-GCM | hardware-accelerated on Android (TEE/Keystore); AAD = record id |
| Data (alternate) | XChaCha20-Poly1305 | cross-platform alternative where no hardware AES-GCM; not required on Android |
| Randomness | `SecureRandom` / Keystore-generated keys; UUIDv4 ids | |
| Encoding | Crockford Base32 | for stored nonces/tags/auth tags (ref convention) |

### Android specifics

- SQLCipher passphrase is derived from the key hierarchy (Argon2 → passphrase, see `passphraseCanBeDerivedFromArgon2` test) — never the raw master password.
- Device binding: the vault `secretKey` lives in Android Keystore (non-exportable). A backup restored onto another device requires its own device secret (see Export).
- Per-access unwrap flow (L2): `BiometricPrompt` → Keystore BioKey (`setUserAuthenticationRequired(true, duration 0)`) → KEK → item DEK → content. Nothing is cached between accesses.
- Top-secret unwrap flow (L3): prompt biometric **and** enter the secondary password → derive TS-KEK (Argon2id) → BioKey unwraps stored TS-KEK wrapper → TopSecretKEK → item DEK → content.
- Master password change = re-derive TMK/SMK, unwrap VaultKey with the old SMK, rewrap with the new SMK, then `PRAGMA rekey` the SQLCipher DB. Orthogonal to Room schema migrations.
- Secondary password change = derive new TS-KEK, unwrap TopSecretKEK with the old TS-KEK, rewrap with the new one. Only T items' key chain is touched — no item data re-encryption.

### Export / backup (planned)

- Single self-contained bundle: encrypted DB snapshot + media blobs + key-wrapping chain, wrapped by a **backup key** derived from a user-chosen backup passphrase (Argon2id + HKDF), not the master password — so a backup cannot be decrypted by vault-unlock state alone, and a master password change doesn't invalidate it.
- Versioned bundle header for forward-compatible upgrades.

### Open design items

- Photo/video: streaming/chunked AES-256-GCM (e.g., 64 KiB chunks) so large blobs are never fully in memory; chunk indices in DB
- Encrypted full-text search: FTS index trade-off (index plaintext vs tokenized ciphertext)
- Media classification defaults (`S`, user may escalate to `T`)
