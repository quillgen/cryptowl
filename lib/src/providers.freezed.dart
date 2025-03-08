// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'providers.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ClassificationFilterState {
  bool get topSecret => throw _privateConstructorUsedError;
  bool get secret => throw _privateConstructorUsedError;
  bool get confidential => throw _privateConstructorUsedError;
  bool get includeDeleted => throw _privateConstructorUsedError;

  /// Create a copy of ClassificationFilterState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClassificationFilterStateCopyWith<ClassificationFilterState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClassificationFilterStateCopyWith<$Res> {
  factory $ClassificationFilterStateCopyWith(ClassificationFilterState value,
          $Res Function(ClassificationFilterState) then) =
      _$ClassificationFilterStateCopyWithImpl<$Res, ClassificationFilterState>;
  @useResult
  $Res call(
      {bool topSecret, bool secret, bool confidential, bool includeDeleted});
}

/// @nodoc
class _$ClassificationFilterStateCopyWithImpl<$Res,
        $Val extends ClassificationFilterState>
    implements $ClassificationFilterStateCopyWith<$Res> {
  _$ClassificationFilterStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClassificationFilterState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? topSecret = null,
    Object? secret = null,
    Object? confidential = null,
    Object? includeDeleted = null,
  }) {
    return _then(_value.copyWith(
      topSecret: null == topSecret
          ? _value.topSecret
          : topSecret // ignore: cast_nullable_to_non_nullable
              as bool,
      secret: null == secret
          ? _value.secret
          : secret // ignore: cast_nullable_to_non_nullable
              as bool,
      confidential: null == confidential
          ? _value.confidential
          : confidential // ignore: cast_nullable_to_non_nullable
              as bool,
      includeDeleted: null == includeDeleted
          ? _value.includeDeleted
          : includeDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ClassificationFilterStateImplCopyWith<$Res>
    implements $ClassificationFilterStateCopyWith<$Res> {
  factory _$$ClassificationFilterStateImplCopyWith(
          _$ClassificationFilterStateImpl value,
          $Res Function(_$ClassificationFilterStateImpl) then) =
      __$$ClassificationFilterStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool topSecret, bool secret, bool confidential, bool includeDeleted});
}

/// @nodoc
class __$$ClassificationFilterStateImplCopyWithImpl<$Res>
    extends _$ClassificationFilterStateCopyWithImpl<$Res,
        _$ClassificationFilterStateImpl>
    implements _$$ClassificationFilterStateImplCopyWith<$Res> {
  __$$ClassificationFilterStateImplCopyWithImpl(
      _$ClassificationFilterStateImpl _value,
      $Res Function(_$ClassificationFilterStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ClassificationFilterState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? topSecret = null,
    Object? secret = null,
    Object? confidential = null,
    Object? includeDeleted = null,
  }) {
    return _then(_$ClassificationFilterStateImpl(
      topSecret: null == topSecret
          ? _value.topSecret
          : topSecret // ignore: cast_nullable_to_non_nullable
              as bool,
      secret: null == secret
          ? _value.secret
          : secret // ignore: cast_nullable_to_non_nullable
              as bool,
      confidential: null == confidential
          ? _value.confidential
          : confidential // ignore: cast_nullable_to_non_nullable
              as bool,
      includeDeleted: null == includeDeleted
          ? _value.includeDeleted
          : includeDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$ClassificationFilterStateImpl implements _ClassificationFilterState {
  const _$ClassificationFilterStateImpl(
      {required this.topSecret,
      required this.secret,
      required this.confidential,
      required this.includeDeleted});

  @override
  final bool topSecret;
  @override
  final bool secret;
  @override
  final bool confidential;
  @override
  final bool includeDeleted;

  @override
  String toString() {
    return 'ClassificationFilterState(topSecret: $topSecret, secret: $secret, confidential: $confidential, includeDeleted: $includeDeleted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClassificationFilterStateImpl &&
            (identical(other.topSecret, topSecret) ||
                other.topSecret == topSecret) &&
            (identical(other.secret, secret) || other.secret == secret) &&
            (identical(other.confidential, confidential) ||
                other.confidential == confidential) &&
            (identical(other.includeDeleted, includeDeleted) ||
                other.includeDeleted == includeDeleted));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, topSecret, secret, confidential, includeDeleted);

  /// Create a copy of ClassificationFilterState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClassificationFilterStateImplCopyWith<_$ClassificationFilterStateImpl>
      get copyWith => __$$ClassificationFilterStateImplCopyWithImpl<
          _$ClassificationFilterStateImpl>(this, _$identity);
}

abstract class _ClassificationFilterState implements ClassificationFilterState {
  const factory _ClassificationFilterState(
      {required final bool topSecret,
      required final bool secret,
      required final bool confidential,
      required final bool includeDeleted}) = _$ClassificationFilterStateImpl;

  @override
  bool get topSecret;
  @override
  bool get secret;
  @override
  bool get confidential;
  @override
  bool get includeDeleted;

  /// Create a copy of ClassificationFilterState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClassificationFilterStateImplCopyWith<_$ClassificationFilterStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
