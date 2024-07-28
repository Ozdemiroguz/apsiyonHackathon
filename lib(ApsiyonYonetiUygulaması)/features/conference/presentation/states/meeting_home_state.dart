import 'package:apsiyonY/core/models/failure/failure.dart';
import 'package:apsiyonY/features/conference/domain/models/meeting.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'meeting_home_state.freezed.dart';

@freezed
class MeetingHomeState with _$MeetingHomeState {
  factory MeetingHomeState({
    required bool isLoading,
    required List<Meeting> meetingList,
    required List<Meeting> meetingListPast,
    required List<Meeting> meetingListUpcoming,
    required List<Meeting>? activeMeeting,
    required String? selectedMeetingType,
    required String title,
    required String description,
    required DateTime? date,
    required TimeOfDay? timeOfDay,
    required String location,
    required String selectedLocation,
    required Option<Failure> failure,
  }) = _MeetingHomeState;

  factory MeetingHomeState.initial() => MeetingHomeState(
        isLoading: false,
        meetingList: [],
        meetingListPast: [],
        meetingListUpcoming: [],
        activeMeeting: [],
        selectedMeetingType: null,
        title: "",
        description: "",
        date: null,
        timeOfDay: null,
        location: "",
        selectedLocation: "",
        failure: none(),
      );

  const MeetingHomeState._();
}
