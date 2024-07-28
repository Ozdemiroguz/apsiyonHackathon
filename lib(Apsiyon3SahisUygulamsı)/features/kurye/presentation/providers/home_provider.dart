//Home state ile Home provider

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../states/homeState/home_state.dart';

final homeProvider = NotifierProvider.autoDispose<_HomeNotifier, HomeState>(
  _HomeNotifier.new,
);

class _HomeNotifier extends AutoDisposeNotifier<HomeState> {
  @override
  HomeState build() {
    Future(() => getHomeData());
    return HomeState.initial();
  }

  Future<void> getHomeData() async {
    state = state.copyWith(isLoading: true);
    await Future.delayed(const Duration(seconds: 2));
    state = state.copyWith(
      isLoading: false,
      test: "Test",
      testList: [true, false, true],
      testInt: 1,
    );
  }
}
