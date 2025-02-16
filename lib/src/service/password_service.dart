import 'package:drift/drift.dart';
import 'package:kdbx/kdbx.dart';

import '../database/database.dart';
import '../domain/common.dart';
import '../domain/password.dart';

class PasswordService {
  Future<List<Password>> fetchAll(AppDb db) async {
    final items = await db.fetchPasswordBasics().get();
    final categories = await db.categories.select().get();
    return items
        .map(
          (item) => Password.fromEntity(
            PasswordEntity(
                id: item.id,
                title: item.title,
                expireTime: item.expireTime,
                value: "",
                remark: item.remark,
                encryptType: item.encryptType,
                createTime: item.createTime,
                lastUpdateTime: item.lastUpdateTime),
            item.categoryId == null
                ? null
                : categories.firstWhere((e) => e.id == item.categoryId),
          ),
        )
        .toList();
  }

  Future<Password> fetchById(AppDb db, int id) async {
    final item = await (db.passwords.select()
          ..where((tbl) => tbl.id.equals(id)))
        .getSingle();
    CategoryEntity? category;
    if (item.categoryId != null) {
      category = await (db.categories.select()
            ..where((tbl) => tbl.id.equals(item.categoryId!)))
          .getSingle();
    }
    return Password.fromEntity(item, category);
  }

  Future<Password> insertPassword(AppDb db, Password item) async {
    assert(item.id == null);
    final id = await db.into(db.passwords).insert(item.toCompanion());
    item.id = id;
    return item;
  }

  Future<Password> createPassword(AppDb db, String title, ProtectedValue value,
      {String? url, String? username, String? remark}) async {
    final now = DateTime.now();
    final item = Password(
      title: title,
      value: value,
      url: url,
      username: username,
      remark: remark,
      encryptType: EncryptType.none,
      createTime: now,
      lastUpdateTime: now,
    );
    return insertPassword(db, item);
  }

  Future<Password> updatePassword(
      AppDb db, int id, String title, ProtectedValue password,
      {String? url, String? username, String? remark}) async {
    final updated = await (db.passwords.update()..where((t) => t.id.equals(id)))
        .write(PasswordsCompanion(
      title: Value(title),
      value: Value(password.getText()),
      url: Value.absentIfNull(url),
      username: Value.absentIfNull(username),
      remark: Value.absentIfNull(remark),
      lastUpdateTime: Value(DateTime.now().toIso8601String()),
    ));
    assert(updated == 1);
    return fetchById(db, id);
  }

  Future<Password> deletePassword(AppDb db, int id) async {
    final item = await fetchById(db, id);
    final deleted =
        await (db.passwords.delete()..where((t) => t.id.equals(id))).go();
    assert(deleted == 1);
    return item;
  }
}
