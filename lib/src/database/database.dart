import 'dart:io';

import 'package:convert/convert.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:native_sqlcipher/native_sqlcipher.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/open.dart';

import '../../main.dart';
import '../common/path_util.dart';
import '../config/version.dart';
import '../crypto/protected_value.dart';

// run `dart run build_runner build` to generate
part 'database.g.dart';

@DriftDatabase(include: {'common.drift', 'note.drift', 'tables.drift'})
class SqliteDb extends _$SqliteDb {
  SqliteDb.from(QueryExecutor e) : super(e);
  SqliteDb.open(String file, ProtectedValue key)
      : super(_openDatabase(file, key));
  SqliteDb.openFile(File file, ProtectedValue key)
      : super(_openDatabaseFile(file, key));

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    final now = DateTime.now().toIso8601String();
    return MigrationStrategy(
      beforeOpen: (details) async {
        if (details.wasCreated) {
          await into(categories).insert(CategoryEntity(
            id: 1,
            name: "default",
            accessLevel: 1,
            createTime: now,
            lastUpdateTime: now,
          ));
        }
      },
      onCreate: (Migrator m) async {
        await m.createAll();
        await transaction(() async {});
      },
    );
  }
}

void setupSqlCipher() {
  open.overrideForAll(openSqlcipher);
}

QueryExecutor _openDatabaseFile(File realFile, ProtectedValue key) {
  if (key.binaryValue.length != 32) {
    throw ArgumentError("SQL Cipher must use a key of 32 bytes");
  }
  return LazyDatabase(() async {
    logger.fine("opening database: $realFile");

    final dictPath = await PathUtil.getLocalPath('dict');
    return NativeDatabase.createInBackground(
      realFile,
      logStatements: true,
      isolateSetup: setupSqlCipher,
      setup: (rawDb) {
        print("setting up sqlcipher db...");
        final result = rawDb.select('pragma cipher_version');
        if (result.isEmpty) {
          throw UnsupportedError(
            'This database needs to run with SQLCipher, but that library is '
            'not available!',
          );
        } else {
          final cipherVersion = result.single['cipher_version'];
          if (cipherVersion != SQLCIPHER_VERSION) {
            throw UnsupportedError(
              "This application only supports SQLCipher with version=$SQLCIPHER_VERSION, "
              'however database with version=$cipherVersion detected',
            );
          }
        }
        // set key without key derivation:
        // see: https://github.com/sqlcipher/sqlcipher/blob/master/README.md
        // PRAGMA key = "x'2DD29CA851E7B56E4697B0E1F08507293D761A05CE4D1B628663F411A8086D99'";

        // fixme: for debug only
        print("pragma key = \"x'${hex.encode(key.binaryValue)}'\";");

        rawDb.execute("pragma key = \"x'${hex.encode(key.binaryValue)}'\";");
        rawDb.execute('select count(*) from sqlite_master');

        rawDb.execute("select enable_jieba('$dictPath')");
      },
    );
  });
}

QueryExecutor _openDatabase(String file, ProtectedValue key) {
  if (key.binaryValue.length != 32) {
    throw ArgumentError("SQL Cipher must use a key of 32 bytes");
  }
  return LazyDatabase(() async {
    final path = await getApplicationDocumentsDirectory();
    final realFile = File(p.join(path.path, file));
    logger.fine("opening database: $realFile");

    final dictPath = await PathUtil.getLocalPath('dict');
    return NativeDatabase.createInBackground(
      realFile,
      logStatements: true,
      isolateSetup: setupSqlCipher,
      setup: (rawDb) {
        print("setting up sqlcipher db...");
        final result = rawDb.select('pragma cipher_version');
        if (result.isEmpty) {
          throw UnsupportedError(
            'This database needs to run with SQLCipher, but that library is '
            'not available!',
          );
        } else {
          final cipherVersion = result.single['cipher_version'];
          if (cipherVersion != SQLCIPHER_VERSION) {
            throw UnsupportedError(
              "This application only supports SQLCipher with version=$SQLCIPHER_VERSION, "
              'however database with version=$cipherVersion detected',
            );
          }
        }
        // set key without key derivation:
        // see: https://github.com/sqlcipher/sqlcipher/blob/master/README.md
        // PRAGMA key = "x'2DD29CA851E7B56E4697B0E1F08507293D761A05CE4D1B628663F411A8086D99'";

        // fixme: for debug only
        print("pragma key = \"x'${hex.encode(key.binaryValue)}'\";");

        rawDb.execute("pragma key = \"x'${hex.encode(key.binaryValue)}'\";");
        rawDb.execute('select count(*) from sqlite_master');

        rawDb.execute("select enable_jieba('$dictPath')");
      },
    );
  });
}
