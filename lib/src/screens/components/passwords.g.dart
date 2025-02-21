// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'passwords.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

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
String _$selectedPasswordHash() => r'b32a89f2a741b7a69ff7f1316d91de8fa01e828b';

/// See also [SelectedPassword].
@ProviderFor(SelectedPassword)
final selectedPasswordProvider =
    AutoDisposeNotifierProvider<SelectedPassword, PasswordBasic?>.internal(
  SelectedPassword.new,
  name: r'selectedPasswordProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedPasswordHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SelectedPassword = AutoDisposeNotifier<PasswordBasic?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
