import 'dart:typed_data';

import 'package:cryptography/cryptography.dart' as cg;
import 'package:cryptowl/src/crypto/protected_value.dart';

class AuthEncryptedResult {
  final Uint8List cipherData;
  final Uint8List authTag;

  AuthEncryptedResult(this.cipherData, this.authTag);
}

abstract class AeadCrypto {
  Future<AuthEncryptedResult> encrypt(
      ProtectedValue data, ProtectedValue key, Uint8List nonce, Uint8List? aad);
  Future<ProtectedValue> decrypt(AuthEncryptedResult encryptedData,
      ProtectedValue key, Uint8List nonce, Uint8List? aad);
}

abstract class _BaseAeadCrypto implements AeadCrypto {
  final cg.Cipher algorithm;

  _BaseAeadCrypto(this.algorithm);

  @override
  Future<AuthEncryptedResult> encrypt(
    ProtectedValue data,
    ProtectedValue key,
    Uint8List nonce,
    Uint8List? aad,
  ) async {
    final secretKey = cg.SecretKey(key.binaryValue);
    final secretBox = await algorithm.encrypt(
      data.binaryValue,
      secretKey: secretKey,
      nonce: nonce,
      aad: aad ?? Uint8List(0),
    );
    return AuthEncryptedResult(
      secretBox.cipherText as Uint8List,
      secretBox.mac.bytes as Uint8List,
    );
  }

  @override
  Future<ProtectedValue> decrypt(
    AuthEncryptedResult encryptedData,
    ProtectedValue key,
    Uint8List nonce,
    Uint8List? aad,
  ) async {
    final secretKey = cg.SecretKey(key.binaryValue);
    final secretBox = cg.SecretBox(
      encryptedData.cipherData,
      nonce: nonce,
      mac: cg.Mac(encryptedData.authTag),
    );
    final clearText = await algorithm.decrypt(
      secretBox,
      secretKey: secretKey,
      aad: aad ?? Uint8List(0),
    );
    return ProtectedValue.fromBinary(clearText as Uint8List);
  }
}

class CryptographyAesGcm extends _BaseAeadCrypto {
  CryptographyAesGcm() : super(cg.AesGcm.with256bits());
}

class CryptographyChaCha20 extends _BaseAeadCrypto {
  CryptographyChaCha20() : super(cg.Chacha20.poly1305Aead());
}
