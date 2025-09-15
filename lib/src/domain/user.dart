import 'package:flutter/foundation.dart';

import '../config/sqlite.dart';
import '../database/database.dart';

@immutable
class Session {
  final SqliteConfig sqliteConfig;
  final SqliteDb sqliteDb;

  const Session(this.sqliteConfig, this.sqliteDb);
}
