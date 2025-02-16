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
String _$userDatabaseHash() => r'c3e22e7508cdec36a028e0bc972ac27577e83029';

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
String _$currentUserHash() => r'eb4dca39bc198684cf9e0096e64c53dff1878306';

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
