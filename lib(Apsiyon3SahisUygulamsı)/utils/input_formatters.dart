import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../constants/regexps.dart';
import 'text_input_formatters.dart';

final phoneFormatter = MaskTextInputFormatter(mask: '#### ### ## ##');

//Phone formatter
// MaskTextInputFormatter get phoneFormatter => MaskTextInputFormatter(
//       mask: '0(###) ### ## ##',
//     );

List<TextInputFormatter> eMailInputFormatters() {
  return [
    LengthLimitingTextInputFormatter(200),
    FilteringTextInputFormatter.deny(spaceRegExp),
    FilteringTextInputFormatter.deny(emojiRegexp),
    FilteringTextInputFormatter.deny(turkishCharactersRegexp),
    LengthLimitingTextInputFormatter(50),
  ];
}

List<TextInputFormatter> passwordInputFormatters() {
  return [
    LengthLimitingTextInputFormatter(200),
    FilteringTextInputFormatter.deny(spaceRegExp),
    FilteringTextInputFormatter.deny(emojiRegexp),
  ];
}

List<TextInputFormatter> newPasswordInputFormatters() {
  return [
    LengthLimitingTextInputFormatter(12),
    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\.\,!@#\$&\*~=\-_%\+]')),
  ];
}

List<TextInputFormatter> phoneNumberInputFormatters() {
  return [
    LengthLimitingTextInputFormatter(14),
    PhoneNumberFormatter(),
    // phoneFormatter,
  ];
}

List<TextInputFormatter> fullNameInputFormatters() {
  return [
    FilteringTextInputFormatter.deny(digitsRegexp),
    FilteringTextInputFormatter.deny(emojiRegexp),
    FilteringTextInputFormatter.deny(RegExp('[.;,:<>?/|`~!@#\$%^&*()_+\\-=\\[\\]{}"\']')),
    FilteringTextInputFormatter.deny(RegExp(r"\s "), replacementString: " "),
    FilteringTextInputFormatter.allow(RegExp(r'^\S.*')),
    FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-ZçÇğĞıİöÖşŞüÜ\s]+$')),
  ];
}

List<TextInputFormatter> descriptionInputFormatter([int maxLength = 1000]) {
  return [
    LengthLimitingTextInputFormatter(maxLength),
    FilteringTextInputFormatter.deny(emojiRegexp),
    FilteringTextInputFormatter.allow(RegExp(r'^\S.*')),
    FilteringTextInputFormatter.deny(whitespaceRegExp, replacementString: " "),
  ];
}

List<TextInputFormatter> tcNoInputFormatters() {
  return [
    LengthLimitingTextInputFormatter(11),
    FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9çÇğĞıİöÖşŞüÜ]')),
    // FilteringTextInputFormatter.deny(emojiRegexp),
    // FilteringTextInputFormatter.deny(spaceRegExp),
    // FilteringTextInputFormatter.deny(RegExp(r"\s "), replacementString: " "),
  ];
}

// CurrencyTextInputFormatter getAmountTextInputFormatter({bool useFractionalDigits = true}) => CurrencyTextInputFormatter(
//       name: "",
//       customPattern: "###.###,##",
//       locale: "tr_TR",
//       enableNegative: false,
//       decimalDigits: 2,
//     );
