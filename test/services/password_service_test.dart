// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:cryptowl/src/database/database.dart';
import 'package:cryptowl/src/service/password_service.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_util/database_helper.dart';

void main() {
  late AppDb database;
  final service = PasswordService();

  setUp(() async {
    database = AppDb.from(NativeDatabase.memory());
    await database.select(database.categories).get();

    final helper = DatabaseHelper(database);
    await helper.createPassword(1, "test1", "password1");
    await helper.createPassword(2, "test2", "password2");
  });

  tearDown(() async {
    await database.close();
  });

  test('should get all passwords', () async {
    final list = await service.fetchAll(database);
    expect(list.length, 2);
  });
}
