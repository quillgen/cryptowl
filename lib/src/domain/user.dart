import 'package:flutter/foundation.dart';

import '../database/database.dart';

@immutable
class Session {
  final SqliteDb sqliteDb;

  const Session(this.sqliteDb);
}
