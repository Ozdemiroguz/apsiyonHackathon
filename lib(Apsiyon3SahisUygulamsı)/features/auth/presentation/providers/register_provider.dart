//register state ile register provider

import 'package:hooks_riverpod/hooks_riverpod.dart';

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
      phoneNumberFailure: validatePhone(state.phoneNumber),
      emailFailure: validateEmailAddress(state.email),
      passwordFailure: validatePassword(state.password),
      confirmPasswordFailure:
          validateConfirmPassword(state.confirmPassword, state.confirmPassword),
    );
  }

  Future<void> register() async {
    state = state.copyWith(isLoading: true);
    final result = await ref.read(authRepositoryProvider).register(
          state.firstName,
          state.lastName,
          state.email,
          state.password,
          state.phoneNumber,
        );

    state = state.copyWith(failure: result, isLoading: false);
  }

  Future<void> setJob(String job) async {
    state = state.copyWith(isLoading: true);
    final result = await ref.read(authRepositoryProvider).setJob(job);

    state = state.copyWith(failure: result, isLoading: false);
  }

  Future<void> setDesc() async {
    state = state.copyWith(isLoading: true);
    final result = await ref.read(authRepositoryProvider).setDesc(
          state.description,
          state.socialMedia,
          state.imagePath,
        );

    state = state.copyWith(failure: result, isLoading: false);
  }

  void onChangedCountryCode(String? countryCode) {
    state = state.copyWith(countryCode: countryCode ?? "+90");
  }

  void onChangedPhoneNumber(String? phoneNumber) {
    state = state.copyWith(
      phoneNumber: phoneNumber ?? "",
      phoneNumberFailure: validatePhone(phoneNumber ?? ""),
    );
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

  void onChangedDescription(String description) {
    state = state.copyWith(description: description);
  }

  void onChangedSocialMedia(String socialMedia) {
    state = state.copyWith(socialMedia: socialMedia);
  }

  void onChangedImagePath(String imagePath) {
    state = state.copyWith(imagePath: imagePath);
  }
}
