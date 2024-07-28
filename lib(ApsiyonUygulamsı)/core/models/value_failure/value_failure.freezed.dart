// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'value_failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ValueFailure {
  String get message => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) invalidInput,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? invalidInput,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? invalidInput,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InvalidInput value) invalidInput,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InvalidInput value)? invalidInput,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InvalidInput value)? invalidInput,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ValueFailureCopyWith<ValueFailure> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ValueFailureCopyWith<$Res> {
  factory $ValueFailureCopyWith(
          ValueFailure value, $Res Function(ValueFailure) then) =
      _$ValueFailureCopyWithImpl<$Res, ValueFailure>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$ValueFailureCopyWithImpl<$Res, $Val extends ValueFailure>
    implements $ValueFailureCopyWith<$Res> {
  _$ValueFailureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_value.copyWith(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InvalidInputImplCopyWith<$Res>
    implements $ValueFailureCopyWith<$Res> {
  factory _$$InvalidInputImplCopyWith(
          _$InvalidInputImpl value, $Res Function(_$InvalidInputImpl) then) =
      __$$InvalidInputImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$InvalidInputImplCopyWithImpl<$Res>
    extends _$ValueFailureCopyWithImpl<$Res, _$InvalidInputImpl>
    implements _$$InvalidInputImplCopyWith<$Res> {
  __$$InvalidInputImplCopyWithImpl(
      _$InvalidInputImpl _value, $Res Function(_$InvalidInputImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$InvalidInputImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$InvalidInputImpl implements _InvalidInput {
  const _$InvalidInputImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'ValueFailure.invalidInput(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvalidInputImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InvalidInputImplCopyWith<_$InvalidInputImpl> get copyWith =>
      __$$InvalidInputImplCopyWithImpl<_$InvalidInputImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) invalidInput,
  }) {
    return invalidInput(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? invalidInput,
  }) {
    return invalidInput?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? invalidInput,
    required TResult orElse(),
  }) {
    if (invalidInput != null) {
      return invalidInput(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InvalidInput value) invalidInput,
  }) {
    return invalidInput(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InvalidInput value)? invalidInput,
  }) {
    return invalidInput?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InvalidInput value)? invalidInput,
    required TResult orElse(),
  }) {
    if (invalidInput != null) {
      return invalidInput(this);
    }
    return orElse();
  }
}

abstract class _InvalidInput implements ValueFailure {
  const factory _InvalidInput(final String message) = _$InvalidInputImpl;

  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$InvalidInputImplCopyWith<_$InvalidInputImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
