import 'package:cryptowl/src/database/database.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late SqliteDb database;

  setUp(() async {
    database = SqliteDb.from(NativeDatabase.memory());
    await database
        .select(database.categories)
        .get(); // ensure drift is initiallized
  });

  tearDown(() async {
    await database.close();
  });

  test('should get all categories', () async {
    final list = await database.select(database.categories).get();
    expect(list.length, 1);
  });
}
