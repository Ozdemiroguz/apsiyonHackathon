// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LoginState {
  bool get isLoading => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  Option<Failure> get failure => throw _privateConstructorUsedError;
  Option<ValueFailure> get emailFailure => throw _privateConstructorUsedError;
  Option<ValueFailure> get passwordFailure =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LoginStateCopyWith<LoginState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginStateCopyWith<$Res> {
  factory $LoginStateCopyWith(
          LoginState value, $Res Function(LoginState) then) =
      _$LoginStateCopyWithImpl<$Res, LoginState>;
  @useResult
  $Res call(
      {bool isLoading,
      String email,
      String password,
      Option<Failure> failure,
      Option<ValueFailure> emailFailure,
      Option<ValueFailure> passwordFailure});
}

/// @nodoc
class _$LoginStateCopyWithImpl<$Res, $Val extends LoginState>
    implements $LoginStateCopyWith<$Res> {
  _$LoginStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? email = null,
    Object? password = null,
    Object? failure = null,
    Object? emailFailure = null,
    Object? passwordFailure = null,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      failure: null == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Option<Failure>,
      emailFailure: null == emailFailure
          ? _value.emailFailure
          : emailFailure // ignore: cast_nullable_to_non_nullable
              as Option<ValueFailure>,
      passwordFailure: null == passwordFailure
          ? _value.passwordFailure
          : passwordFailure // ignore: cast_nullable_to_non_nullable
              as Option<ValueFailure>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoginStateImplCopyWith<$Res>
    implements $LoginStateCopyWith<$Res> {
  factory _$$LoginStateImplCopyWith(
          _$LoginStateImpl value, $Res Function(_$LoginStateImpl) then) =
      __$$LoginStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      String email,
      String password,
      Option<Failure> failure,
      Option<ValueFailure> emailFailure,
      Option<ValueFailure> passwordFailure});
}

/// @nodoc
class __$$LoginStateImplCopyWithImpl<$Res>
    extends _$LoginStateCopyWithImpl<$Res, _$LoginStateImpl>
    implements _$$LoginStateImplCopyWith<$Res> {
  __$$LoginStateImplCopyWithImpl(
      _$LoginStateImpl _value, $Res Function(_$LoginStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? email = null,
    Object? password = null,
    Object? failure = null,
    Object? emailFailure = null,
    Object? passwordFailure = null,
  }) {
    return _then(_$LoginStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      failure: null == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Option<Failure>,
      emailFailure: null == emailFailure
          ? _value.emailFailure
          : emailFailure // ignore: cast_nullable_to_non_nullable
              as Option<ValueFailure>,
      passwordFailure: null == passwordFailure
          ? _value.passwordFailure
          : passwordFailure // ignore: cast_nullable_to_non_nullable
              as Option<ValueFailure>,
    ));
  }
}

/// @nodoc

class _$LoginStateImpl extends _LoginState {
  _$LoginStateImpl(
      {required this.isLoading,
      required this.email,
      required this.password,
      required this.failure,
      required this.emailFailure,
      required this.passwordFailure})
      : super._();

  @override
  final bool isLoading;
  @override
  final String email;
  @override
  final String password;
  @override
  final Option<Failure> failure;
  @override
  final Option<ValueFailure> emailFailure;
  @override
  final Option<ValueFailure> passwordFailure;

  @override
  String toString() {
    return 'LoginState(isLoading: $isLoading, email: $email, password: $password, failure: $failure, emailFailure: $emailFailure, passwordFailure: $passwordFailure)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.failure, failure) || other.failure == failure) &&
            (identical(other.emailFailure, emailFailure) ||
                other.emailFailure == emailFailure) &&
            (identical(other.passwordFailure, passwordFailure) ||
                other.passwordFailure == passwordFailure));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading, email, password,
      failure, emailFailure, passwordFailure);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginStateImplCopyWith<_$LoginStateImpl> get copyWith =>
      __$$LoginStateImplCopyWithImpl<_$LoginStateImpl>(this, _$identity);
}

abstract class _LoginState extends LoginState {
  factory _LoginState(
      {required final bool isLoading,
      required final String email,
      required final String password,
      required final Option<Failure> failure,
      required final Option<ValueFailure> emailFailure,
      required final Option<ValueFailure> passwordFailure}) = _$LoginStateImpl;
  _LoginState._() : super._();

  @override
  bool get isLoading;
  @override
  String get email;
  @override
  String get password;
  @override
  Option<Failure> get failure;
  @override
  Option<ValueFailure> get emailFailure;
  @override
  Option<ValueFailure> get passwordFailure;
  @override
  @JsonKey(ignore: true)
  _$$LoginStateImplCopyWith<_$LoginStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
