// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$kdbxServiceHash() => r'48c787a4da4cb9d4d7e4ba89153605b60b89fca0';

/// See also [kdbxService].
@ProviderFor(kdbxService)
final kdbxServiceProvider = AutoDisposeProvider<KdbxService>.internal(
  kdbxService,
  name: r'kdbxServiceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$kdbxServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef KdbxServiceRef = AutoDisposeProviderRef<KdbxService>;
String _$appServiceHash() => r'3c36ad8d532acbbbb527f693f8fcf03f87aa9ef2';

/// See also [appService].
@ProviderFor(appService)
final appServiceProvider = AutoDisposeProvider<AppService>.internal(
  appService,
  name: r'appServiceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$appServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AppServiceRef = AutoDisposeProviderRef<AppService>;
String _$passwordRepositoryHash() =>
    r'86b83492875ce1f0a6338ede94ad0ded972e2324';

/// See also [passwordRepository].
@ProviderFor(passwordRepository)
final passwordRepositoryProvider = Provider<PasswordRepository>.internal(
  passwordRepository,
  name: r'passwordRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$passwordRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PasswordRepositoryRef = ProviderRef<PasswordRepository>;
String _$categoryRepositoryHash() =>
    r'c5a84246ae3ffc7edcc7441eb8bda5e8f286e27b';

/// See also [categoryRepository].
@ProviderFor(categoryRepository)
final categoryRepositoryProvider = Provider<CategoryRepository>.internal(
  categoryRepository,
  name: r'categoryRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$categoryRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CategoryRepositoryRef = ProviderRef<CategoryRepository>;
String _$userDatabaseHash() => r'99ddb816d972a970aff559738b1695a832497af3';

/// See also [userDatabase].
@ProviderFor(userDatabase)
final userDatabaseProvider = Provider<AppDb>.internal(
  userDatabase,
  name: r'userDatabaseProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userDatabaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UserDatabaseRef = ProviderRef<AppDb>;
String _$packageInfoHash() => r'907ba5b02ed285ba1e951e58a932554b0a8da650';

/// See also [packageInfo].
@ProviderFor(packageInfo)
final packageInfoProvider = AutoDisposeFutureProvider<PackageInfo>.internal(
  packageInfo,
  name: r'packageInfoProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$packageInfoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PackageInfoRef = AutoDisposeFutureProviderRef<PackageInfo>;
String _$categoriesHash() => r'f62895ef7ece27a9d7c5d33bc71a9a22dd483c35';

/// See also [categories].
@ProviderFor(categories)
final categoriesProvider = AutoDisposeFutureProvider<List<Category>>.internal(
  categories,
  name: r'categoriesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$categoriesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CategoriesRef = AutoDisposeFutureProviderRef<List<Category>>;
String _$passwordsHash() => r'fe6af36eba2ea58a3b4885ba110992fd8ae86d44';

/// See also [passwords].
@ProviderFor(passwords)
final passwordsProvider =
    AutoDisposeFutureProvider<List<PasswordBasic>>.internal(
  passwords,
  name: r'passwordsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$passwordsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PasswordsRef = AutoDisposeFutureProviderRef<List<PasswordBasic>>;
String _$currentUserHash() => r'914d37ced3f0f492908c1995f8e44b88aa4fff0c';

/// See also [CurrentUser].
@ProviderFor(CurrentUser)
final currentUserProvider = NotifierProvider<CurrentUser, User?>.internal(
  CurrentUser.new,
  name: r'currentUserProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$currentUserHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CurrentUser = Notifier<User?>;
String _$initStateHash() => r'84c53f6b05470c171ca081ce16dc12309611e9e1';

/// See also [InitState].
@ProviderFor(InitState)
final initStateProvider =
    AutoDisposeNotifierProvider<InitState, bool?>.internal(
  InitState.new,
  name: r'initStateProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$initStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$InitState = AutoDisposeNotifier<bool?>;
String _$selectedCategoryHash() => r'f36f2f15f678bf45945040c2c0612e492c370f68';

/// See also [SelectedCategory].
@ProviderFor(SelectedCategory)
final selectedCategoryProvider =
    AutoDisposeNotifierProvider<SelectedCategory, int>.internal(
  SelectedCategory.new,
  name: r'selectedCategoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedCategoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SelectedCategory = AutoDisposeNotifier<int>;
String _$classificationFiltersHash() =>
    r'a3ad2fac2ea28986c5e8fa65ebf79ad1c511bf82';

/// See also [ClassificationFilters].
@ProviderFor(ClassificationFilters)
final classificationFiltersProvider = AutoDisposeNotifierProvider<
    ClassificationFilters, ClassificationFilterState>.internal(
  ClassificationFilters.new,
  name: r'classificationFiltersProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$classificationFiltersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ClassificationFilters
    = AutoDisposeNotifier<ClassificationFilterState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
