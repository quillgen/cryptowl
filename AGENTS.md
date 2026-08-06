# AGENTS.md

Local-first encrypted vault for Android (notes, passwords, photos/videos) — no plaintext data at rest. Android-native only (minSdk 36), with vendored C/C++ crypto. Working branch: `android-native`.

**Encryption/tiering design lives in [docs/design.md](docs/design.md)** (key hierarchy, C/S/T levels, biometric gating, backup, memory protection) — consult it before adding crypto features.

**Feature designs are separate docs on top of the core**: [docs/moments.md](docs/moments.md) + [docs/moments.sql](docs/moments.sql) (Moments — Confidential-tier timeline, CWO1 media format, virtual friends). Feature tables never re-implement the core key/wrapped-key tables.

**Cross-verification oracle**: the desktop reference implementation lives in the sibling repo `wechat_sns_export/vaultlib` (Python) — byte-exact primitives and fixed test vectors (`wechat_sns_export/tests/test_vaultlib.py`). Any crypto change here must reproduce its vectors, and vice versa.

## Stack (verify against `gradle/libs.versions.toml`)

- AGP 9.3.1 + Gradle 9.5 + Java 11; **AGP 9 built-in Kotlin** — do NOT add the `kotlin-android` plugin
- KSP 2.3.10 (standalone KSP2 versioning, compatible with AGP built-in Kotlin)
- Room 2.8.4 + sqlcipher-android 4.17.0 (`@aar`) + androidx.sqlite 2.6.2
- **UI: Jetpack Compose** (Material3, compose BOM 2026.02.00) — use Compose for all UI, no View/XML layouts. Markdown rendering via `com.halilibo.compose-richtext` (richtext-commonmark + richtext-ui-material3), same as the AI Edge Gallery reference app
- JNI/CMake (CMake 3.22.1, NDK 29), vendored phc-winner-argon2 v20190702 in `app/src/main/cpp/argon2/`

## Commands

- Build: `./gradlew :app:assembleDebug` · Release: `:app:assembleRelease` (unsigned)
- Lint: `./gradlew :app:lintDebug` · JVM tests: `:app:testDebugUnitTest`
- **Instrumented tests (the real test suite): `./gradlew :app:connectedDebugAndroidTest`** — requires a connected device/emulator; JNI and SQLCipher can't run in JVM unit tests
- Full local check: lint + unit + instrumented; CI runs all three in parallel

## Gotchas (all hard-earned)

**JNI** (`app/src/main/cpp/argon2-jni.cpp` ↔ `Argon2.kt`):
- JNI symbol names must match the Kotlin `private external` names exactly (`nativeHash`, `nativeHashEncoded`, `nativeVerify`); mismatch → `UnsatisfiedLinkError`
- JNI arg order is `(password, salt, mCost, tCost, parallelism, hashLen, type)` — **mCost before tCost**; swapping silently swaps values → confusing errors like "Memory cost is too small"
- `argon2_hash` with `encoded != NULL` still validates/uses hashLen — passing 0 yields "Output is too short"; always pass the real value
- The vendored argon2/ tree is upstream reference code; don't refactor it, edit the wrapper instead

**SQLCipher + Room**:
- `sqlcipher-android` is declared `@aar` → no transitive deps → keep `androidx.sqlite:sqlite` explicit in `app/build.gradle.kts`
- `System.loadLibrary("sqlcipher")` required before any DB use (already in `VaultDatabase.create`)
- **Vault DB is initialized from raw SQL, not Room entities**: `VaultCreator` creates `vault.db` via `net.zetetic...SQLiteDatabase.openOrCreateDatabase(File, VaultKeyBytes, ...)` and executes `assets/schema.sql` (kept in sync with `docs/schema.sql` — edit both). Room's `VaultDatabase` is a separate layer for record tables
- Onboarding writes `vault.meta` (canonical sorted-key JSON, MAC'd with SMK[32:64], Crockford Base32 binary fields) before creating the DB — see `vault/VaultMeta.kt`; the `mac` field is excluded from its own MAC computation
- Room 2.8: `RoomDatabase` implements `AutoCloseable`, **not** `Closeable` — `kotlin.io.use {}` does not compile on it
- Schema exported to committed `app/schemas/` (`room.schemaLocation` in build.gradle.kts); any entity/column change updates `.../VaultDatabase/1.json`
- **Migrations: Room `Migration` objects + `MigrationTestHelper`, not Flyway.** Never `fallbackToDestructiveMigration` in release (silent data loss in a vault)
- Passphrase is passed into `VaultDatabase.create()`; the intended flow (see `passphraseCanBeDerivedFromArgon2` test) is Argon2 KDF → SQLCipher passphrase. Key rotation (master password change) is `PRAGMA rekey` at unlock time, orthogonal to schema migrations

**Device/CI**:
- Physical device installs can fail with `INSTALL_FAILED_USER_RESTRICTED` → user must enable "Install via USB" in Developer options
- CI runs on **all branches** (push + PR). The emulator job requires the `libpulse0` apt install and `sudo chmod 666 /dev/kvm` steps (hosted runners lack kvm group perms) and `-no-window`; don't remove them. minSdk 36 forces the API 36 emulator image

## Design constraints

- No plaintext data: everything stored is encrypted (SQLCipher at rest; column-level ciphertext via `encrypted_data` tables in the ref design)
- Tiered access: notes readable after login; passwords require per-access auth (biometric) — structure data accordingly
- Crypto: Argon2id (JNI binding, done), AES-256 (SQLCipher), export/backup support planned
- Reference product design lives in the sibling Flutter repo (`cryptowl-ref`, has drift schema + crypto tests) — mirror its `t_password` schema conventions when extending
