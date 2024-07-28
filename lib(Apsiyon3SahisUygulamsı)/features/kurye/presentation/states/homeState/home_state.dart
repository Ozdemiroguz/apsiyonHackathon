import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  factory HomeState({
    required bool isLoading,
    required String test,
    required List<bool> testList,
    required int testInt,
  }) = _HomeState;

  factory HomeState.initial() => HomeState(
        isLoading: false,
        test: "",
        testList: [],
        testInt: 0,
      );

  const HomeState._();
}
