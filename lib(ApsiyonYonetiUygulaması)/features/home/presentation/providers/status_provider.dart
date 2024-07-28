//Status state ile Status provider

import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/injections/locator.dart';
import '../../../../services/user_service/user_service_provider.dart';
import '../states/status_state/status_state.dart';

final statusProvider =
    NotifierProvider.autoDispose<_StatusNotifier, StatusState>(
  _StatusNotifier.new,
);

class _StatusNotifier extends AutoDisposeNotifier<StatusState> {
  @override
  StatusState build() {
    Future(() => getStatusData());
    return StatusState.initial();
  }

  Future<void> getStatusData() async {
    state = state.copyWith(isLoading: true);

    final result = await ref.read(homeRepositoryProvider).getApsiyonPoints();
    ref
        .read(homeRepositoryProvider)
        .getDemand(userId: ref.read(userService.notifier).getUserid())
        .listen((event) {
      event.fold(
        (l) => state = state.copyWith(failure: some(l)),
        (r) => state = state.copyWith(
          failure: none(),
          demand: r,
        ),
      );
    });

    result.fold(
      (l) => state = state.copyWith(failure: some(l)),
      (r) => state = state.copyWith(
        failure: none(),
        apsiyonPoints: r,
        selectedItem: null,
      ),
    );
    setApartmentNumbers();

    state = state.copyWith(
      isLoading: false,
    );
  }

  void setApartmentNumbers() {
    final List<String> apartmentNumbers = [];
    //selectedItem indexine göre apartmentNumbers oluşturuluyor
    int index = state.selectedItem == null
        ? 0
        : state.apsiyonPoints.indexWhere(
            (element) => element.apartment_name == state.selectedItem,
          );

    if (state.apsiyonPoints.isNotEmpty) {
      for (var i = 0;
          i < state.apsiyonPoints[index].apartment_numbers.length;
          i++) {
        if (state.apsiyonPoints[0].apartment_numbers[i] == null) {
          apartmentNumbers.add((i + 1).toString());
        }
      }
      print("apartmentNumbers: $apartmentNumbers");
      state = state.copyWith(
          apartmentNumbers: apartmentNumbers, selectedApartmentNumber: null);
    }
  }

  void onChangedSelectedItem(String selectedItem) {
    state = state.copyWith(
      selectedItem: selectedItem,
    );
    setApartmentNumbers();
  }

  void onChangedSelectedApartmentNumber(String selectedApartmentNumber) {
    state = state.copyWith(
      selectedApartmentNumber: selectedApartmentNumber,
    );
  }

  void onChangedDropdownFilter(String dropdownFilter) {
    state = state.copyWith(
      dropdowFilter: dropdownFilter,
    );
  }

  void setInitial() {
    state = state.copyWith(
      selectedItem: null,
      selectedApartmentNumber: null,
    );
    setApartmentNumbers();
  }

  Future<void> setDemands() async {
    state = state.copyWith(isLoading: true);

    final result = await ref.read(homeRepositoryProvider).setDemands(
          userId: ref.read(userService.notifier).getUserid(),
          apartmentNumber: state.selectedApartmentNumber!,
          apsiyonPointId: state.apsiyonPoints
              .firstWhere(
                  (element) => element.apartment_name == state.selectedItem)
              .id,
          apartment_name: state.selectedItem!,
        );

    state = state.copyWith(isLoading: false, demandFailure: result);
  }

  Future<void> deleteDemand() async {
    state = state.copyWith(isLoading: true);

    final result = await ref
        .read(homeRepositoryProvider)
        .deleteDemand(userId: ref.read(userService.notifier).getUserid());

    state = state.copyWith(isLoading: false, demandFailure: result);
    if (result.isNone()) {
      state = state.copyWith(demand: null);
    }
  }
}
