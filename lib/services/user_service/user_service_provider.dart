import 'package:apsiyon/features/home/domain/models/apsiyon_point.dart';
import 'package:apsiyon/services/user_service/user_data_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/injections/locator.dart';
import '../../core/models/user_models/user_data.dart';

final userService = NotifierProvider.autoDispose<_UserNotifier, UserDataState>(
    _UserNotifier.new);

final class _UserNotifier extends AutoDisposeNotifier<UserDataState> {
  @override
  UserDataState build() {
    Future(() => init());
    return UserDataState.initial();
  }

  Future<void> init() async {
    ref.read(userServiceProvider).getUserInfo().listen((event) async {
      state = state.copyWith(
        userData: event,
      );

      if (event.apsiyon_id != '') {
        final apsiyonPoint = await ref
            .read(userServiceProvider)
            .getApsiyonPoint(event.apsiyon_id);

        state = state.copyWith(
          apsiyonPoint: apsiyonPoint,
        );
      }
    });
  }

  String getUserid() {
    //array içindeki idleri birleştir
    return state.userData.uid.map((e) => e).join();
  }

  Future<void> dispose() async {
    dispose();
  }
}
