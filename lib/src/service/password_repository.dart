import 'package:drift/drift.dart';
import 'package:kdbx/kdbx.dart';
import 'package:uuid/uuid.dart';

import '../domain/password.dart';
import 'base_repository.dart';

class PasswordRepository extends SqlcipherRepository {
  final uuid = Uuid();

  PasswordRepository(super.ref);

  Future<List<PasswordBasic>> list() async {
    final db = await requireDb();
    final items = await db.activePasswords().get();
    return items.map((item) {
      return PasswordBasic(
        id: item.id,
        type: item.type,
        categoryId: item.categoryId,
        title: item.title,
        expireTime:
            item.expireTime == null ? null : DateTime.parse(item.expireTime!),
        createTime: DateTime.parse(item.createTime),
        lastUpdateTime: DateTime.parse(item.lastUpdateTime),
      );
    }).toList();
  }

  Future<List<PasswordBasic>> listByCategory(int category) async {
    final db = await requireDb();
    final items = await db.passwordsByCategory(category).get();
    return items.map((item) {
      return PasswordBasic(
        id: item.id,
        type: item.type,
        categoryId: item.categoryId,
        title: item.title,
        expireTime:
            item.expireTime == null ? null : DateTime.parse(item.expireTime!),
        createTime: DateTime.parse(item.createTime),
        lastUpdateTime: DateTime.parse(item.lastUpdateTime),
      );
    }).toList();
  }

  Future<List<PasswordBasic>> listByType(int type) async {
    final db = await requireDb();
    final items = await db.passwordsByType(type).get();
    return items.map((item) {
      return PasswordBasic(
        id: item.id,
        type: item.type,
        categoryId: item.categoryId,
        title: item.title,
        expireTime:
            item.expireTime == null ? null : DateTime.parse(item.expireTime!),
        createTime: DateTime.parse(item.createTime),
        lastUpdateTime: DateTime.parse(item.lastUpdateTime),
      );
    }).toList();
  }

  Future<List<PasswordBasic>> listFavorite() async {
    final db = await requireDb();
    final items = await db.favoritePasswords().get();
    return items.map((item) {
      return PasswordBasic(
        id: item.id,
        type: item.type,
        categoryId: item.categoryId,
        title: item.title,
        expireTime:
            item.expireTime == null ? null : DateTime.parse(item.expireTime!),
        createTime: DateTime.parse(item.createTime),
        lastUpdateTime: DateTime.parse(item.lastUpdateTime),
      );
    }).toList();
  }

  Future<List<PasswordBasic>> listDeleted() async {
    final db = await requireDb();
    final items = await db.deletedPasswords().get();
    return items.map((item) {
      return PasswordBasic(
        id: item.id,
        type: item.type,
        categoryId: item.categoryId,
        title: item.title,
        expireTime:
            item.expireTime == null ? null : DateTime.parse(item.expireTime!),
        createTime: DateTime.parse(item.createTime),
        lastUpdateTime: DateTime.parse(item.lastUpdateTime),
      );
    }).toList();
  }

  Future<Password> findById(String id) async {
    final db = await requireDb();
    final item = await (db.passwords.select()
          ..where((tbl) => tbl.id.equals(id)))
        .getSingle();

    return Password.fromEntity(item);
  }

  Future<Password> insert(Password item) async {
    final db = await requireDb();
    await db.into(db.passwords).insert(item.toCompanion());
    return item;
  }

  Future<Password> create(
      int classification, String title, ProtectedValue value,
      {String? url, String? username, String? remark}) async {
    final now = DateTime.now();
    final item = Password(
      id: uuid.v4(),
      type: 1,
      categoryId: 1,
      title: title,
      username: username,
      uri: url,
      value: value,
      remark: remark,
      createTime: now,
      lastUpdateTime: now,
    );
    return insert(item);
  }
}
