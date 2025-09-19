import 'package:cryptowl/src/database/database.dart';
import 'package:drift/drift.dart';
import 'package:logging/logging.dart';
import 'package:uuid/uuid.dart';

import '../crypto/protected_value.dart';
import '../domain/password.dart';
import 'base_repository.dart';

class PasswordRepository extends SqlcipherRepository {
  final _logger = Logger("PasswordRepository");
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

  Future<List<PasswordBasic>> listByFilters(
      List<int> classifications, bool includeDeleted) async {
    final db = await requireDb();

    var query = db.passwords.classification.isIn(classifications);
    if (!includeDeleted) {
      query = query & db.passwords.isDeleted.isValue(0);
    }

    final items = await (db.passwords.selectOnly()
          ..where(query)
          ..addColumns([
            db.passwords.id,
            db.passwords.type,
            db.passwords.classification,
            db.passwords.categoryId,
            db.passwords.title,
            db.passwords.expireTime,
            db.passwords.createTime,
            db.passwords.lastUpdateTime,
            db.passwords.isDeleted
          ]))
        .get();

    _logger.fine(
        "Selected passwords by classifications=$classifications includeDeleted=$includeDeleted, result size=${items.length}");
    // SELECT id, type, classification, title, expire_time, category_id, create_time, last_update_time
    return items.map((item) {
      return PasswordBasic(
        id: item.read(db.passwords.id)!,
        classification: item.read(db.passwords.classification)!,
        type: item.read(db.passwords.type)!,
        categoryId: item.read(db.passwords.categoryId)!,
        title: item.read(db.passwords.title)!,
        expireTime: _parseDatetime(item.read(db.passwords.expireTime)),
        createTime: _parseDatetime(item.read(db.passwords.createTime))!,
        lastUpdateTime: _parseDatetime(item.read(db.passwords.lastUpdateTime))!,
      );
    }).toList();
  }

  DateTime? _parseDatetime(String? dt) {
    return dt == null ? null : DateTime.parse(dt);
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

  Future<Password> replace(Password item) async {
    final db = await requireDb();
    await db.passwords.replaceOne(item.toCompanion());
    return item;
  }

  Future<bool> delete(String id) async {
    final db = await requireDb();
    final item = await (db.passwords.select()
          ..where((tbl) => tbl.id.equals(id)))
        .getSingle();
    final companion = item.toCompanion(false).copyWith(
        isDeleted: Value(1),
        lastUpdateTime: Value(DateTime.now().toIso8601String()));

    await db.passwords.replaceOne(companion);
    return true;
  }

  Future<bool> deletePermanently(String id) async {
    final db = await requireDb();
    return db.passwords.deleteOne(PasswordsCompanion(id: Value(id)));
  }

  Future<Password> create(
      int classification, String title, ProtectedValue value,
      {String? url, String? username, String? remark}) async {
    final now = DateTime.now();
    final item = Password(
      id: uuid.v4(),
      classification: classification,
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

  Future<Password> update(String id,
      {int? classification,
      String? title,
      ProtectedValue? value,
      String? url,
      String? username,
      String? remark}) async {
    final now = DateTime.now();
    final existing = await findById(id);
    final item = Password(
      id: id,
      type: existing.type,
      categoryId: existing.categoryId,
      title: title ?? existing.title,
      username: username ?? existing.username,
      uri: url ?? existing.uri,
      value: value ?? existing.value,
      remark: remark ?? existing.remark,
      createTime: existing.createTime,
      lastUpdateTime: now,
    );
    return replace(item);
  }
}
