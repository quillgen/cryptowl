import 'dart:io';

import 'package:cryptowl/src/common/argon2_util.dart';
import 'package:cryptowl/src/common/random_util.dart';
import 'package:cryptowl/src/config/sqlite.dart';
import 'package:cryptowl/src/domain/user.dart';
import 'package:cryptowl/src/service/file_service.dart';
import 'package:cryptowl/src/service/kdbx_repository.dart';
import 'package:kdbx/kdbx.dart';
import 'package:logging/logging.dart';

import '../common/exceptions.dart';
import '../config/version.dart';
import '../database/database.dart';

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
}
