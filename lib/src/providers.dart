import 'package:cryptowl/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kdbx/kdbx.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'config/meta.dart';
import 'database/database.dart';
import 'domain/user.dart';
import 'service/app_service.dart';
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

@Riverpod(keepAlive: true)
class CurrentUser extends _$CurrentUser {
  @override
  User? build() {
    return null;
  }

  void setUser(User user) => state = user;
}

@Riverpod(keepAlive: true)
AppDb userDatabase(Ref ref) {
  logger.fine("opening user db...");
  final currentUser = ref.watch(currentUserProvider);
  if (currentUser == null) {
    throw Exception("User not login");
  }
  final meta = currentUser.meta;
  final db = AppDb.open("${meta.dbInstance}.enc", meta.dbEncryptionKey);
  ref.onDispose(() => db.close());
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
