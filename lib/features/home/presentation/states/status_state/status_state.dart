import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/models/failure/failure.dart';
import '../../../domain/models/apsiyon_point.dart';
import '../../../domain/models/demand.dart';

part 'status_state.freezed.dart';

@freezed
class StatusState with _$StatusState {
  factory StatusState({
    required bool isLoading,
    required String dropdowFilter,
    required String? selectedItem,
    required String? selectedApartmentNumber,
    required List<ApsiyonPoint> apsiyonPoints,
    required List<ApsiyonPoint> filteredApsiyonPoints,
    required List<String> apartmentNumbers,
    required Demand? demand,
    required Option<Failure> failure,
    required Option<Failure> demandFailure,
  }) = _StatusState;

  factory StatusState.initial() => StatusState(
        isLoading: false,
        dropdowFilter: "",
        selectedItem: null,
        selectedApartmentNumber: null,
        apartmentNumbers: [],
        filteredApsiyonPoints: [],
        apsiyonPoints: [],
        demand: null,
        failure: none(),
        demandFailure: none(),
      );

  const StatusState._();
}
