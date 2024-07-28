import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/models/failure/failure.dart';
import '../../../../../core/models/validation_error_visibility/validation_error_visibility.dart';
import '../../../../../core/models/value_failure/value_failure.dart';

part 'register_state.freezed.dart';

@freezed
class RegisterState with _$RegisterState {
  factory RegisterState({
    required bool isLoading,
    required String phoneNumber,
    required String countryCode,
    required String pinput,
    required String email,
    required String firstName,
    required String lastName,
    required String password,
    required String confirmPassword,
    required List<bool> agrrement,
    required bool isAgreement,
    required String? verificationId,
    required String? resendToken,
    required PhoneAuthCredential? phoneAuthCredential,
    required Option<Failure> failure,
    required Option<ValueFailure> phoneNumberFailure,
    required Option<ValueFailure> pinputFailure,
    required Option<ValueFailure> emailFailure,
    required Option<ValueFailure> passwordFailure,
    required Option<ValueFailure> confirmPasswordFailure,
    required ValidationErrorVisibility validationErrorVisibility,
  }) = _RegisterState;

  factory RegisterState.initial() => RegisterState(
        isLoading: false,
        phoneNumber: "",
        countryCode: "+90",
        pinput: "",
        password: "",
        confirmPassword: "",
        email: "",
        firstName: "",
        lastName: "",
        agrrement: [false, false],
        isAgreement: false,
        verificationId: null,
        resendToken: null,
        phoneAuthCredential: null,
        failure: none(),
        phoneNumberFailure: none(),
        emailFailure: none(),
        pinputFailure: none(),
        passwordFailure: none(),
        confirmPasswordFailure: none(),
        validationErrorVisibility: const ValidationErrorVisibility.hide(),
      );

  const RegisterState._();

  //bool get isFormValid => phoneNumber.isNone() && passwordFailure.isNone();
}
