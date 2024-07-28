import 'package:apsiyon3/features/kurye/presentation/providers/kuryepage_provider.dart';
import 'package:apsiyon3/services/kurye_service/kurye_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/injections/locator.dart';
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
          tokenOtherId: FirebaseAuth.instance.currentUser!.uid,
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

  Future<void> requestToken({required Token token}) async {
    state = state.copyWith(isLoading: true);

    final result = await ref.read(otherRepositoryProvider).setToken(
          tokenDescription: token.tokenDescription,
          tokenTime: getTimestamp(token.createdAt, token.expirationDate),
          tokenOtherId: ref.read(kuryeProvider).uid,
          userId: token.userId,
          apsiyonPointId: token.apsiyonPointId,
          tokenOtherName:
              "${ref.read(kuryeProvider).name} ${ref.read(kuryeProvider).surname}",
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

Duration getTimestamp(Timestamp createdAt, Timestamp expirationDate) {
  return expirationDate.toDate().difference(createdAt.toDate());
}
