import 'dart:convert';
import 'dart:io';

import 'package:cryptowl/src/common/encoding_util.dart';
import 'package:cryptowl/src/config/sqlite.dart';
import 'package:cryptowl/src/domain/user.dart';
import 'package:cryptowl/src/service/config_service.dart';
import 'package:cryptowl/src/service/file_service.dart';
import 'package:cryptowl/src/service/kdf_service.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';

import '../common/exceptions.dart';
import '../common/protected_value.dart';
import '../common/random_util.dart';
import '../database/database.dart';

const dictAssets = [
  'assets/dict/jieba.dict.utf8',
  'assets/dict/hmm_model.utf8',
  'assets/dict/user.dict.utf8',
  'assets/dict/idf.utf8',
  'assets/dict/stop_words.utf8',
];

class AppService {
  final logger = Logger('AppService');
  final FileService fileService;
  final KdfService kdfService;
  final ConfigService configService;

  AppService(this.fileService, this.kdfService, this.configService);

  Future<bool> isInitialized() async {
    final dbs = await fileService.getSqlcipherInstances();
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
    await _copyJiebaDicts();
    final instanceId = RandomUtil.generateUUID();
    final secretKey = await kdfService.generateRandomBytes(length: 32);
    final transformSeed = await kdfService.generateRandomBytes(length: 16);
    final masterSeed = await kdfService.generateRandomBytes(length: 16);
    final symmectricKey = await kdfService.generateRandomBytes(length: 64);
    final encryptionIv = await kdfService.generateRandomBytes(length: 16);

    final secretKeyLocation = _secretKeyId(instanceId);
    await configService.saveSecureStore(secretKeyLocation, secretKey);

    final savedSecretKey =
        await configService.readSecureStore(secretKeyLocation);
    if (secretKey != savedSecretKey) {
      throw Exception("Failed to save secret key");
    }
    final config = await configService.createConfig(
      instanceId,
      EncodingUtil.encodeCrockfordBase32(transformSeed),
      EncodingUtil.encodeCrockfordBase32(masterSeed),
      masterPassword,
      secretKey,
    );

    await fileService.writeFile(
        json.encode(config.toJson()), "${instanceId}.json");
    // final db = SqliteDb.open(instanceId, ProtectedValue.fromBinary(key));

    // // force to trigger database creation
    // logger.fine("Creating sqlcipher db $instance...");
    // await db.select(db.passwords).get();
    // await db.close();
  }

  String _secretKeyId(String instanceId) {
    return "SECRET-KEY:$instanceId";
  }

  Future<void> _copyAssetsToDocDir(List<String> assetPaths) async {
    final docDir = await getApplicationDocumentsDirectory();

    final dictDir = Directory('${docDir.path}/dict');
    if (!(await dictDir.exists())) {
      await dictDir.create(recursive: true);
    }
    for (final asset in assetPaths) {
      final data = await rootBundle.load(asset);
      final filename = asset.split('/').last;
      final file = File('${docDir.path}/dict/$filename');
      await file.writeAsBytes(data.buffer.asUint8List(), flush: true);
    }
  }

  Future<void> _copyJiebaDicts() async {
    await _copyAssetsToDocDir(dictAssets);
  }
}
