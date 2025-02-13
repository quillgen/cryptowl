// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$authenticationHash() => r'7d101e977350629a038be491bac7452b34a8b165';

/// See also [Authentication].
@ProviderFor(Authentication)
final authenticationProvider = AutoDisposeNotifierProvider<Authentication,
    AsyncValue<Credentials?>>.internal(
  Authentication.new,
  name: r'authenticationProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authenticationHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Authentication = AutoDisposeNotifier<AsyncValue<Credentials?>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
