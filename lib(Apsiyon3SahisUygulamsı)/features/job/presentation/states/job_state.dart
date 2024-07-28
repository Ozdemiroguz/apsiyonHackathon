import 'package:apsiyon3/features/job/domain/models/employment.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/models/failure/failure.dart';

part 'job_state.freezed.dart';

@freezed
class JobState with _$JobState {
  factory JobState({
    required bool isLoading,
    required List<Employment> confirmedList,
    required List<Employment> employmentList,
    required List<Employment> personalEmploymentList,
    required List<Employment> filteredEmploymentList,
    required List<Employment> completedEmploymentList,
    required String filteredSearch,
    required String price,
    required Option<Failure> failure,
  }) = _JobState;

  factory JobState.initial() => JobState(
        isLoading: false,
        confirmedList: [],
        employmentList: [],
        personalEmploymentList: [],
        filteredEmploymentList: [],
        completedEmploymentList: [],
        filteredSearch: "",
        price: "",
        failure: none(),
      );

  const JobState._();
}
