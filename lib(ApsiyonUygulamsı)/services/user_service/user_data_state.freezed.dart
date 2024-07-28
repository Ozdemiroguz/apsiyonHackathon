// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_data_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$UserDataState {
  UserData get userData => throw _privateConstructorUsedError;
  ApsiyonPoint? get apsiyonPoint => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UserDataStateCopyWith<UserDataState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserDataStateCopyWith<$Res> {
  factory $UserDataStateCopyWith(
          UserDataState value, $Res Function(UserDataState) then) =
      _$UserDataStateCopyWithImpl<$Res, UserDataState>;
  @useResult
  $Res call({UserData userData, ApsiyonPoint? apsiyonPoint});

  $UserDataCopyWith<$Res> get userData;
}

/// @nodoc
class _$UserDataStateCopyWithImpl<$Res, $Val extends UserDataState>
    implements $UserDataStateCopyWith<$Res> {
  _$UserDataStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userData = null,
    Object? apsiyonPoint = freezed,
  }) {
    return _then(_value.copyWith(
      userData: null == userData
          ? _value.userData
          : userData // ignore: cast_nullable_to_non_nullable
              as UserData,
      apsiyonPoint: freezed == apsiyonPoint
          ? _value.apsiyonPoint
          : apsiyonPoint // ignore: cast_nullable_to_non_nullable
              as ApsiyonPoint?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserDataCopyWith<$Res> get userData {
    return $UserDataCopyWith<$Res>(_value.userData, (value) {
      return _then(_value.copyWith(userData: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserDataStateImplCopyWith<$Res>
    implements $UserDataStateCopyWith<$Res> {
  factory _$$UserDataStateImplCopyWith(
          _$UserDataStateImpl value, $Res Function(_$UserDataStateImpl) then) =
      __$$UserDataStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({UserData userData, ApsiyonPoint? apsiyonPoint});

  @override
  $UserDataCopyWith<$Res> get userData;
}

/// @nodoc
class __$$UserDataStateImplCopyWithImpl<$Res>
    extends _$UserDataStateCopyWithImpl<$Res, _$UserDataStateImpl>
    implements _$$UserDataStateImplCopyWith<$Res> {
  __$$UserDataStateImplCopyWithImpl(
      _$UserDataStateImpl _value, $Res Function(_$UserDataStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userData = null,
    Object? apsiyonPoint = freezed,
  }) {
    return _then(_$UserDataStateImpl(
      userData: null == userData
          ? _value.userData
          : userData // ignore: cast_nullable_to_non_nullable
              as UserData,
      apsiyonPoint: freezed == apsiyonPoint
          ? _value.apsiyonPoint
          : apsiyonPoint // ignore: cast_nullable_to_non_nullable
              as ApsiyonPoint?,
    ));
  }
}

/// @nodoc

class _$UserDataStateImpl extends _UserDataState {
  _$UserDataStateImpl({required this.userData, required this.apsiyonPoint})
      : super._();

  @override
  final UserData userData;
  @override
  final ApsiyonPoint? apsiyonPoint;

  @override
  String toString() {
    return 'UserDataState(userData: $userData, apsiyonPoint: $apsiyonPoint)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserDataStateImpl &&
            (identical(other.userData, userData) ||
                other.userData == userData) &&
            (identical(other.apsiyonPoint, apsiyonPoint) ||
                other.apsiyonPoint == apsiyonPoint));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userData, apsiyonPoint);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserDataStateImplCopyWith<_$UserDataStateImpl> get copyWith =>
      __$$UserDataStateImplCopyWithImpl<_$UserDataStateImpl>(this, _$identity);
}

abstract class _UserDataState extends UserDataState {
  factory _UserDataState(
      {required final UserData userData,
      required final ApsiyonPoint? apsiyonPoint}) = _$UserDataStateImpl;
  _UserDataState._() : super._();

  @override
  UserData get userData;
  @override
  ApsiyonPoint? get apsiyonPoint;
  @override
  @JsonKey(ignore: true)
  _$$UserDataStateImplCopyWith<_$UserDataStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
