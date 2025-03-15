import 'dart:math';

import 'package:cryptowl/src/common/random_util.dart';
import 'package:cryptowl/src/config/sqlite.dart';
import 'package:cryptowl/src/database/database.dart';
import 'package:cryptowl/src/domain/password.dart';
import 'package:cryptowl/src/domain/user.dart';
import 'package:cryptowl/src/providers/credentials.dart';
import 'package:cryptowl/src/repositories/note_repository.dart';
import 'package:drift/native.dart';
import 'package:faker/faker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kdbx/kdbx.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([Ref, KdbxFile, SqliteConfig])
import 'note_repository_test.mocks.dart';

void main() {
  late SqliteDb database;
  late NoteRepository repository;

  final mockRef = MockRef();

  Future<int> createPasswords() async {
    const sql = """
    insert into notes(id, classification, category_id, is_favorite, is_deleted, create_time, last_update_time, title, content) 
    values 
    ('c5d26f69-7088-487e-87eb-497c51728bc2',  0, 2, 1, 0, '2025-03-15T10:05:24.832721', '2025-03-15T10:05:24.832721', 'Lehner, Nicolas and Christiansen', 'Pellentesque eu tincidunt tortor aliquam nulla.'),
    ('1eda2fd8-07d6-463e-8994-74538310a10c', 99, 4, 1, 0, '2025-03-15T10:05:24.833188', '2025-03-15T10:05:24.833188', 'Daniel-Yost', 'Dolor sed viverra ipsum nunc aliquet bibendum enim facilisis.'),
    ('19960ced-bc14-45a6-a90f-d7811b42aa67', -1, 3, 1, 0, '2025-03-15T10:05:24.833499', '2025-03-15T10:05:24.833499', 'Jones Group', 'Aliquet porttitor lacus luctus accumsan tortor posuere ac.'),
    ('6b803d24-46e9-4559-bef1-ad592ac2bae5',  0, 2, 1, 0, '2025-03-15T10:05:24.833656', '2025-03-15T10:05:24.833656', 'Schimmel, Abernathy and Auer', 'Nunc id cursus metus aliquam.'),
    ('fac93fcf-5630-42b0-9c8d-7d1168506f1a',  0, 3, 1, 1, '2025-03-15T10:05:24.833871', '2025-03-15T10:05:24.833871', 'Block-Quigley', 'Mattis rhoncus urna neque viverra justo.');
    """;
    return database.executor.runInsert(sql, []);
  }

  setUp(() async {
    database = SqliteDb.from(NativeDatabase.memory());
    await database.select(database.categories).get();
    repository = NoteRepository(mockRef);

    await createPasswords();
    provideDummy<Future<Session?>>(Future.value(null));

    when(mockRef.read(asyncLoginProvider.future)).thenAnswer(
        (_) async => Session(MockKdbxFile(), MockSqliteConfig(), database));
  });

  tearDown(() async {
    await database.close();
  });

  test('(not a test): generate fake notes data', () {
    var faker = Faker();
    var sql =
        'insert into notes(id, classification, category_id, is_favorite, is_deleted, create_time, last_update_time, title, content) \nvalues \n';
    final count = 5;
    for (var i = 0; i < count; i++) {
      final id = RandomUtil.generateUUID();
      final title = faker.company.name().replaceAll('\'', '');
      final value = faker.lorem.sentence().replaceAll('\'', '');
      final time = DateTime.now().toIso8601String();
      final category = Random().nextInt(5) + 1;
      final favorite = Random().nextInt(2);
      final deleted = Random().nextInt(2);

      sql +=
          "('$id', 0, $category, $favorite, $deleted, '$time', '$time', '$title', '$value')";
      if (i != count - 1) {
        sql += ",\n";
      } else {
        sql += ";\n";
      }
    }
    print(sql);
  }, skip: true);

  group("select by filters", () {
    test('should get notes by classifications', () async {
      final list = await repository.listByFilters([TOP_SECRET], false);
      expect(list.length, 1);
    });

    test('should get notes by classifications', () async {
      final list =
          await repository.listByFilters([TOP_SECRET, CONFIDENTIAL], false);
      expect(list.length, 2);
    });

    test('should get notes3v neewsuk,x  including deleted', () async {
      final list = await repository.listByFilters([SECRET], true);
      expect(list.length, 3);
    });
  });
}
