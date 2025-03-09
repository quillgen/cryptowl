import 'package:drift/drift.dart';

import '../database/database.dart';
import '../domain/category.dart';

class CategoryRepository {
  final SqliteDb db;

  CategoryRepository(this.db);

  Future<List<Category>> list() async {
    final items = await db.categories.select().get();
    return items.map((item) => Category.fromEntity(item)).toList();
  }
}
