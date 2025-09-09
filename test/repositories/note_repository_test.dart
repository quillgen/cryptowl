import 'dart:math';

import 'package:cryptowl/src/common/random_util.dart';
import 'package:cryptowl/src/config/sqlite.dart';
import 'package:cryptowl/src/database/database.dart';
import 'package:cryptowl/src/domain/note.dart';
import 'package:cryptowl/src/domain/user.dart';
import 'package:cryptowl/src/providers/credentials.dart';
import 'package:cryptowl/src/repositories/note_repository.dart';
import 'package:faker/faker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kdbx/kdbx.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([Ref, KdbxFile, SqliteConfig])
import 'note_repository_test.mocks.dart';
import 'test_util.dart';

void main() {
  late SqliteDb database;
  late NoteRepository repository;

  final mockRef = MockRef();

  Future<int> createNotes() async {
    const sql = """
    INSERT INTO "t_note" 
    ("id", "content_json", "content_checksum", "content_plain", "abstract", "classification", "created_at", "updated_at") 
    VALUES 
    ('4c3d64ad-a32a-48db-ab7e-062b0fe8689c', '[{"insert":"hello "},{"insert":"world","attributes":{"b":true,"i":true,"fg":4294198070}},{"insert":"!\n"}]', '6d1d4d67fc99704a51e0029bc431a3ded13efcefd4374fd251ec2d82a00c2fa0', 'hello world!', 'hello world!', 'C', 1751382838, 1751382838);
    """;
    return database.executor.runInsert(sql, []);
  }

  setUp(() async {
    database = SqliteDb.from(openTestDatabase());

    await database.select(database.categories).get();
    repository = NoteRepository(mockRef);

    await createNotes();
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
    test('should get all undeleted notes', () async {
      final list = await repository.list(NoteSortType.dateDesc);
      expect(list.length, 1);
    });
  });
}
