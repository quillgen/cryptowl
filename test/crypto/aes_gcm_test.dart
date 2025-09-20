import 'dart:convert';

import 'package:convert/convert.dart';
import 'package:cryptography/cryptography.dart';
import 'package:cryptowl/src/crypto/aes_gcm.dart';
import 'package:cryptowl/src/crypto/protected_value.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final aesGcm = CryptographyAesGcm();

  // https://fotoventus.cz/tool/hkdf.html
  final data = utf8.encode("hello world!");
  final key = hex.decode(
          "3f09ea13ceffb8e867a4af3ab17854f9f5f152591653c737a8962b94356e2c0f")
      as Uint8List;
  final nonce = hex.decode("b27f6e2bd596308c190c4f1d") as Uint8List;
  final info = utf8.encode("41964e60-5fc3-472c-8b87-71363c71b03c");

  test('should return encoded key with auth tag', () async {
    final r = await aesGcm.encrypt(ProtectedValue.fromBinary(data),
        ProtectedValue.fromBinary(key), nonce, info);
    expect(hex.encode(r.data), "33335861071ff401989294fa");
    expect(hex.encode(r.authTag), "53b19b6a4498a61b415c2e7963f1cab5");
  });

  test('should return decryted data given key and other info correct',
      () async {
    final data = hex.decode("33335861071ff401989294fa") as Uint8List;
    final authTag = hex.decode("53b19b6a4498a61b415c2e7963f1cab5") as Uint8List;
    final r = await aesGcm.decrypt(EcnryptedData(data, authTag),
        ProtectedValue.fromBinary(key), nonce, info);
    expect(utf8.decode(r.binaryValue), "hello world!");
  });

  test('should throw error given aad not provided', () async {
    final data = hex.decode("33335861071ff401989294fa") as Uint8List;
    final authTag = hex.decode("53b19b6a4498a61b415c2e7963f1cab5") as Uint8List;
    Future<ProtectedValue> r() async => await aesGcm.decrypt(
        EcnryptedData(data, authTag),
        ProtectedValue.fromBinary(key),
        nonce,
        null);

    expect(r, throwsA(isA<SecretBoxAuthenticationError>()));
  });

  test('should throw error given key incorrect', () async {
    final data = hex.decode("33335861071ff401989294fa") as Uint8List;
    final authTag = hex.decode("53b19b6a4498a61b415c2e7963f1cab5") as Uint8List;
    final wrongKey = hex.decode(
        "3f09ea13ceffb8e867a4af3ab17854f9f5f152591653c737a8962b94356e2c0f"
            .replaceAll("1", "2")) as Uint8List;
    Future<ProtectedValue> r() async => await aesGcm.decrypt(
        EcnryptedData(data, authTag),
        ProtectedValue.fromBinary(wrongKey),
        nonce,
        info);

    expect(r, throwsA(isA<SecretBoxAuthenticationError>()));
  });

  test('should throw error given nonce incorrect', () async {
    final data = hex.decode("33335861071ff401989294fa") as Uint8List;
    final authTag = hex.decode("53b19b6a4498a61b415c2e7963f1cab5") as Uint8List;
    final wrongNonce = hex
        .decode("b27f6e2bd596308c190c4f1d".replaceAll("b", "f")) as Uint8List;
    Future<ProtectedValue> r() async => await aesGcm.decrypt(
        EcnryptedData(data, authTag),
        ProtectedValue.fromBinary(key),
        wrongNonce,
        info);

    expect(r, throwsA(isA<SecretBoxAuthenticationError>()));
  });
}
