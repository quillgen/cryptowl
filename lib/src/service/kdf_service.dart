import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:cryptowl/src/crypto/argon2.dart';
import 'package:cryptowl/src/crypto/hkdf.dart';
import 'package:cryptowl/src/crypto/random_util.dart';

import '../crypto/protected_value.dart';

class KdfService {
  final hkdf = CryptoGraphyHkdf();
  final argon2 = NativeArgon2();

  /// https://cheatsheetseries.owasp.org/cheatsheets/Password_Storage_Cheat_Sheet.html
  /// OWASP suggested:
  /// Use Argon2id with a minimum configuration of 19 MiB of memory,
  /// an iteration count of 2, and 1 degree of parallelism.
  /// $argon2id$v=19$m=19456,t=2,p=1$ZHJAcmlndXouY29t$CMiXFHTwhEhxwgjjl7BDk65dnX3p8plUpMKY95AE2o4
  Future<ProtectedValue> createTransformedMasterKey(
      ProtectedValue masterPassword,
      ProtectedValue secretKey,
      Uint8List salt) async {
    final hmacSha256 = Hmac(sha256, masterPassword.binaryValue);
    final hash1 = hmacSha256.convert(secretKey.binaryValue);

    final key = await argon2.deriveKey(
      Argon2Arguments(Uint8List.fromList(hash1.bytes), salt, 19 * 1024, 2, 32,
          1, Argon2Variant.argon2id, 19),
    );
    return ProtectedValue.fromBinary(key);
  }

  Future<ProtectedValue> createStretchedMasterKey(
      ProtectedValue transformedMasterKey,
      Uint8List instanceId,
      Uint8List masterSeed) async {
    return hkdf.deriveKey(
        ikm: transformedMasterKey, salt: masterSeed, info: instanceId);
  }

  Future<ProtectedValue> generateRandomBytes({int length = 32}) async {
    return ProtectedValue.fromBinary(RandomUtil.generateSecureBytes(length));
  }
}
