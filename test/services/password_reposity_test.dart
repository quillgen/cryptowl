import 'dart:math';

import 'package:cryptowl/src/common/random_util.dart';
import 'package:cryptowl/src/database/database.dart';
import 'package:cryptowl/src/service/password_repository.dart';
import 'package:drift/native.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late SqliteDb database;
  late PasswordRepository repository;

  Future<int> createPasswords() async {
    const sql = """
    insert into passwords(id, type, category_id, is_favorite, is_deleted, create_time, last_update_time, title, value) 
    values 
    ('13538618-5e6c-40e6-9863-6f2c98178bab', '1', 3, 0, 0, '2025-02-21T23:51:25.994362', '2025-02-21T23:51:25.994362', 'Dickinson and Sons', 'Est pellentesque elit ullamcorper dignissim cras.'),
    ('d4d50caa-c11d-4f36-82a4-51d953f609a6', '1', 4, 1, 0, '2025-02-21T23:51:25.998281', '2025-02-21T23:51:25.998281', 'Huels-Metz', 'Mus mauris vitae ultricies leo integer.'),
    ('81b9d308-c769-4259-b260-7c9bf2084080', '1', 4, 1, 0, '2025-02-21T23:51:25.998434', '2025-02-21T23:51:25.998434', 'Gottlieb Inc', 'Tempus imperdiet nulla malesuada pellentesque.'),
    ('8e884ba2-6890-4056-abdf-edaf8ccba434', '2', 5, 1, 0, '2025-02-21T23:51:25.998586', '2025-02-21T23:51:25.998586', 'Reichel, Pouros and Konopelski', 'Tincidunt id aliquet risus feugiat in ante.'),
    ('e7078810-3a17-4dc0-ac75-a29d96454c3f', '3', 5, 0, 0, '2025-02-21T23:51:25.998723', '2025-02-21T23:51:25.998723', 'Stiedemann-Stoltenberg', 'Sit amet facilisis magna etiam tempor.'),
    ('77ab6c98-b8dc-40dd-a693-f59ef405f246', '3', 1, 1, 0, '2025-02-21T23:51:25.998879', '2025-02-21T23:51:25.998879', 'Bradtke, Considine and Conroy', 'Massa tincidunt dui ut ornare lectus sit amet est.'),
    ('5a35316b-c2d3-455b-967d-d2fc38ab8279', '1', 5, 0, 0, '2025-02-21T23:51:25.999106', '2025-02-21T23:51:25.999106', 'McCullough Inc', 'Donec massa sapien faucibus et molestie.'),
    ('7d30b11f-ebe8-4bcc-8d9a-fac1af317800', '4', 4, 1, 0, '2025-02-21T23:51:25.999517', '2025-02-21T23:51:25.999517', 'Schneider, Cassin and Klocko', 'Erat pellentesque adipiscing commodo elit at imperdiet dui accumsan sit.'),
    ('2cfafca9-dbba-4ac1-a137-dff315a69a13', '1', 5, 0, 1, '2025-02-21T23:51:25.999807', '2025-02-21T23:51:25.999807', 'Wiegand and Sons', 'Eu augue ut lectus arcu bibendum at.'),
    ('e4bc42d3-e206-4b0b-b27f-ccdb6d633fc4', '2', 1, 1, 1, '2025-02-21T23:51:26.000254', '2025-02-21T23:51:26.000254', 'Powlowski, Strosin and Roob', 'Vel elit scelerisque mauris pellentesque.');
    """;
    return database.executor.runInsert(sql, []);
  }

  setUp(() async {
    database = SqliteDb.from(NativeDatabase.memory());
    await database.select(database.categories).get();
    // repository = PasswordRepository(database);

    await createPasswords();
  });

  tearDown(() async {
    await database.close();
  });

  test('(not a test): generate fake password data', () {
    var faker = Faker();
    var sql =
        'insert into passwords(id, type, category_id, is_favorite, is_deleted, create_time, last_update_time, title, value) \nvalues \n';
    final count = 50;
    for (var i = 0; i < count; i++) {
      final id = RandomUtil.generateUUID();
      final title = faker.company.name().replaceAll('\'', '');
      final value = faker.lorem.sentence().replaceAll('\'', '');
      final time = DateTime.now().toIso8601String();
      final category = Random().nextInt(5) + 1;
      final favorite = Random().nextInt(2);
      final deleted = Random().nextInt(2);
      final type = Random().nextInt(4) + 1;
      sql +=
          "('$id', '$type', $category, $favorite, $deleted, '$time', '$time', '$title', '$value')";
      if (i != count - 1) {
        sql += ",\n";
      } else {
        sql += ";\n";
      }
    }
    print(sql);
  }, skip: true);

  // test('should get all undeleted passwords', () async {
  //   final list = await repository.list();
  //   expect(list.length, 8);
  // });

  // test('should get deleted passwords', () async {
  //   final list = await repository.listDeleted();
  //   expect(list.length, 2);
  // });

  // test('should get favorite passwords', () async {
  //   final list = await repository.listFavorite();
  //   expect(list.length, 5);
  // });

  // test('should get passwords by type', () async {
  //   final type1 = await repository.listByType(1);
  //   final type2 = await repository.listByType(2);
  //   expect(type1.length, 4);
  //   expect(type2.length, 1);
  // });

  // test('should get passwords by category', () async {
  //   final r1 = await repository.listByCategory(5);
  //   final r2 = await repository.listByCategory(1);
  //   expect(r1.length, 3);
  //   expect(r2.length, 1);
  // });
}
