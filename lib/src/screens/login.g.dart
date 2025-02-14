// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$currentUserHash() => r'19f3233499098196e7b07527325115d4a2006d5d';

/// See also [CurrentUser].
@ProviderFor(CurrentUser)
final currentUserProvider =
    AutoDisposeNotifierProvider<CurrentUser, Credentials?>.internal(
  CurrentUser.new,
  name: r'currentUserProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$currentUserHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CurrentUser = AutoDisposeNotifier<Credentials?>;
String _$loginStateHash() => r'059e041ad55cab662775f6dc5ff92793e42d46a0';

/// See also [LoginState].
@ProviderFor(LoginState)
final loginStateProvider =
    AutoDisposeNotifierProvider<LoginState, AsyncValue<bool>>.internal(
  LoginState.new,
  name: r'loginStateProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$loginStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$LoginState = AutoDisposeNotifier<AsyncValue<bool>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
