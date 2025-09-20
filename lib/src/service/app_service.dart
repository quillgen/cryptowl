import 'dart:convert';
import 'dart:io';

import 'package:cryptowl/src/config/sqlite.dart';
import 'package:cryptowl/src/crypto/aead_crypto.dart';
import 'package:cryptowl/src/domain/user.dart';
import 'package:cryptowl/src/service/config_service.dart';
import 'package:cryptowl/src/service/file_service.dart';
import 'package:cryptowl/src/service/kdf_service.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';

import '../common/exceptions.dart';
import '../crypto/protected_value.dart';
import '../crypto/random_util.dart';
import '../database/database.dart';

class AppService {
  final logger = Logger('AppService');
  final FileService fileService;
  final KdfService kdfService;
  final ConfigService configService;
  final aeadCrypto = CryptographyAesGcm();

  AppService(this.fileService, this.kdfService, this.configService);

  Future<bool> isInitialized() async {
    final dbs = await fileService.getSqlcipherInstances();
    logger.info("Find existing instances: $dbs");
    return dbs.isNotEmpty;
  }

  Future<Session> login(ProtectedValue password) async {
    final File config = await fileService.getConfigFile();
    final data = await config.readAsBytes();
    try {
      final sqlite = SqliteDb.open("fixme", ProtectedValue.fromString("fixMe"));
      final SqliteConfig dbConfig = SqliteConfig("1", "1", "1");
      await sqlite.select(sqlite.passwords).get();
      return Session(dbConfig, sqlite);
    } catch (e) {
      logger.severe("Login failed, password incorrect", e);
      throw IncorrectPasswordException();
    }
  }

  Future<void> initialize(ProtectedValue masterPassword, String? hint) async {
    await fileService.copyJiebaDicts();

    final instanceId = RandomUtil.generateName();
    final secretKey = await kdfService.generateRandomBytes(length: 32);
    final transformSeed = await kdfService.generateRandomBytes(length: 16);
    final masterSeed = await kdfService.generateRandomBytes(length: 16);
    final symmetricKey = await kdfService.generateRandomBytes(length: 64);
    final nonce = await kdfService.generateRandomBytes(length: 16);

    final instanceIdBytes = utf8.encode(instanceId);

    final transformedMasterKey = await kdfService.createTransformedMasterKey(
        masterPassword, secretKey, transformSeed.binaryValue);
    final stretchedMasterKey = await kdfService.createStretchedMasterKey(
        transformedMasterKey, instanceIdBytes, masterSeed.binaryValue);
    final encryptedSymmetricKey = await _encryptSymmetricKey(
        symmetricKey, stretchedMasterKey, nonce.binaryValue, instanceIdBytes);

    final secretKeyLocation = _secretKeyId(instanceId);
    await configService.saveSecureStore(secretKeyLocation, secretKey);

    final savedSecretKey =
        await configService.readSecureStore(secretKeyLocation);
    if (secretKey != savedSecretKey) {
      throw Exception("Failed to save secret key");
    }
    final config = await configService.createConfig(
        instanceId,
        transformSeed.binaryValue,
        masterSeed.binaryValue,
        encryptedSymmetricKey,
        ProtectedValue.fromBinary(
            Uint8List.sublistView(stretchedMasterKey.binaryValue, 32)));

    await fileService.writeFile(
        json.encode(config.toJson()), "${instanceId}.cfg");

    final db = SqliteDb.open(
        "${instanceId}.enc",
        ProtectedValue.fromBinary(
            Uint8List.sublistView(stretchedMasterKey.binaryValue, 0, 32)));

    // force to trigger database creation
    logger.fine("Creating sqlcipher db $instanceId...");
    await db.select(db.passwords).get();
    await db.close();
  }

  String _secretKeyId(String instanceId) {
    return "SECRET-KEY:$instanceId";
  }

  Future<AuthEncryptedResult> _encryptSymmetricKey(
      ProtectedValue symmetricKey,
      ProtectedValue stretchedMasterKey,
      Uint8List nonce,
      Uint8List instanceId) async {
    final key = Uint8List.sublistView(stretchedMasterKey.binaryValue, 0, 32);
    return aeadCrypto.encrypt(
        symmetricKey, ProtectedValue.fromBinary(key), nonce, instanceId);
  }
}
