import 'package:cryptowl/src/crypto/protected_value.dart';
import 'package:drift/drift.dart';
import 'package:logging/logging.dart';
import 'package:uuid/uuid.dart';

import '../domain/password.dart';
import 'base_repository.dart';

class PasswordRepository extends SqlcipherRepository {
  final _logger = Logger("PasswordRepository");
  final uuid = Uuid();

  PasswordRepository(super.ref);

  Future<List<PasswordBasic>> list() async {
    final db = await requireDb();
    final items = await db
        .selectPasswords((u) => OrderBy(
            [OrderingTerm(expression: u.createdAt, mode: OrderingMode.asc)]))
        .get();
    return items.map((item) {
      return PasswordBasic(
        id: item.id,
        type: item.type,
        categoryId: item.categoryId,
        title: item.title ?? "",
        expireTime: item.expireTime,
        createdAt: item.createdAt,
        updatedAt: item.updatedAt,
      );
    }).toList();
  }

  Future<Password> findById(String id) async {
    final db = await requireDb();
    final item = await (db.tPassword.select()
          ..where((tbl) => tbl.id.equals(id)))
        .getSingle();

    return Password.fromEntity(item);
  }

  Future<bool> delete(String id) async {
    return true;
  }

  Future<void> create(String title, ProtectedValue protectedValue,
      bool isTopSecret, String? user, String? remark) async {
    final db = await requireDb();
    return db.transaction(() async {});
  }

  Future<void> update(String id,
      {required String title,
      required ProtectedValue value,
      required String username,
      required String url,
      required String remark}) async {}
}
