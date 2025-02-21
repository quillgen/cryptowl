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
String _$passwordServiceHash() => r'7a3e6dcaee382902427668f334dd8de984836921';

/// See also [passwordService].
@ProviderFor(passwordService)
final passwordServiceProvider = AutoDisposeProvider<PasswordService>.internal(
  passwordService,
  name: r'passwordServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$passwordServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PasswordServiceRef = AutoDisposeProviderRef<PasswordService>;
String _$passwordRepositoryHash() =>
    r'06e68b09b6f4bf17088b4e698c7d2190ba1c0609';

/// See also [passwordRepository].
@ProviderFor(passwordRepository)
final passwordRepositoryProvider =
    AutoDisposeProvider<PasswordRepository>.internal(
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
typedef PasswordRepositoryRef = AutoDisposeProviderRef<PasswordRepository>;
String _$categoryRepositoryHash() =>
    r'65cc4f183255dbbc8075ee8d138a9ac9e641153d';

/// See also [categoryRepository].
@ProviderFor(categoryRepository)
final categoryRepositoryProvider =
    AutoDisposeProvider<CategoryRepository>.internal(
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
typedef CategoryRepositoryRef = AutoDisposeProviderRef<CategoryRepository>;
String _$userDatabaseHash() => r'9a7742a0ffcdf1396db931610eade835706ea0e8';

/// See also [userDatabase].
@ProviderFor(userDatabase)
final userDatabaseProvider = AutoDisposeProvider<AppDb>.internal(
  userDatabase,
  name: r'userDatabaseProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userDatabaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UserDatabaseRef = AutoDisposeProviderRef<AppDb>;
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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
