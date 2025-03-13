import 'package:cryptowl/src/service/app_service.dart';
import 'package:cryptowl/src/service/category_repository.dart';
import 'package:cryptowl/src/service/file_service.dart';
import 'package:cryptowl/src/service/kdbx_repository.dart';
import 'package:cryptowl/src/service/password_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final kdbxRepositoryProvider = Provider((ref) {
  return KdbxRepository(ref);
});

final categoryRepositoryProvider = Provider((ref) {
  return CategoryRepository(ref);
});

final passwordRepositoryProvider = Provider((ref) {
  return PasswordRepository(ref);
});

final fileServiceProvider = Provider((ref) {
  return FileService();
});

final appServiceProvider = Provider((ref) {
  return AppService(
    ref,
    ref.read(fileServiceProvider),
  );
});
