import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/injections/locator.dart';
import '../../../../services/user_service/user_service_provider.dart';
import '../../domain/models/token.dart';
import '../states/other_state.dart';

final otherProvider = NotifierProvider.autoDispose<_OtherNotifier, OtherState>(
  _OtherNotifier.new,
);

class _OtherNotifier extends AutoDisposeNotifier<OtherState> {
  @override
  OtherState build() {
    Future(() => getOtherData());
    return OtherState.initial();
  }

  Future<void> getOtherData() async {
    state = state.copyWith(isLoading: true);

    ref
        .read(otherRepositoryProvider)
        .getToken(
          userId: ref.read(userService).userData.uid[0] +
              ref.read(userService).userData.uid[1],
        )
        .listen((event) {
      event.fold(
        (l) => state = state.copyWith(
          failure: some(l),
        ),
        (r) {
          final List<Token> confirmedList = [];
          final List<Token> unconfirmedList = [];

          for (final element in r) {
            if (element.status == "confirmed") {
              confirmedList.add(element);
            } else {
              unconfirmedList.add(element);
            }
          }

          state = state.copyWith(
            tokenListConfirmed: confirmedList,
            tokenListUnconfirmed: unconfirmedList,
            isLoading: false,
          );

          updateTokenList();
        },
      );
    });
  }

  Future<void> setToken() async {
    state = state.copyWith(isLoading: true);

    final result = await ref.read(otherRepositoryProvider).setToken(
          tokenDescription: state.tokenDescription,
          tokenTime: getTimestamp(state.tokenTime),
          tokenOtherId: state.tokenOtherId == null ? "" : state.tokenOtherId!,
          userId: ref.read(userService).userData.uid[0] +
              ref.read(userService).userData.uid[1],
          apsiyonPointId: ref.read(userService).userData.apsiyon_id,
          tokenOtherName: "",
        );

    state = state.copyWith(failure: result, isLoading: false);
  }

  void updateTokenList() {
    final List<Token> pastTokenList = [];
    final List<Token> confirmedList = [];
    final List<Token> unconfirmedList = [];

    for (final element in state.tokenListConfirmed) {
      if (element.expirationDate.millisecondsSinceEpoch <
          Timestamp.now().millisecondsSinceEpoch) {
        pastTokenList.add(element);
      } else {
        confirmedList.add(element);
      }
    }
    //unconfirmedListi güncelle

    for (final element in state.tokenListUnconfirmed) {
      if (element.expirationDate.millisecondsSinceEpoch <
          Timestamp.now().millisecondsSinceEpoch) {
        pastTokenList.add(element);
      } else {
        unconfirmedList.add(element);
      }
    }

    // state'in yeni durumunu belirle
    state = state.copyWith(
      tokenListConfirmed: confirmedList,
      tokenListUnconfirmed: unconfirmedList,
      tokenListExpired: [...pastTokenList, ...state.tokenListExpired],
    );
  }

  Future<void> setStatus(String status, String tokenID) async {
    state = state.copyWith(isLoading: true);

    final result = await ref.read(otherRepositoryProvider).setStatus(
          status: status,
          tokenID: tokenID,
        );

    state = state.copyWith(failure: result, isLoading: false);
  }

  void onChangedTokenDescription(String? tokenDescription) {
    state = state.copyWith(
      tokenDescription: tokenDescription!,
    );
  }

  void setTokenTime(String tokenTime) {
    state = state.copyWith(
      tokenTime: tokenTime,
    );
  }

  void setTokenOtherId(String tokenOtherId) {
    state = state.copyWith(
      tokenOtherId: tokenOtherId,
    );
  }
}

Duration getTimestamp(String tokenTime) {
  if (tokenTime == "15 Dk") {
    //15 dakika
    return const Duration(minutes: 15);
  }
  if (tokenTime == "30 Dk") {
    //30 dakika
    return const Duration(minutes: 30);
  }
  if (tokenTime == "1 Saat") {
    //1 saat
    return const Duration(hours: 1);
  }
  if (tokenTime == "8 Saat") {
    //2 saat
    return const Duration(hours: 2);
  } else {
    return const Duration(minutes: 30);
  }
}
