import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:uuid/data.dart';
import 'package:uuid/rng.dart';
import 'package:uuid/uuid.dart';

import '../crypto/argon2.dart';

class RandomUtil {
  static final _uuid = Uuid(goptions: GlobalOptions(CryptoRNG()));

  static String generateUUID() {
    return _uuid.v4();
  }

  static Uint8List generateSecureBytes(int length) {
    final random = Random.secure();
    return Uint8List.fromList(
        List.generate(length, (_) => random.nextInt(256)));
  }

  // see: https://cheatsheetseries.owasp.org/cheatsheets/Password_Storage_Cheat_Sheet.html#argon2id
  static Argon2Arguments generateKdfParameters() {
    final random1 = sha256
        .convert(sha256.convert(utf8.encode(RandomUtil.generateUUID())).bytes)
        .bytes as Uint8List;
    final random2 = sha256
        .convert(sha256.convert(utf8.encode(RandomUtil.generateUUID())).bytes)
        .bytes as Uint8List;

    return Argon2Arguments(
        random1, random2, 12288, 3, 32, 1, Argon2Variant.argon2id, 19);
  }
}
