import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/models/failure/failure.dart';
import '../../../domain/models/apsiyon_point.dart';
import '../../../domain/models/demand.dart';

part 'kurye_state.freezed.dart';

@freezed
class KuryeState with _$KuryeState {
  factory KuryeState({
    required bool isLoading,
    required String token,
    required String filter,
  }) = _KuryeState;

  factory KuryeState.initial() => KuryeState(
        isLoading: false,
        token: "",
        filter: "",
      );

  const KuryeState._();
}
