import 'package:cryptowl/src/database/database.dart';
import 'package:cryptowl/src/service/category_repository.dart';
import 'package:drift/native.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late SqliteDb database;
  late CategoryRepository repository;

  Future<int> createCategories() async {
    const sql = """
    insert into categories(id, name, access_level, create_time, last_update_time) 
    values 
    ('2', 'DuBuque-Waters', 1, '2025-02-22T00:00:27.765472', '2025-02-22T00:00:27.765472'),
    ('3', 'Hintz, Carter and McLaughlin', 1, '2025-02-22T00:00:27.765571', '2025-02-22T00:00:27.765571'),
    ('4', 'Langosh, Watsica and Hoppe', 1, '2025-02-22T00:00:27.765593', '2025-02-22T00:00:27.765593'),
    ('5', 'Grimes and Sons', 1, '2025-02-22T00:00:27.765711', '2025-02-22T00:00:27.765711');
    """;
    return database.executor.runInsert(sql, []);
  }

  setUp(() async {
    database = SqliteDb.from(NativeDatabase.memory());
    await database.select(database.categories).get();
    repository = CategoryRepository(database);

    await createCategories();
  });

  tearDown(() async {
    await database.close();
  });

  test('(not a test): generate fake category data', () {
    var faker = Faker();
    var sql =
        'insert into categories(id, name, access_level, create_time, last_update_time) \nvalues \n';
    final count = 20;
    for (var i = 2; i < count; i++) {
      final name = faker.company.name();

      final time = DateTime.now().toIso8601String();
      sql += "('$i', '$name', 1, '$time', '$time')";
      if (i != count - 1) {
        sql += ",\n";
      } else {
        sql += ";\n";
      }
    }
    print(sql);
  }, skip: true);

  test('should get all categories', () async {
    final list = await repository.list();
    expect(list.length, 5); // category 1 is default and migrated
  });
}
