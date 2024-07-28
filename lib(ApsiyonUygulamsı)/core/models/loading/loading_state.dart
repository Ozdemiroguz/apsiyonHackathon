import 'package:freezed_annotation/freezed_annotation.dart';

part 'loading_state.freezed.dart';

@freezed
class LoadingState with _$LoadingState {
  const factory LoadingState.show() = _Show;
  const factory LoadingState.hide() = _Hide;

  const LoadingState._();

  bool get value => when(show: () => true, hide: () => false);
}
