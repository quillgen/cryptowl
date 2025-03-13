import 'dart:io';
import 'dart:typed_data';

import 'package:cryptowl/src/providers/credentials.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kdbx/kdbx.dart';
import 'package:logging/logging.dart';

import '../common/path_util.dart';
import '../config/sqlite.dart';
import '../providers/providers.dart';

class KdbxRepository {
  static final entryTitle = "CRYPTOWL_SQLCIPHER_CONFIG";

  static final instanceKey = KdbxKey("sqlcipher.instance");
  static final versionKey = KdbxKey("sqlcipher.version");
  static final kdfParametersKey = KdbxKey("sqlcipher.kdfParameters");

  final logger = Logger('KdbxRepository');
  final Ref? ref;
  final KdbxFile? kdbxFile;

  KdbxRepository(this.ref) : kdbxFile = null;
  KdbxRepository.fromFile(this.kdbxFile) : ref = null;

  KdbxFile _requireKdbx() {
    if (this.kdbxFile != null) {
      return this.kdbxFile!;
    }
    final kdbxFile = ref!.read(asyncLoginProvider);
    final session = kdbxFile.unwrapPrevious().value;
    if (session == null) {
      throw Exception("No active kdbx file opened!");
    }
    return session.kdbxFile;
  }

  Future<SqliteConfig> getSqlcipherConfig() async {
    final kdbx = _requireKdbx();
    final configEntry = kdbx.body.rootGroup.entries.singleWhere((element) =>
        element.getString(KdbxKeyCommon.TITLE)?.getText() == entryTitle);

    final version = configEntry.getString(versionKey)?.getText() ?? "";
    final instance = configEntry.getString(instanceKey)?.getText() ?? "";
    final kdfParameters =
        configEntry.getString(kdfParametersKey)?.getText() ?? "";

    return SqliteConfig(version, instance, kdfParameters);
  }

  Future<KdbxEntry> createSqlcipherConfig(SqliteConfig config) async {
    final kdbx = _requireKdbx();
    final rootGroup = kdbx.body.rootGroup;
    final entry = KdbxEntry.create(kdbx, rootGroup);
    rootGroup.addEntry(entry);
    entry.setString(KdbxKeyCommon.TITLE, PlainValue(KdbxRepository.entryTitle));
    entry.setString(KdbxRepository.versionKey, PlainValue(config.version));
    entry.setString(KdbxRepository.instanceKey, PlainValue(config.instance));
    entry.setString(KdbxRepository.kdfParametersKey,
        ProtectedValue.fromString(config.kdfParameters));
    logger.fine("saving sqlcipher entry:${entry.uuid} ...");
    kdbx.saveTo(_writeFile);
    return entry;
  }

  Future<void> _writeFile(Uint8List bytes) async {
    final file = File(await PathUtil.getLocalPath("config.kdbx"));
    logger.fine("writing kdbx to file, len=${bytes.length}...");
    file.writeAsBytesSync(bytes);
  }
}
