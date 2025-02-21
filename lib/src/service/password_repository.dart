import 'package:drift/drift.dart';
import 'package:kdbx/kdbx.dart';
import '../database/database.dart';
import '../domain/password.dart';

class PasswordRepository {
  final AppDb db;

  PasswordRepository(this.db);

  Future<List<Password>> list() async {
    final items = await db.passwords.select().get();
    return items.map((item) => Password.fromEntity(item)).toList();
  }

  Future<List<Password>> listByCategory(int category) async {
    final items = await (db.passwords.select()
          ..where((i) => i.categoryId.equals(category)))
        .get();
    return items.map((item) => Password.fromEntity(item)).toList();
  }

  Future<List<Password>> listByType(int type) async {
    final items =
        await (db.passwords.select()..where((i) => i.type.equals(type))).get();
    return items.map((item) => Password.fromEntity(item)).toList();
  }

  Future<List<Password>> listFavorite() async {
    final items = await (db.passwords.select()
          ..where((i) => i.isFavorite.equals(1)))
        .get();
    return items.map((item) => Password.fromEntity(item)).toList();
  }

  Future<List<Password>> listDeleted() async {
    final items = await (db.passwords.select()
          ..where((i) => i.isDeleted.equals(1)))
        .get();
    return items.map((item) => Password.fromEntity(item)).toList();
  }

  Future<Password> findById(String id) async {
    final item = await (db.passwords.select()
          ..where((tbl) => tbl.id.equals(id)))
        .getSingle();

    return Password.fromEntity(item);
  }

  Future<Password> insert(Password item) async {
    assert(item.id == null);
    await db.into(db.passwords).insert(item.toCompanion());
    return item;
  }

  Future<Password> create(String title, ProtectedValue value,
      {String? url, String? username, String? remark}) async {
    final now = DateTime.now();
    final item = Password(
      type: 1,
      categoryId: 1,
      title: title,
      value: value,
      remark: remark,
      createTime: now,
      lastUpdateTime: now,
    );
    return insert(item);
  }
}
