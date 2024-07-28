import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_data.freezed.dart';
part 'user_data.g.dart';

@freezed
class UserData with _$UserData {
  factory UserData({
    required String email,
    required String name,
    required String surname,
    required List<String> uid,
    required String phoneNumber,
    required String apartment_number,
    required String apartment_status,
    required String apsiyon_id,
  }) = _UserData;

  factory UserData.initial() => UserData(
        email: "",
        name: "",
        surname: "",
        uid: [],
        phoneNumber: "",
        apartment_number: "",
        apartment_status: "",
        apsiyon_id: "",
      );

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);
}
