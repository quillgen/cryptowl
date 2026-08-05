# Cryptowl (Android)

Local-first encrypted vault for Android (notes, passwords, photos/videos) — **no plaintext data at rest**. Android-native app (minSdk 36) with vendored C/C++ crypto (Argon2id via JNI) and SQLCipher-encrypted Room database.

- **Encryption & vault design** (key hierarchy, content security levels, biometric gating, backup, memory protection): [docs/design.md](docs/design.md) (diagram: [docs/encryption.svg](docs/encryption.svg))
- **Build/test conventions and hard-earned gotchas**: [AGENTS.md](AGENTS.md)
