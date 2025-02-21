import 'package:cryptowl/main.dart';
import 'package:cryptowl/src/service/password_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'database/database.dart';
import 'domain/user.dart';
import 'service/app_service.dart';
import 'service/category_repository.dart';
import 'service/kdbx_service.dart';
import 'service/password_service.dart';

part 'providers.g.dart';

@riverpod
KdbxService kdbxService(Ref ref) {
  return KdbxService();
}

@riverpod
AppService appService(Ref ref) {
  return AppService(ref, ref.read(kdbxServiceProvider));
}

@riverpod
PasswordService passwordService(Ref ref) {
  return PasswordService();
}

@riverpod
PasswordRepository passwordRepository(Ref ref) {
  final db = ref.watch(userDatabaseProvider);
  return PasswordRepository(db);
}

@riverpod
CategoryRepository categoryRepository(Ref ref) {
  final db = ref.watch(userDatabaseProvider);
  return CategoryRepository(db);
}

@Riverpod(keepAlive: true)
class CurrentUser extends _$CurrentUser {
  @override
  User? build() {
    return null;
  }

  void setUser(User? user) => state = user;
}

@Riverpod(keepAlive: false)
AppDb userDatabase(Ref ref) {
  logger.fine("opening user db...");
  final currentUser = ref.watch(currentUserProvider);
  if (currentUser == null) {
    logger.severe("Current user not logged in!");
    throw Exception("User not login");
  }
  final meta = currentUser.meta;
  final db = AppDb.open("${meta.dbInstance}.enc", meta.dbEncryptionKey);
  ref.onDispose(() {
    logger.fine("Disposing db...");
    db.close();
  });
  return db;
}

@riverpod
class InitState extends _$InitState {
  @override
  bool? build() {
    return null;
  }

  Future<void> checkInit() async {
    final appService = ref.read(appServiceProvider);
    final inited = await appService.isInitialized();
    await Future.delayed(const Duration(seconds: 1));
    state = inited;
  }

  void setInitState(bool? inited) => state = inited;
}
