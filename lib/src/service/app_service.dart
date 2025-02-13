import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kdbx/kdbx.dart';
import 'package:logger/logger.dart';

import '../common/exceptions.dart';
import '../common/path_util.dart';
import '../config/meta.dart';
import '../database/database.dart';
import 'kdbx_service.dart';

class AppService {
  static const String configFileName = "app.kdbx";
  static KdbxFormat kdbxFormat = KdbxFormat();

  final logger = Logger();
  final Ref ref;
  final KdbxService _kdbxService;

  AppService(this.ref, this._kdbxService);

  static Future<File> getAppConfigFile() async {
    return File(await PathUtil.getLocalPath(configFileName));
  }

  Future<bool> isInitialized() async {
    final File config = await getAppConfigFile();
    logger.d("Checking if config file exists: $config");
    return config.existsSync();
  }

  Future<Meta> login(ProtectedValue password) async {
    final File config = await getAppConfigFile();
    final data = await config.readAsBytes();
    try {
      final kdbx = await kdbxFormat.read(data, Credentials(password));
      return _kdbxService.loadMeta(kdbx);
    } on KdbxInvalidKeyException catch (e) {
      logger.e("Login failed, password incorrect", error: e);
      throw IncorrectPasswordException();
    }
  }

  Future<KdbxFile> initialize(ProtectedValue masterPassword) async {
    final kdbx = await _kdbxService.create(masterPassword);
    final saved = await kdbx.save();
    final configFile = await getAppConfigFile();

    logger.i("Initializing config:$configFile");

    assert(!configFile.existsSync());
    configFile.writeAsBytesSync(saved);

    final meta = await _kdbxService.loadMeta(kdbx);
    final dbFile = "${meta.dbInstance}.enc";
    logger.i("Initializing database:$dbFile");
    final db = AppDb.open(dbFile, meta.dbEncryptionKey);

    // force to trigger database creation
    await db.select(db.notes).get();
    await db.close();
    return kdbx;
  }
}
