import 'package:cryptowl/src/database/database.dart';
import 'package:cryptowl/src/repositories/password_repository.dart';
import 'package:cryptowl/src/service/kdf_service.dart';
import 'package:cryptowl/src/service/password_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import '../repositories/test_util.dart';
@GenerateNiceMocks([MockSpec<KdfService>(), MockSpec<PasswordRepository>()])
import 'password_service_test.mocks.dart';

void main() {
  late SqliteDb database;
  late MockKdfService mockKdfService;
  late MockPasswordRepository mockPasswordRepository;
  late PasswordService service;

  setUp(() async {
    setupArgon2();
    database = SqliteDb.from(openTestDatabase());
    await database.select(database.categories).get();
    mockKdfService = MockKdfService();
    mockPasswordRepository = MockPasswordRepository();
    service = PasswordService(mockKdfService, mockPasswordRepository);
  });

  tearDown(() async {
    await database.close();
  });
}
