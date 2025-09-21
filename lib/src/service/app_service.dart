import 'dart:convert';
import 'dart:io';

import 'package:cryptowl/src/config/app_config.dart';
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

  Future<void> initialize(ProtectedValue masterPassword, String? hint) async {
    await fileService.copyJiebaDicts();
    final secretKey = await kdfService.generateRandomBytes(length: 32);
    final instanceId = RandomUtil.generateName();
    final secretKeyLocation = _secretKeyId(instanceId);
    await configService.saveSecureStore(secretKeyLocation, secretKey);
    if (hint != null) {
      await configService.saveSecureStore(
          _hintId(instanceId), ProtectedValue.fromBinary(utf8.encode(hint)));
    }

    final savedSecretKey =
        await configService.readSecureStore(secretKeyLocation);
    if (secretKey != savedSecretKey) {
      throw Exception("Failed to save secret key");
    }

    final transformSeed = await kdfService.generateRandomBytes(length: 16);
    final masterSeed = await kdfService.generateRandomBytes(length: 16);
    final symmetricKey = await kdfService.generateRandomBytes(length: 64);
    final nonce = await kdfService.generateRandomBytes(
        length: 12); // AES-256 GCM uses 12bytes nonce
    final config = await kdfService.generateAppConfig(
        masterPassword,
        secretKey,
        instanceId,
        transformSeed.binaryValue,
        masterSeed.binaryValue,
        symmetricKey,
        nonce.binaryValue);
    await fileService.writeFile(
        json.encode(config.toJson()), "${instanceId}.cfg");

    final db = SqliteDb.open(
        "${instanceId}.enc",
        ProtectedValue.fromBinary(
            Uint8List.sublistView(symmetricKey.binaryValue, 0, 32)));

    // force to trigger database creation
    logger.fine("Creating sqlcipher db $instanceId...");
    await db.select(db.passwords).get();
    await db.close();
  }

  Future<Session> login(String instanceId, ProtectedValue password) async {
    logger.info("Trying to login with $instanceId");

    final File configFile = await fileService.getConfigFile(instanceId);
    if (!await configFile.exists()) {
      throw CorruptedConfigException("Config file does not exist: $configFile");
    }
    final data = await configFile.readAsBytes();
    final config = await configService.loadConfig(utf8.decode(data));

    try {
      final symmetricKey = await _decryptSymmetricKey(password, config);
    } catch (e) {
      logger.warning("Failed to decrypt symmetric key: $e");
      throw IncorrectPasswordException();
    }

    try {
      final sqlite = SqliteDb.open("fixme", ProtectedValue.fromString("fixMe"));
      final SqliteConfig dbConfig = SqliteConfig("1", "1", "1");
      await sqlite.select(sqlite.passwords).get();
      return Session(dbConfig, sqlite);
    } catch (e) {
      throw IncorrectPasswordException();
    }
  }

  Future<ProtectedValue> _decryptSymmetricKey(
      ProtectedValue masterPassword, AppConfig config) async {
    final configData = config.data;
    final secretKeyLocation = _secretKeyId(configData.instanceId);
    final secretKey = await configService.readSecureStore(secretKeyLocation);
    if (secretKey == null) {
      throw CorruptedConfigException(
          "Secret key not found for instance:${configData.instanceId}");
    }
    return kdfService.decryptSymmetricKey(masterPassword, secretKey, config);
  }

  String _secretKeyId(String instanceId) {
    return "SECRET-KEY:$instanceId";
  }

  String _hintId(String instanceId) {
    return "HINT:$instanceId";
  }

  Future<AuthEncryptedResult> _encryptSymmetricKey(
      ProtectedValue symmetricKey,
      ProtectedValue stretchedMasterKey,
      Uint8List nonce,
      Uint8List instanceId) async {
    print("stretched master key:${stretchedMasterKey.getText()}");
    final key = Uint8List.sublistView(stretchedMasterKey.binaryValue, 0, 32);
    return aeadCrypto.encrypt(
        symmetricKey, ProtectedValue.fromBinary(key), nonce, instanceId);
  }
}
