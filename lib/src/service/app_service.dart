import 'dart:io';

import 'package:cryptowl/src/common/argon2_util.dart';
import 'package:cryptowl/src/common/random_util.dart';
import 'package:cryptowl/src/config/sqlite.dart';
import 'package:cryptowl/src/domain/user.dart';
import 'package:cryptowl/src/repositories/kdbx_repository.dart';
import 'package:cryptowl/src/service/file_service.dart';
import 'package:flutter/services.dart';
import 'package:kdbx/kdbx.dart';
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';

import '../common/exceptions.dart';
import '../config/version.dart';
import '../database/database.dart';

const dictAssets = [
  'assets/dict/jieba.dict.utf8',
  'assets/dict/hmm_model.utf8',
  'assets/dict/user.dict.utf8',
  'assets/dict/idf.utf8',
  'assets/dict/stop_words.utf8',
];

class AppService {
  static KdbxFormat kdbxFormat = KdbxFormat();

  final logger = Logger('AppService');
  final FileService fileService;

  AppService(this.fileService);

  Future<bool> isInitialized() async {
    // fixme:
    await Future.delayed(const Duration(seconds: 2));
    return fileService.hasConfigFile();
  }

  Future<Session> login(ProtectedValue password) async {
    final File config = await fileService.getConfigFile();
    final data = await config.readAsBytes();
    try {
      // fixme:
      //await Future.delayed(const Duration(seconds: 1));
      final kdbx = await kdbxFormat.read(data, Credentials(password));
      final kdbxRepository = KdbxRepository.fromFile(kdbx);
      final config = await kdbxRepository.getSqlcipherConfig();

      final key = await Argon2Util.deriveKey(
          Argon2Arguments.parse(config.kdfParameters));
      final sqlite =
          SqliteDb.open(config.instance, ProtectedValue.fromBinary(key));
      await sqlite.select(sqlite.passwords).get();
      return Session(kdbx, config, sqlite);
    } on KdbxInvalidKeyException catch (e) {
      logger.severe("Login failed, password incorrect", e);
      throw IncorrectPasswordException();
    }
  }

  Future<KdbxEntry> initialize(ProtectedValue masterPassword) async {
    await _copyJiebaDicts();
    final credentials = Credentials(masterPassword);
    final kdbx = kdbxFormat.create(
      credentials,
      'CRYPTOWL_INTERNAL',
    );
    final instance = "${RandomUtil.generateUUID()}.enc";
    final kdfParameters = RandomUtil.generateKdfParameters();
    final key = await Argon2Util.deriveKey(kdfParameters);
    final db = SqliteDb.open(instance, ProtectedValue.fromBinary(key));

    // force to trigger database creation
    logger.fine("Creating sqlcipher db $instance...");
    await db.select(db.passwords).get();
    await db.close();

    final kdbxRepository = KdbxRepository.fromFile(kdbx);

    final sqlcipherConfig = SqliteConfig(
      SQLCIPHER_VERSION,
      instance,
      kdfParameters.toString(),
    );
    final entry = await kdbxRepository.createSqlcipherConfig(sqlcipherConfig);

    return entry;
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
