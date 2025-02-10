import 'package:cryptowl/src/database/database.dart';

class DatabaseHelper {
  final AppDb database;

  DatabaseHelper(this.database);

  Future<int> createCategory(int id, String name) async {
    const sql = """
    insert into categories(id, name, encrypt_type, encrypt_arguments, create_time, last_update_time)
    values
    (?, ?, 0, null, ?, ?)
    """;
    const date = '2024-03-30T17:27:20.933';
    final List<Object> objs = [id, name, date, date];
    return database.executor.runInsert(sql, objs);
  }

  Future<int> createNote(int id, String title, String content,
      {int? type}) async {
    const sql = """
    insert into notes(id, type, format, title, content, abstract, tags, location, weather, mood, encrypt_type, encrypt_arguments, create_time, last_update_time, category_id)
    values
    (?, ?, 1, ?, ?, ?, null, 'Wuhan', null, 'Happy', 0, null, '2024-03-30T17:27:20.933', '2024-03-30T17:27:20.933', null);
    """;
    final List<Object> objs = [
      id,
      type ?? 1,
      title,
      content,
      content.substring(0, 10)
    ];
    return database.executor.runInsert(sql, objs);
  }

  Future<int> createPassword(int id, String title, String value) async {
    const sql = """
    insert into passwords(id, title, value, encrypt_type, create_time, last_update_time, category_id)
    values
    (?, ?, ?, ?, '2024-03-30T17:27:20.933', '2024-03-30T17:27:20.933', null);
    """;
    final List<Object> objs = [id, title, value, 0];
    return database.executor.runInsert(sql, objs);
  }
}
