// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserData _$UserDataFromJson(Map<String, dynamic> json) {
  return _UserData.fromJson(json);
}

/// @nodoc
mixin _$UserData {
  String get email => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get surname => throw _privateConstructorUsedError;
  List<String> get uid => throw _privateConstructorUsedError;
  String get phoneNumber => throw _privateConstructorUsedError;
  String get apartment_number => throw _privateConstructorUsedError;
  String get apartment_status => throw _privateConstructorUsedError;
  String get apsiyon_id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserDataCopyWith<UserData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserDataCopyWith<$Res> {
  factory $UserDataCopyWith(UserData value, $Res Function(UserData) then) =
      _$UserDataCopyWithImpl<$Res, UserData>;
  @useResult
  $Res call(
      {String email,
      String name,
      String surname,
      List<String> uid,
      String phoneNumber,
      String apartment_number,
      String apartment_status,
      String apsiyon_id});
}

/// @nodoc
class _$UserDataCopyWithImpl<$Res, $Val extends UserData>
    implements $UserDataCopyWith<$Res> {
  _$UserDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? name = null,
    Object? surname = null,
    Object? uid = null,
    Object? phoneNumber = null,
    Object? apartment_number = null,
    Object? apartment_status = null,
    Object? apsiyon_id = null,
  }) {
    return _then(_value.copyWith(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      surname: null == surname
          ? _value.surname
          : surname // ignore: cast_nullable_to_non_nullable
              as String,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as List<String>,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      apartment_number: null == apartment_number
          ? _value.apartment_number
          : apartment_number // ignore: cast_nullable_to_non_nullable
              as String,
      apartment_status: null == apartment_status
          ? _value.apartment_status
          : apartment_status // ignore: cast_nullable_to_non_nullable
              as String,
      apsiyon_id: null == apsiyon_id
          ? _value.apsiyon_id
          : apsiyon_id // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserDataImplCopyWith<$Res>
    implements $UserDataCopyWith<$Res> {
  factory _$$UserDataImplCopyWith(
          _$UserDataImpl value, $Res Function(_$UserDataImpl) then) =
      __$$UserDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String email,
      String name,
      String surname,
      List<String> uid,
      String phoneNumber,
      String apartment_number,
      String apartment_status,
      String apsiyon_id});
}

/// @nodoc
class __$$UserDataImplCopyWithImpl<$Res>
    extends _$UserDataCopyWithImpl<$Res, _$UserDataImpl>
    implements _$$UserDataImplCopyWith<$Res> {
  __$$UserDataImplCopyWithImpl(
      _$UserDataImpl _value, $Res Function(_$UserDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? name = null,
    Object? surname = null,
    Object? uid = null,
    Object? phoneNumber = null,
    Object? apartment_number = null,
    Object? apartment_status = null,
    Object? apsiyon_id = null,
  }) {
    return _then(_$UserDataImpl(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      surname: null == surname
          ? _value.surname
          : surname // ignore: cast_nullable_to_non_nullable
              as String,
      uid: null == uid
          ? _value._uid
          : uid // ignore: cast_nullable_to_non_nullable
              as List<String>,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      apartment_number: null == apartment_number
          ? _value.apartment_number
          : apartment_number // ignore: cast_nullable_to_non_nullable
              as String,
      apartment_status: null == apartment_status
          ? _value.apartment_status
          : apartment_status // ignore: cast_nullable_to_non_nullable
              as String,
      apsiyon_id: null == apsiyon_id
          ? _value.apsiyon_id
          : apsiyon_id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserDataImpl implements _UserData {
  _$UserDataImpl(
      {required this.email,
      required this.name,
      required this.surname,
      required final List<String> uid,
      required this.phoneNumber,
      required this.apartment_number,
      required this.apartment_status,
      required this.apsiyon_id})
      : _uid = uid;

  factory _$UserDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserDataImplFromJson(json);

  @override
  final String email;
  @override
  final String name;
  @override
  final String surname;
  final List<String> _uid;
  @override
  List<String> get uid {
    if (_uid is EqualUnmodifiableListView) return _uid;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_uid);
  }

  @override
  final String phoneNumber;
  @override
  final String apartment_number;
  @override
  final String apartment_status;
  @override
  final String apsiyon_id;

  @override
  String toString() {
    return 'UserData(email: $email, name: $name, surname: $surname, uid: $uid, phoneNumber: $phoneNumber, apartment_number: $apartment_number, apartment_status: $apartment_status, apsiyon_id: $apsiyon_id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserDataImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.surname, surname) || other.surname == surname) &&
            const DeepCollectionEquality().equals(other._uid, _uid) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.apartment_number, apartment_number) ||
                other.apartment_number == apartment_number) &&
            (identical(other.apartment_status, apartment_status) ||
                other.apartment_status == apartment_status) &&
            (identical(other.apsiyon_id, apsiyon_id) ||
                other.apsiyon_id == apsiyon_id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      email,
      name,
      surname,
      const DeepCollectionEquality().hash(_uid),
      phoneNumber,
      apartment_number,
      apartment_status,
      apsiyon_id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserDataImplCopyWith<_$UserDataImpl> get copyWith =>
      __$$UserDataImplCopyWithImpl<_$UserDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserDataImplToJson(
      this,
    );
  }
}

abstract class _UserData implements UserData {
  factory _UserData(
      {required final String email,
      required final String name,
      required final String surname,
      required final List<String> uid,
      required final String phoneNumber,
      required final String apartment_number,
      required final String apartment_status,
      required final String apsiyon_id}) = _$UserDataImpl;

  factory _UserData.fromJson(Map<String, dynamic> json) =
      _$UserDataImpl.fromJson;

  @override
  String get email;
  @override
  String get name;
  @override
  String get surname;
  @override
  List<String> get uid;
  @override
  String get phoneNumber;
  @override
  String get apartment_number;
  @override
  String get apartment_status;
  @override
  String get apsiyon_id;
  @override
  @JsonKey(ignore: true)
  _$$UserDataImplCopyWith<_$UserDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
