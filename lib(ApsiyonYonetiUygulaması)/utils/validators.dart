import 'package:easy_localization/easy_localization.dart';
import 'package:email_validator/email_validator.dart';
import 'package:fpdart/fpdart.dart';

import '../constants/regexps.dart';
import '../constants/value_failure_messages.dart';
import '../core/models/value_failure/value_failure.dart';

//TODO: MİN PASSWORD MUST HAVE 8 OF LENGTH
const minPasswordLength = 8;

Option<ValueFailure> validateEmailAddress(
  String input, {
  bool isRequired = true,
  String? customMessage,
}) {
  if (input.isEmpty && isRequired) {
    return some(
      ValueFailure.invalidInput(
        customMessage ?? emptyEmailFailureMessage,
      ),
    );
  }

  if (isRequired
      ? EmailValidator.validate(input)
      : (input.isEmpty || EmailValidator.validate(input))) {
    return none();
  } else {
    return some(ValueFailure.invalidInput(invalidEmailFailureMessage));
  }
}

Option<ValueFailure> validateEmptiness(String input, {String? customMessage}) {
  if (input.isEmpty) {
    return some(
      ValueFailure.invalidInput(customMessage ?? emptyInputFailureMessage),
    );
  }

  return none();
}

Option<ValueFailure> validateEmptinessMaxCharacter(
  String input, {
  String? customMessage,
  int maxCharacter = 100,
  String? maxMessage,
}) {
  if (input.isEmpty) {
    return some(
      ValueFailure.invalidInput(customMessage ?? emptyInputFailureMessage),
    );
  }

  if (input.length > maxCharacter) {
    return some(
      ValueFailure.invalidInput(maxMessage ?? emptyInputFailureMessage),
    );
  }

  return none();
}

Option<ValueFailure> validatePhone(String input, {String? customMessage}) {
  if (input.isEmpty) {
    return some(
      ValueFailure.invalidInput(customMessage ?? emptyInputFailureMessage),
    );
  }

  if (input.length == 13) {
    return none();
  } else {
    return some(ValueFailure.invalidInput(emptyPhoneFailureMessage));
  }
}

Option<ValueFailure> validateDescriptionStatus(String input) {
  if (input.isEmpty) {
    return some(
      ValueFailure.invalidInput(emptyDescriptionStatusFailureMessage),
    );
  }

  return none();
}

Option<ValueFailure> validateDescription(String input) {
  if (input.isEmpty) {
    return some(ValueFailure.invalidInput(emptyDescriptionFailureMessage));
  }

  return none();
}

Option<ValueFailure> validatePassword(String? input, {bool isLogin = false}) {
  if (input == '' || input == null) {
    return some(ValueFailure.invalidInput(emptyPasswordFailureMessage));
  }

  if (input.length < minPasswordLength) {
    return some(ValueFailure.invalidInput(shortPasswordFailureMessage));
  }

  if (!passwordRegExp.hasMatch(input) && !isLogin) {
    return some(ValueFailure.invalidInput(invalidPasswordFailureMessage));
  }

  return none();
}

Option<ValueFailure> validateNewPassword(
  String? input,
  String passwordConfirmation, [
  int minPasswordLength = 6,
]) {
  if (input == '' || input == null) {
    return some(ValueFailure.invalidInput(emptyPasswordFailureMessage));
  }

  if (input.length < minPasswordLength) {
    return some(ValueFailure.invalidInput(shortPasswordFailureMessage));
  }

  if (!lowercaseRegExp.hasMatch(input)) {
    return some(ValueFailure.invalidInput(passwordLowerCaseFailureMessage));
  }
  if (!uppercaseRegExp.hasMatch(input)) {
    return some(ValueFailure.invalidInput(passwordUpperCaseFailureMessage));
  }
  if (!specialCharacterRegExp.hasMatch(input)) {
    return some(
      ValueFailure.invalidInput(passwordSpecialCharacterFailureMessage),
    );
  }

  // if (input.length >= minPasswordLength && passwordConfirmation.length >= minPasswordLength) {
  //   if (input != passwordConfirmation) return some(ValueFailure.invalidInput(passwordNotMatchFailureMessage));
  // }
  return none();
}

Option<ValueFailure> validateNewPasswordEmptyMessage(
  String? input,
  String passwordConfirmation,
  String emptyMessage, [
  int minPasswordLength = 6,
]) {
  if (input == '' || input == null) {
    return some(ValueFailure.invalidInput(emptyMessage));
  }

  if (input.length < minPasswordLength) {
    return some(ValueFailure.invalidInput(shortPasswordFailureMessage));
  }

  if (!lowercaseRegExp.hasMatch(input)) {
    return some(ValueFailure.invalidInput(passwordLowerCaseFailureMessage));
  }
  if (!uppercaseRegExp.hasMatch(input)) {
    return some(ValueFailure.invalidInput(passwordUpperCaseFailureMessage));
  }
  if (!specialCharacterRegExp.hasMatch(input)) {
    return some(
      ValueFailure.invalidInput(passwordSpecialCharacterFailureMessage),
    );
  }

  // if (input.length >= minPasswordLength && passwordConfirmation.length >= minPasswordLength) {
  //   if (input != passwordConfirmation) return some(ValueFailure.invalidInput(passwordNotMatchFailureMessage));
  // }
  return none();
}

Option<ValueFailure> validateConfirmPassword(
  String? input,
  String password,
) {
  if (password == '') {
    return some(ValueFailure.invalidInput(emptyPasswordFailureMessage));
  }
  if (input != password) {
    return some(
      ValueFailure.invalidInput(passwordNotMatchFailureMessage),
    );
  }

  return none();
}

String? validateDropDownValue(dynamic value) {
  if (value == null) {
    return 'emptyInputFailureMessage'.tr();
  }
  return null;
}

Option<ValueFailure> validateTcNo(String? input) {
  if (input == 'admin') {
    return none();
  } else if (input == '' || input == null) {
    return some(ValueFailure.invalidInput(emptyTcFailureMessage));
  } else if (input.length < 11) {
    return some(ValueFailure.invalidInput(shortTcFailureMessage));
  } else if (nonDigitsRegExp.hasMatch(input)) {
    return some(ValueFailure.invalidInput(invalidTcFailureMessage));
  }
  return none();
}

Option<ValueFailure> validateAmount(double input, double maxValue) {
  if (input == 0) {
    return some(ValueFailure.invalidInput(zeroAmountFailureMessage));
  } else if (input > maxValue) {
    return some(ValueFailure.invalidInput(invalidAmountFailureMessage));
  }
  return none();
}

Option<ValueFailure> validatePinput(String input) {
  if (input.isEmpty) {
    return some(ValueFailure.invalidInput(emptyPinputFailureMessage));
  }

  if (input.length != 6) {
    return some(ValueFailure.invalidInput(invalidPinputFailureMessage));
  }

  return none();
}
