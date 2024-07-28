// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserDataImpl _$$UserDataImplFromJson(Map<String, dynamic> json) =>
    _$UserDataImpl(
      email: json['email'] as String,
      name: json['name'] as String,
      surname: json['surname'] as String,
      uid: (json['uid'] as List<dynamic>).map((e) => e as String).toList(),
      phoneNumber: json['phoneNumber'] as String,
      apartment_number: json['apartment_number'] as String,
      apartment_status: json['apartment_status'] as String,
      apsiyon_id: json['apsiyon_id'] as String,
    );

Map<String, dynamic> _$$UserDataImplToJson(_$UserDataImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'name': instance.name,
      'surname': instance.surname,
      'uid': instance.uid,
      'phoneNumber': instance.phoneNumber,
      'apartment_number': instance.apartment_number,
      'apartment_status': instance.apartment_status,
      'apsiyon_id': instance.apsiyon_id,
    };
