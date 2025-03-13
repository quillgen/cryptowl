import 'package:flutter/foundation.dart';
import 'package:kdbx/kdbx.dart';

import '../config/sqlite.dart';
import '../database/database.dart';

@immutable
class Session {
  final KdbxFile kdbxFile;
  final SqliteConfig sqliteConfig;
  final SqliteDb sqliteDb;

  const Session(this.kdbxFile, this.sqliteConfig, this.sqliteDb);
}
