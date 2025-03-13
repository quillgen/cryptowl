import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:cryptowl/src/config/sqlite.dart';
import 'package:kdbx/kdbx.dart';

import '../common/random_util.dart';
import '../config/version.dart';
import 'kdbx_repository.dart';

/// Argon2 parameters recommendation by OWASP:
/// see: https://cheatsheetseries.owasp.org/cheatsheets/Password_Storage_Cheat_Sheet.html#:~:text=To%20sum%20up%20our%20recommendations,a%20parallelization%20parameter%20of%201.
///

class KdbxService {
  static KdbxFormat kdbxFormat = KdbxFormat();

  final KdbxRepository repository;

  KdbxService(this.repository);

  static Future<KdbxFile> create(ProtectedValue masterPassword) async {
    final credentials = Credentials(masterPassword);
    final kdbx = kdbxFormat.create(
      credentials,
      'CRYPTOWL_INTERNAL',
    );
    final rootGroup = kdbx.body.rootGroup;
    final entry = KdbxEntry.create(kdbx, rootGroup);
    rootGroup.addEntry(entry);

    final random1 = sha256
        .convert(sha256.convert(utf8.encode(RandomUtil.generateUUID())).bytes)
        .bytes as Uint8List;
    final random2 = sha256
        .convert(sha256.convert(utf8.encode(RandomUtil.generateUUID())).bytes)
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
    entry.setString(KdbxKeyCommon.TITLE, PlainValue(KdbxRepository.entryTitle));
    entry.setString(KdbxRepository.versionKey, PlainValue(SQLCIPHER_VERSION));
    entry.setString(
        KdbxRepository.instanceKey, PlainValue(RandomUtil.generateUUID()));
    entry.setString(KdbxRepository.kdfParametersKey,
        ProtectedValue.fromString(args.toString()));

    return kdbx;
  }

  Future<SqliteConfig> loadConfig() async {
    return repository.getSqlcipherConfig();
  }
}
