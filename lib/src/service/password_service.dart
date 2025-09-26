import 'dart:convert';

import 'package:cryptowl/src/common/classification.dart';
import 'package:cryptowl/src/crypto/aead_crypto.dart';
import 'package:cryptowl/src/crypto/crockford_base32.dart';
import 'package:cryptowl/src/crypto/protected_value.dart';
import 'package:cryptowl/src/database/database.dart';
import 'package:cryptowl/src/domain/password.dart';
import 'package:cryptowl/src/repositories/password_repository.dart';
import 'package:cryptowl/src/service/kdf_service.dart';
import 'package:drift/drift.dart';

enum Algorithm {
  aes256Gcm("2ad0737c-01a8-4d74-998f-9dfe855171fb"),
  chacha20Poly1305("824b7f4a-3882-4194-8936-600d7d493ddb"),
  xchacha20Poly1305("8c378b87-5d19-4ef4-9848-561c533d9e04");

  final String id;

  const Algorithm(this.id);

  factory Algorithm.parse(String id) {
    return Algorithm.values.firstWhere((element) => element.id == id);
  }
}

const DEFAULT = 0;

class PasswordService {
  final KdfService kdfService;
  final PasswordRepository passwordRepository;
  final aesGcm = CryptographyAesGcm();
  final chacha20 = CryptographyChaCha20();

  PasswordService(this.kdfService, this.passwordRepository);

  Future<void> createPassword(Password password, ProtectedValue kek) async {
    final crypto =
        password.isTopSecret == Classification.topSecret ? chacha20 : aesGcm;
    final algorithmId = password.isTopSecret == Classification.topSecret
        ? Algorithm.xchacha20Poly1305.id
        : Algorithm.aes256Gcm.id;
    final dek = await kdfService.generateRandomBytes(length: 32);
    final dekNonce = await kdfService.generateRandomBytes(length: 12);
    final now = DateTime.now();
    final dekId = await kdfService.generateUUID();
    final encryptedDek = await aesGcm.encrypt(
        dek, kek, dekNonce.binaryValue, utf8.encode(dekId));
    final keyEntity = TDataEncryptKeyData(
        id: dekId,
        data: CrockfordBase32.encode(encryptedDek.cipherData),
        nonce: CrockfordBase32.encode(dekNonce.binaryValue),
        authTag: CrockfordBase32.encode(encryptedDek.authTag),
        createdAt: now,
        updatedAt: now);
    final encryptedDataId = await kdfService.generateUUID();
    final passwordId = await kdfService.generateUUID();
    final dataNonce = await kdfService.generateRandomBytes(length: 12);
    final encryptedData = await crypto.encrypt(password.value, dek,
        dataNonce.binaryValue, utf8.encode(encryptedDataId));
    final encryptedDataEntity = TEncryptedDataData(
        id: encryptedDataId,
        dekId: dekId,
        content: encryptedData.cipherData,
        algorithmId: algorithmId,
        authTag: CrockfordBase32.encode(encryptedData.authTag),
        nonce: CrockfordBase32.encode(dataNonce.binaryValue),
        createdAt: now,
        updatedAt: now);
    final classification =
        password.isTopSecret ? Classification.topSecret : Classification.secret;
    final passwordEntity = TPasswordData(
        id: passwordId,
        type: DEFAULT,
        title: password.title,
        categoryId: DEFAULT,
        classification: classification.value,
        encryptedDataId: encryptedDataId,
        createdAt: now,
        updatedAt: now);
    final attributes = password.attributes
        .map((a) => TPasswordAttributeCompanion(
            passwordId: Value(passwordId),
            classification: Value(a.isProtected
                ? Classification.secret.value
                : Classification.confidential.value),
            value: Value(utf8.decode(a.value.binaryValue)),
            name: Value(a.name),
            createdAt: Value(now),
            updatedAt: Value(now)))
        .toList();

    return passwordRepository.create(
        passwordEntity, keyEntity, encryptedDataEntity, attributes);
  }
}
