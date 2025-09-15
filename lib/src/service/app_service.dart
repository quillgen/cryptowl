import 'dart:io';

import 'package:cryptowl/src/config/sqlite.dart';
import 'package:cryptowl/src/domain/user.dart';
import 'package:cryptowl/src/service/file_service.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';

import '../common/exceptions.dart';
import '../common/protected_value.dart';
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
      final sqlite = SqliteDb.open("fixme", ProtectedValue.fromString("fixMe"));
      final SqliteConfig dbConfig = SqliteConfig("1", "1", "1");
      await sqlite.select(sqlite.passwords).get();
      return Session(dbConfig, sqlite);
    } catch (e) {
      logger.severe("Login failed, password incorrect", e);
      throw IncorrectPasswordException();
    }
  }

  Future<void> initialize(ProtectedValue masterPassword) async {
    await _copyJiebaDicts();
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
