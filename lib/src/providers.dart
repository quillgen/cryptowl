import 'package:cryptowl/main.dart';
import 'package:cryptowl/src/service/password_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'database/database.dart';
import 'domain/category.dart';
import 'domain/password.dart';
import 'domain/user.dart';
import 'service/app_service.dart';
import 'service/category_repository.dart';
import 'service/kdbx_service.dart';

part 'providers.g.dart';

@riverpod
KdbxService kdbxService(Ref ref) {
  return KdbxService();
}

@riverpod
AppService appService(Ref ref) {
  return AppService(ref, ref.read(kdbxServiceProvider));
}

@Riverpod(keepAlive: true)
PasswordRepository passwordRepository(Ref ref) {
  final db = ref.watch(userDatabaseProvider);
  return PasswordRepository(db);
}

@Riverpod(keepAlive: true)
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

@Riverpod(keepAlive: true)
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

@riverpod
Future<PackageInfo> packageInfo(Ref ref) async {
  return PackageInfo.fromPlatform();
}

const CATEGORY_ALL_ITEMS = 0;
const CATEGORY_FAVORITE = -1;
const CATEGORY_DELETED = -2;
const CATEGORY_LOGIN = -11;
const CATEGORY_CARD = -12;
const CATEGORY_SSH_KEY = -13;

@riverpod
Future<List<Category>> categories(Ref ref) async {
  return ref.watch(categoryRepositoryProvider).list();
}

@riverpod
class SelectedCategory extends _$SelectedCategory {
  @override
  int build() {
    return 0;
  }

  void setSelectedCategory(int selected) {
    state = selected;
  }
}

@riverpod
Future<List<PasswordBasic>> passwords(Ref ref) async {
  final selectedCategory = ref.watch(selectedCategoryProvider);
  final repository = ref.read(passwordRepositoryProvider);
  logger.fine("Fetching passwords with category=$selectedCategory");
  switch (selectedCategory) {
    case CATEGORY_ALL_ITEMS:
      return repository.list();
    case CATEGORY_FAVORITE:
      return repository.listFavorite();
    case CATEGORY_DELETED:
      return repository.listDeleted();
    case CATEGORY_LOGIN:
    case CATEGORY_CARD:
    case CATEGORY_SSH_KEY:
      {
        final type = -(10 + selectedCategory);
        return repository.listByType(type);
      }
    default:
      return repository.listByCategory(selectedCategory);
  }
}
