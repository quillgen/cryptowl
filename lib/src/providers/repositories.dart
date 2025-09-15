import 'package:cryptowl/src/repositories/category_repository.dart';
import 'package:cryptowl/src/repositories/note_repository.dart';
import 'package:cryptowl/src/repositories/password_repository.dart';
import 'package:cryptowl/src/service/app_service.dart';
import 'package:cryptowl/src/service/file_service.dart';
import 'package:cryptowl/src/service/kdf_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../service/note_service.dart';

final categoryRepositoryProvider = Provider((ref) {
  return CategoryRepository(ref);
});

final passwordRepositoryProvider = Provider((ref) {
  return PasswordRepository(ref);
});

final noteRepositoryProvider = Provider((ref) {
  return NoteRepository(ref);
});

final fileServiceProvider = Provider((ref) {
  return FileService();
});

final kdfServiceProvider = Provider((ref) {
  return KdfService();
});

final noteServiceProvider = Provider((ref) {
  return NoteService(
    ref.read(noteRepositoryProvider),
  );
});

final appServiceProvider = Provider((ref) {
  return AppService(
    ref.read(fileServiceProvider),
    ref.read(kdfServiceProvider),
  );
});
