import 'dart:convert';

import 'package:cryptowl/src/common/classification.dart';
import 'package:cryptowl/src/crypto/aead_crypto.dart';
import 'package:cryptowl/src/crypto/crockford_base32.dart';
import 'package:cryptowl/src/crypto/protected_value.dart';
import 'package:cryptowl/src/crypto/random_util.dart';
import 'package:cryptowl/src/database/database.dart';
import 'package:cryptowl/src/domain/password.dart';
import 'package:cryptowl/src/repositories/password_repository.dart';
import 'package:cryptowl/src/service/kdf_service.dart';

const AES_GCM = "0x31c1f2e6bf714350be5805216afc5aff";
const CHACHA20 = "0xD6038A2B8B6F4CB5A524339A31DBB59A";

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
    final algorithmId =
        password.isTopSecret == Classification.topSecret ? CHACHA20 : AES_GCM;
    final dek = await kdfService.generateRandomBytes(length: 32);
    final dekNonce = await kdfService.generateRandomBytes(length: 12);
    final now = DateTime.now();
    final dekId = RandomUtil.generateUUID();
    final encryptedDek = await aesGcm.encrypt(
        dek, kek, dekNonce.binaryValue, utf8.encode(dekId));
    final keyEntity = TDataEncryptKeyData(
        id: dekId,
        data: CrockfordBase32.encode(encryptedDek.cipherData),
        nonce: CrockfordBase32.encode(dekNonce.binaryValue),
        authTag: CrockfordBase32.encode(encryptedDek.authTag),
        createdAt: now,
        updatedAt: now);
    final encryptedDataId = RandomUtil.generateUUID();
    final passwordId = RandomUtil.generateUUID();
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

    return passwordRepository.create(
        passwordEntity, keyEntity, encryptedDataEntity);
  }
}
