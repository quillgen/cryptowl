import 'dart:ffi';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:sqlite3/open.dart';

DynamicLibrary openTestSqlcipher() {
  String testLibPath;
  if (Platform.isMacOS) {
    testLibPath = 'libnative_sqlcipher.dylib';
  } else if (Platform.isLinux) {
    testLibPath = 'libnative_sqlcipher.so';
  } else if (Platform.isWindows) {
    testLibPath = 'libnative_sqlcipher.dll';
  } else {
    throw UnsupportedError(
      'Tests on ${Platform.operatingSystem} not supported',
    );
  }
  return DynamicLibrary.open("/tmp/sqlcipher-build/$testLibPath");
}

void setupSqlCipher() {
  open.overrideForAll(openTestSqlcipher);
}

QueryExecutor openTestDatabase(String file) {
  return LazyDatabase(() async {
    final realFile = File(file);

    final dictPath = "/tmp/dict";
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
        }
        print("\nSupported SQLite functions:");
        final functions = rawDb.select('PRAGMA function_list');
        for (final func in functions) {
          print('${func['name']} (type: ${func['type']})');
        }
        rawDb.execute(
            "pragma key = \"x'2DD29CA851E7B56E4697B0E1F08507293D761A05CE4D1B628663F411A8086D99'\";");
        rawDb.execute('select count(*) from sqlite_master');

        rawDb.execute("select enable_jieba('$dictPath')");
      },
    );
  });
}
