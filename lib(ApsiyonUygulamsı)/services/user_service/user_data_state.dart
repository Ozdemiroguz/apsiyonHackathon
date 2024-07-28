import 'package:apsiyon/core/models/user_models/user_data.dart';
import 'package:apsiyon/features/home/domain/models/apsiyon_point.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_data_state.freezed.dart';

@freezed
class UserDataState with _$UserDataState {
  factory UserDataState({
    required UserData userData,
    required ApsiyonPoint? apsiyonPoint,
  }) = _UserDataState;

  factory UserDataState.initial() => UserDataState(
        userData: UserData.initial(),
        apsiyonPoint: null,
      );

  const UserDataState._();
}
