// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cryptowl/src/database/database.dart';

import '../test_util/database_helper.dart';

void main() {
  late AppDb database;

  setUp(() async {
    database = AppDb.from(NativeDatabase.memory());
    await database
        .select(database.categories)
        .get(); // ensure drift is initiallized

    final helper = DatabaseHelper(database);
    await helper.createCategory(1, "test");
  });

  tearDown(() async {
    await database.close();
  });

  test('should get all categories', () async {
    final list = await database.select(database.categories).get();
    expect(list.length, 1);
  });
}
