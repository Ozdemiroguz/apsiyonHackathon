//MeetingHome state ile MeetingHome provider

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/injections/locator.dart';
import '../../../../services/user_service/user_service_provider.dart';
import '../../../../utils/validators.dart';
import '../../domain/models/meeting.dart';
import '../states/meeting_home_state.dart';

final meetingHomeProvider =
    NotifierProvider.autoDispose<_MeetingHomeNotifier, MeetingHomeState>(
  _MeetingHomeNotifier.new,
);

class _MeetingHomeNotifier extends AutoDisposeNotifier<MeetingHomeState> {
  @override
  MeetingHomeState build() {
    Future(() => init());
    return MeetingHomeState.initial();
  }

  Future<void> init() async {
    state = state.copyWith(
      isLoading: true,
    );
    ref.read(meetingRepositoryProvider).getMeeting().listen((event) {
      event.fold(
        (l) => state = state.copyWith(
          failure: some(l),
        ),
        (r) {
          final List<Meeting> pastMeetings = [];
          final List<Meeting> upcomingMeetings = [];
          final List<Meeting> activeMeeting = [];

          for (final element in r) {
            if (element.status == "past") {
              pastMeetings.add(element);
            } else if (element.status == "upcoming") {
              upcomingMeetings.add(element);
            } else if (element.status == "active") {
              activeMeeting.add(element);
            }
          }

          state = state.copyWith(
            meetingList: r,
            meetingListPast: pastMeetings,
            meetingListUpcoming: upcomingMeetings,
            activeMeeting: activeMeeting,
            isLoading: false,
          );
        },
      );
    });
  }

  void onChangedSelectedMeeting(String? selectedMeeting) {
    state = state.copyWith(
      selectedMeetingType: selectedMeeting!,
    );
  }

  void onChangedTitle(String? title) {
    state = state.copyWith(
      title: title!,
    );
  }

  void onChangedLocation(String? location) {
    state = state.copyWith(
      location: location!,
    );
  }

  void onChangedDescription(String? description) {
    state = state.copyWith(
      description: description!,
    );
  }

  void onChangedDate(DateTime date) {
    state = state.copyWith(
      date: date,
    );
  }

  void onChangedTimeOfDay(TimeOfDay timeOfDay) {
    state = state.copyWith(
      timeOfDay: timeOfDay,
    );
  }

  Future<void> setMeeting() async {
    state = state.copyWith(isLoading: true);
    final result = await ref.read(meetingRepositoryProvider).setMeeting(
          title: state.title,
          description: state.description,
          date: DateTime(
            state.date!.year,
            state.date!.month,
            state.date!.day,
            state.timeOfDay!.hour,
            state.timeOfDay!.minute,
          ),
          location: state.location == "" ? "Uygulamadan" : state.location,
          type: state.selectedMeetingType! == "Hibrit"
              ? "hybrid"
              : state.selectedMeetingType! == "Yüz Yüze"
                  ? "physical"
                  : state.selectedMeetingType!.toLowerCase(),
          apsiyon_pointId: ref.read(userService).apsiyonPoint!.id,
        );

    state = state.copyWith(isLoading: false, failure: result);
  }
}
