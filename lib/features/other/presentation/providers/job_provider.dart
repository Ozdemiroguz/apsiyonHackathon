//Other state ile Other provider

import 'package:apsiyon/features/other/domain/models/employment.dart';
import 'package:apsiyon/features/other/domain/models/token.dart';
import 'package:apsiyon/features/other/presentation/states/job_state.dart';
import 'package:apsiyon/services/user_service/user_service_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/injections/locator.dart';
import '../states/other_state.dart';

final jobProvider = NotifierProvider.autoDispose<_OtherNotifier, JobState>(
  _OtherNotifier.new,
);

class _OtherNotifier extends AutoDisposeNotifier<JobState> {
  @override
  JobState build() {
    Future(() => getOtherData());
    return JobState.initial();
  }

  Future<void> getOtherData() async {
    state = state.copyWith(isLoading: true);

    ref
        .read(otherRepositoryProvider)
        .getEmployment(
          userId: ref.read(userService).userData.uid[0] +
              ref.read(userService).userData.uid[1],
        )
        .listen((event) {
      event.fold(
        (l) => state = state.copyWith(
          failure: some(l),
        ),
        (r) {
          final List<Employment> activeList = [];
          final List<Employment> offerreceivedList = [];
          final List<Employment> completedList = [];
          final List<Employment> confirmedList = [];

          for (final element in r) {
            if (element.status == "waiting" ||
                element.status == "offerreceived") {
              activeList.add(element);
            } else if (element.status == "completed") {
              completedList.add(element);
            } else if (element.status == "confirmed") {
              confirmedList.add(element);
            }
          }

          state = state.copyWith(
            activeList: activeList,
            offerreceivedList: offerreceivedList,
            completedList: completedList,
            confirmedList: confirmedList,
            isLoading: false,
          );
        },
      );
    });
  }

  Future<void> setEmployment() async {
    state = state.copyWith(isLoading: true);
    final user = ref.read(userService);

    final Employment employment = Employment(
      job: state.job,
      title: state.jobTitle,
      description: state.jobDescription,
      startDate: Timestamp.now(),
      price: state.price,
      employerName: user.userData.name + " " + user.userData.surname,
      employerId: user.userData.uid[0] + user.userData.uid[1],
      employerAddress: user.apsiyonPoint!.address,
      employerPhone: user.userData.phoneNumber,
      id: '',
      status: 'waiting',
    );

    final result = await ref
        .read(otherRepositoryProvider)
        .setEmployment(employment: employment);

    state = state.copyWith(isLoading: false, failure: result);
  }

  Future<void> setEmploymentStatus(
      {required String status, required String employmentID}) async {
    state = state.copyWith(isLoading: true);

    final result = await ref
        .read(otherRepositoryProvider)
        .setEmploymentStatus(status: status, employmentID: employmentID);

    state = state.copyWith(isLoading: false, failure: result);
  }

  Future<void> deleteEmployment(String employmentID) async {
    state = state.copyWith(isLoading: true);

    final result = await ref
        .read(otherRepositoryProvider)
        .deleteEmployment(employmentID: employmentID);

    state = state.copyWith(isLoading: false, failure: result);
  }

  void changedJobTitle(String jobTitle) {
    state = state.copyWith(jobTitle: jobTitle);
  }

  void changedJobDescription(String jobDescription) {
    state = state.copyWith(jobDescription: jobDescription);
  }

  void changedJobDateStart(DateTime jobDateStart) {
    state = state.copyWith(jobDateStart: jobDateStart);
  }

  void changedJobDateEnd(DateTime jobDateEnd) {
    state = state.copyWith(jobDateEnd: jobDateEnd);
  }

  void changedJob(String job) {
    state = state.copyWith(job: job);
  }

  void changedPrice(String price) {
    state = state.copyWith(price: price);
  }

  void changedIsCompleted(bool isCompleted) {
    state = state.copyWith(isCompleted: isCompleted);
  }

  void changedDateCompleted(bool dateCompleted) {
    state = state.copyWith(dateCompleted: dateCompleted);
  }

  void changedJobCompleted(bool jobCompleted) {
    state = state.copyWith(jobCompleted: jobCompleted);
  }
}

Duration getTimestamp(String tokenTime) {
  if (tokenTime == "15 Dk") {
    //15 dakika
    return const Duration(minutes: 15);
  }
  if (tokenTime == "30 Dk") {
    //30 dakika
    return const Duration(minutes: 30);
  }
  if (tokenTime == "1 Saat") {
    //1 saat
    return const Duration(hours: 1);
  }
  if (tokenTime == "8 Saat") {
    //2 saat
    return const Duration(hours: 2);
  } else {
    return const Duration(minutes: 30);
  }
}
