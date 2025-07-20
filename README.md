# cryptowl

```bash
git clone git@github.com:quillgen/cryptowl.git
cd cryptowl
flutter pub get
dart run build_runner build
```

Generate locale:
```bash
flutter gen-l10n
```

## Secret classification

* Confidential: Content is protected relying on a random secret and Sqlcipher encryption, it could not be decrypted unless you get secret + db file
* Secret: Content is protected by master password + sqlcipher
* Top secret: Content is protected by master password + device info