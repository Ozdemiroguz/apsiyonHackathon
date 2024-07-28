//Home state ile Home provider

import 'package:apsiyon3/core/injections/locator.dart';
import 'package:apsiyon3/features/job/domain/models/employment.dart';
import 'package:apsiyon3/features/job/presentation/states/job_state.dart';
import 'package:apsiyon3/services/kurye_service/kurye_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final jobProvider = NotifierProvider.autoDispose<_HomeNotifier, JobState>(
  _HomeNotifier.new,
);

class _HomeNotifier extends AutoDisposeNotifier<JobState> {
  @override
  JobState build() {
    Future(() => getHomeData());
    return JobState.initial();
  }

  Future<void> getHomeData() async {
    print("Get Home Data");
    state = state.copyWith(isLoading: true);
    final String userId = FirebaseAuth.instance.currentUser!.uid;
    final String job = await ref.read(jobRepositoryProvider).getJob(
          userId: userId,
        );

    ref.read(jobRepositoryProvider).getEmployment(job: job).listen((event) {
      event.fold(
        (l) => state = state.copyWith(
          failure: some(l),
        ),
        (r) {
          final List<Employment> employmentList = [];
          final List<Employment> personalEmploymentList = [];
          final List<Employment> personalActiveEmploymentList = [];
          final List<Employment> completedList = [];

          for (final employment in r) {
            if (employment.otherId == null) {
              employmentList.add(employment);
            }

            if (employment.otherId != null && employment.otherId == userId) {
              if (employment.status == "offerreceived") {
                personalEmploymentList.add(employment);
              } else if (employment.status == "confirmed") {
                personalActiveEmploymentList.add(employment);
              } else if (employment.status == "completed") {
                completedList.add(employment);
              }
            }
          }

          print("Employment List: $employmentList");
          print("Personal Employment List: $personalEmploymentList");
          print(
              "Personal Active Employment List: $personalActiveEmploymentList");

          state = state.copyWith(
            isLoading: false,
            employmentList: employmentList,
            personalEmploymentList: personalEmploymentList,
            confirmedList: personalActiveEmploymentList,
            completedEmploymentList: completedList,
          );
        },
      );
    });
  }

  Future<void> setOffer({
    required String employmentId,
  }) async {
    final result = await ref.read(jobRepositoryProvider).setOffer(
          employmentId: employmentId,
          otherId: FirebaseAuth.instance.currentUser!.uid,
          otherName: ref.read(kuryeProvider).name,
          price: state.price == '' ? '100' : state.price,
        );

    state = state.copyWith(failure: result);
  }

  void onSearch(String value) {
    state = state.copyWith(filteredSearch: value);
    onFilter();
  }

  void onPrice(String value) {
    state = state.copyWith(price: value);
    print("Price: ${state.price}");
  }

  void onFilter() {
    final filteredEmploymentList = state.employmentList
        .where((element) => element.title
            .toLowerCase()
            .contains(state.filteredSearch.toLowerCase()))
        .toList();

    state = state.copyWith(filteredEmploymentList: filteredEmploymentList);
  }
}
