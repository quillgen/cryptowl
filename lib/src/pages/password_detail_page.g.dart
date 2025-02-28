// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'password_detail_page.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$passwordDetailHash() => r'e95d1de689a866aef5f2aa0865ef4a0dd676a1b6';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [passwordDetail].
@ProviderFor(passwordDetail)
const passwordDetailProvider = PasswordDetailFamily();

/// See also [passwordDetail].
class PasswordDetailFamily extends Family<AsyncValue<Password>> {
  /// See also [passwordDetail].
  const PasswordDetailFamily();

  /// See also [passwordDetail].
  PasswordDetailProvider call(
    String id,
  ) {
    return PasswordDetailProvider(
      id,
    );
  }

  @override
  PasswordDetailProvider getProviderOverride(
    covariant PasswordDetailProvider provider,
  ) {
    return call(
      provider.id,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'passwordDetailProvider';
}

/// See also [passwordDetail].
class PasswordDetailProvider extends AutoDisposeFutureProvider<Password> {
  /// See also [passwordDetail].
  PasswordDetailProvider(
    String id,
  ) : this._internal(
          (ref) => passwordDetail(
            ref as PasswordDetailRef,
            id,
          ),
          from: passwordDetailProvider,
          name: r'passwordDetailProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$passwordDetailHash,
          dependencies: PasswordDetailFamily._dependencies,
          allTransitiveDependencies:
              PasswordDetailFamily._allTransitiveDependencies,
          id: id,
        );

  PasswordDetailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    FutureOr<Password> Function(PasswordDetailRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PasswordDetailProvider._internal(
        (ref) => create(ref as PasswordDetailRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Password> createElement() {
    return _PasswordDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PasswordDetailProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PasswordDetailRef on AutoDisposeFutureProviderRef<Password> {
  /// The parameter `id` of this provider.
  String get id;
}

class _PasswordDetailProviderElement
    extends AutoDisposeFutureProviderElement<Password> with PasswordDetailRef {
  _PasswordDetailProviderElement(super.provider);

  @override
  String get id => (origin as PasswordDetailProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
