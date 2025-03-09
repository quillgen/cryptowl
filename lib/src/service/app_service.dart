import 'dart:io';

import 'package:cryptowl/src/service/file_service.dart';
import 'package:kdbx/kdbx.dart';

import '../../main.dart';
import '../common/exceptions.dart';
import '../common/path_util.dart';
import '../database/database.dart';
import '../domain/user.dart';
import 'kdbx_service.dart';

class AppService {
  static const String configFileName = "app.kdbx";
  static KdbxFormat kdbxFormat = KdbxFormat();

  final FileService fileService;
  final KdbxService kdbxService;

  AppService(this.fileService, this.kdbxService);

  static Future<File> getAppConfigFile() async {
    return File(await PathUtil.getLocalPath(configFileName));
  }

  Future<bool> isInitialized() async {
    return fileService.hasConfigFile();
  }

  Future<User> login(ProtectedValue password) async {
    final File config = await getAppConfigFile();
    final data = await config.readAsBytes();
    try {
      final kdbx = await kdbxFormat.read(data, Credentials(password));
      final meta = await kdbxService.loadMeta(kdbx);
      return User(meta, password);
    } on KdbxInvalidKeyException catch (e) {
      logger.severe("Login failed, password incorrect", e);
      throw IncorrectPasswordException();
    }
  }

  Future<KdbxFile> initialize(ProtectedValue masterPassword) async {
    final kdbx = await kdbxService.create(masterPassword);
    final saved = await kdbx.save();
    final configFile = await getAppConfigFile();

    logger.fine("Initializing config:$configFile");

    assert(!configFile.existsSync());
    configFile.writeAsBytesSync(saved);

    final meta = await kdbxService.loadMeta(kdbx);
    final dbFile = "${meta.dbInstance}.enc";
    logger.fine("Initializing database:$dbFile");
    final db = SqliteDb.open(dbFile, meta.dbEncryptionKey);

    // force to trigger database creation
    await db.select(db.passwords).get();
    await db.close();
    return kdbx;
  }
}
