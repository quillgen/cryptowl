import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:kdbx/kdbx.dart';

import '../common/argon2_util.dart';
import '../common/uuid_util.dart';
import '../config/meta.dart';
import '../config/version.dart';

/// Argon2 parameters recommendation by OWASP:
/// see: https://cheatsheetseries.owasp.org/cheatsheets/Password_Storage_Cheat_Sheet.html#:~:text=To%20sum%20up%20our%20recommendations,a%20parallelization%20parameter%20of%201.
///

class KdbxService {
  static KdbxFormat kdbxFormat = KdbxFormat();
  static final valueKey = KdbxKey("value");

  Future<KdbxFile> create(ProtectedValue masterPassword) async {
    final credentials = Credentials(masterPassword);
    final kdbx = kdbxFormat.create(
      credentials,
      'Cryptowl Kdbx',
    );
    final rootGroup = kdbx.body.rootGroup;
    final entry = KdbxEntry.create(kdbx, rootGroup);
    rootGroup.addEntry(entry);

    final random1 = sha256
        .convert(sha256.convert(utf8.encode(UuidUtil.generateUUID())).bytes)
        .bytes as Uint8List;
    final random2 = sha256
        .convert(sha256.convert(utf8.encode(UuidUtil.generateUUID())).bytes)
        .bytes as Uint8List;

    // see: https://cheatsheetseries.owasp.org/cheatsheets/Password_Storage_Cheat_Sheet.html#argon2id
    final args = Argon2Arguments(
      random1,
      random2,
      12288,
      3,
      32,
      1,
      ARGON2_id,
      19,
    );
    entry.setString(KdbxKeyCommon.TITLE, PlainValue("CONFIG"));
    entry.setString(KdbxKey("APP_VERSION"), PlainValue(APP_VERSION));
    entry.setString(
        KdbxKey("SQLCIPHER_VERSION"), PlainValue(SQLCIPHER_VERSION));
    entry.setString(KdbxKey("INSTANCE"), PlainValue(UuidUtil.generateUUID()));
    entry.setString(
        KdbxKeyCommon.PASSWORD, ProtectedValue.fromString(args.toString()));

    return kdbx;
  }

  Future<Meta> loadMeta(KdbxFile kdbx) async {
    final configEntry = kdbx.body.rootGroup.entries.singleWhere((element) =>
        element.getString(KdbxKeyCommon.TITLE)?.getText() == "CONFIG");
    final appVersion =
        configEntry.getString(KdbxKey("APP_VERSION"))?.getText() ?? "";
    final sqlCipherVersion =
        configEntry.getString(KdbxKey("SQLCIPHER_VERSION"))?.getText() ?? "";
    final instance =
        configEntry.getString(KdbxKey("INSTANCE"))?.getText() ?? "";
    final passwordArgs =
        configEntry.getString(KdbxKeyCommon.PASSWORD)?.getText() ?? "";
    final argon2Arguments = Argon2Arguments.parse(passwordArgs);
    final derivedKey = await Argon2Util.deriveKey(argon2Arguments);
    return Meta(appVersion, sqlCipherVersion, instance,
        ProtectedValue.fromBinary(derivedKey));
  }
}
