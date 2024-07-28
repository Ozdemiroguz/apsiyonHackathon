import 'package:apsiyon/features/other/domain/models/employment.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/models/failure/failure.dart';
import '../../domain/models/token.dart';

part 'job_state.freezed.dart';

@freezed
class JobState with _$JobState {
  factory JobState({
    required bool isLoading,
    required bool isCompleted,
    required bool dateCompleted,
    required bool jobCompleted,
    required List<Employment> activeList,
    required List<Employment> offerreceivedList,
    required List<Employment> completedList,
    required List<Employment> confirmedList,
    required String jobTitle,
    required String jobDescription,
    required DateTime? jobDateStart,
    required DateTime? jobDateEnd,
    required String job,
    required String price,
    required Option<Failure> failure,
  }) = _JobState;

  factory JobState.initial() => JobState(
        isLoading: false,
        isCompleted: false,
        dateCompleted: false,
        jobCompleted: false,
        activeList: [],
        offerreceivedList: [],
        completedList: [],
        confirmedList: [],
        jobTitle: '',
        jobDescription: '',
        jobDateStart: null,
        jobDateEnd: null,
        job: '',
        price: '',
        failure: none(),
      );

  const JobState._();
}
