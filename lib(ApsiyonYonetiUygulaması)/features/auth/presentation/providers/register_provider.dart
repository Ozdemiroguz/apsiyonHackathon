//register state ile register provider

import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/injections/locator.dart';
import '../../../../utils/validators.dart';
import '../states/register/register_state.dart';

final registerProvider =
    NotifierProvider.autoDispose<_RegisterNotifier, RegisterState>(
  _RegisterNotifier.new,
);

class _RegisterNotifier extends AutoDisposeNotifier<RegisterState> {
  @override
  RegisterState build() {
    Future(() => init());
    return RegisterState.initial();
  }

  Future<void> init() async {
    state = state.copyWith(
      pinputFailure: validatePinput(state.pinput),
      phoneNumberFailure: validatePhone(state.phoneNumber),
      emailFailure: validateEmailAddress(state.email),
      passwordFailure: validatePassword(state.password),
      confirmPasswordFailure:
          validateConfirmPassword(state.confirmPassword, state.confirmPassword),
    );
  }

  Future<void> register() async {
    state = state.copyWith(isLoading: true);
    final result = await ref.read(authRepositoryProvider).signInWithSmsCode(
        verificationId: state.verificationId!, smsCode: state.pinput);

    result.fold(
      (l) => state = state.copyWith(failure: some(l)),
      (r) => state = state.copyWith(
        failure: none(),
        phoneAuthCredential: r,
      ),
    );

    state = state.copyWith(isLoading: false);
  }

  Future<void> verifyPhoneNumber() async {
    //telefon numarsımın boşluklarını siliyoruz
    final phoneNumber = state.phoneNumber.replaceAll(" ", "");
    state = state.copyWith(isLoading: true);
    final result = await ref.read(authRepositoryProvider).verifyPhoneNumber(
          phoneNumber: state.countryCode + phoneNumber,
        );

    result.fold(
      (l) => state = state.copyWith(failure: some(l)),
      (r) => state = state.copyWith(
        verificationId: r["verificationId"],
        resendToken: r["resendToken"],
      ),
    );

    state = state.copyWith(isLoading: false);
  }

  Future<void> addInformation() async {
    state = state.copyWith(isLoading: true);
    final result = await ref.read(authRepositoryProvider).addInformation(
          state.firstName,
          state.lastName,
          state.email,
          state.password,
          state.phoneAuthCredential!,
        );

    result.fold(
      (l) => state = state.copyWith(failure: some(l)),
      (r) => state = state.copyWith(failure: none()),
    );

    state = state.copyWith(isLoading: false);
  }

  void onChangedCountryCode(String? countryCode) {
    state = state.copyWith(countryCode: countryCode ?? "+90");
  }

  void onChangedPhoneNumber(String? phoneNumber) {
    state = state.copyWith(
        phoneNumber: phoneNumber ?? "",
        phoneNumberFailure: validatePhone(phoneNumber ?? ""));
  }

  void onChangedCheckList(int index) {
    bool isAllAgreed = true;
    final newAgreementList = List<bool>.generate(state.agrrement.length, (i) {
      final value = i == index ? !state.agrrement[i] : state.agrrement[i];
      if (!value) isAllAgreed = false;
      return value;
    });

    state = state.copyWith(
      agrrement: newAgreementList,
      isAgreement: isAllAgreed,
    );
  }

  void onChangedPinput(String pinput) {
    state =
        state.copyWith(pinput: pinput, pinputFailure: validatePinput(pinput));
  }

  void onChangedFirstName(String firstName) {
    state = state.copyWith(firstName: firstName);
  }

  void onChangedLastName(String lastName) {
    state = state.copyWith(lastName: lastName);
  }

  void onChangedEmail(String email) {
    state =
        state.copyWith(email: email, emailFailure: validateEmailAddress(email));
  }

  void onChangedPassword(String password) {
    state = state.copyWith(
      password: password,
      passwordFailure: validatePassword(password),
    );
  }

  void onChangedConfirmPassword(String confirmPassword) {
    state = state.copyWith(
      confirmPassword: confirmPassword,
    );

    state = state.copyWith(
      confirmPasswordFailure: validateConfirmPassword(
        state.password,
        state.confirmPassword,
      ),
    );
  }
}
