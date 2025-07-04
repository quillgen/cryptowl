import 'package:cryptowl/src/config/sqlite.dart';
import 'package:cryptowl/src/database/database.dart';
import 'package:cryptowl/src/domain/user.dart';
import 'package:cryptowl/src/providers/credentials.dart';
import 'package:cryptowl/src/repositories/note_repository.dart';
import 'package:cryptowl/src/service/note_service.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kdbx/kdbx.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([Ref, KdbxFile, SqliteConfig])
import 'note_service_test.mocks.dart';

void main() {
  late SqliteDb database;
  late NoteRepository repository;
  late NoteService service;

  final mockRef = MockRef();

  setUp(() async {
    database = SqliteDb.from(NativeDatabase.memory());
    await database.select(database.categories).get();
    repository = NoteRepository(mockRef);
    service = NoteService(repository);

    provideDummy<Future<Session?>>(Future.value(null));

    when(mockRef.read(asyncLoginProvider.future)).thenAnswer(
        (_) async => Session(MockKdbxFile(), MockSqliteConfig(), database));
  });

  tearDown(() async {
    await database.close();
  });
}
