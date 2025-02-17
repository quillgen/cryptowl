// This is an example unit test.
//
// A unit test tests a single function, method, or class. To learn more about
// writing unit tests, visit
// https://flutter.dev/to/unit-testing

import 'package:cryptowl/src/common/uuid_util.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('test data', () {
    test('should generate sql for test data', () {
      var faker = Faker();
      var sql =
          'insert into passwords(id, title, value, create_time, last_update_time) \nvalues \n';
      final count = 20;
      for (var i = 0; i < count; i++) {
        final id = UuidUtil.generateUUID();
        final title = faker.company.name();
        final value = faker.lorem.sentence();
        final time = DateTime.now().toIso8601String();
        sql += "('$id', '$title', '$value', '$time', '$time')";
        if (i != count - 1) {
          sql += ",\n";
        } else {
          sql += ";\n";
        }
      }
      print(sql);
    });
  });
}
