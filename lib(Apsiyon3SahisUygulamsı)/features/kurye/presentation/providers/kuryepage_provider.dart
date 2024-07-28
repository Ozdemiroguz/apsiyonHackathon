//Kurye state ile Kurye provider

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../states/status_state/kurye_state.dart';

final kuryePageProvider =
    NotifierProvider.autoDispose<_KuryeNotifier, KuryeState>(
  _KuryeNotifier.new,
);

class _KuryeNotifier extends AutoDisposeNotifier<KuryeState> {
  @override
  KuryeState build() {
    Future(() => getKuryeData());
    return KuryeState.initial();
  }

  Future<void> getKuryeData() async {}

  void onChangedToken(String? token) {
    state = state.copyWith(
      token: token!,
    );
  }
}
