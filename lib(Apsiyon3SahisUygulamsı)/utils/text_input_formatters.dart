import 'package:flutter/services.dart';

//this is the regexp for all characters except 0 - 9
// final RegExp  = RegExp(r"[^0-9]");

// final RegExp specialAndAlphaCharacters = RegExp(r"[^0-9\s\+]");

class PhoneNumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String text = newValue.text;

    if (text.startsWith('+90 ')) {
      final rawText = text.substring(5);
      if (text.length > 14 || rawText.contains(RegExp("[^0-9]"))) {
        text = oldValue.text;
        return TextEditingValue(
          text: text,
          selection: TextSelection.collapsed(offset: text.length),
        );
      } else {
        return TextEditingValue(
          text: text,
          selection: TextSelection.fromPosition(newValue.selection.base),
        );
      }
    } else {
      text = "+255 ";

      return TextEditingValue(
        text: text,
        selection: TextSelection.collapsed(offset: text.length),
      );
    }
  }
}

class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // If the new value is empty, allow clearing the field
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final StringBuffer newText = StringBuffer();
    final cleanValue = newValue.text.replaceAll(RegExp(r'\D'), '');

    // Apply #### ### ## ## format

    if (cleanValue.length > 10) {
      return TextEditingValue(
        text: oldValue.text,
        selection: TextSelection.collapsed(offset: oldValue.text.length),
      );
    }

    for (int i = 0; i < cleanValue.length; i++) {
      //parantezleme yaparak 4, 7 ve 9. karakterlerin arasına boş55luk ekliyoruz

      if (i == 3) {
        newText.write(' ');
      }

      if (i == 3 || i == 6) {
        newText.write(' ${cleanValue[i]}');
      } else {
        newText.write(cleanValue[i]);
      }
    }

    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

final specialAndAlphaCharacters = RegExp(
  r"[a-zA-Z\$\R\Ü\Ö\T\Q\Ç\%\#\@\_\:\!\?\&\|\£\½\§\{\[\]\}\\\>\<\=\'\.\,\*\-\,+\ü\ğ\ö\ç\/\;(\) ]+$",
);

//this is the regexp for all non alpha numeric characters
final RegExp nonAlphaNumericRegExp = RegExp("[^a-zA-Z0-9]");

class AlhpaNumericTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.contains(nonAlphaNumericRegExp)) {
      return TextEditingValue(
        text: oldValue.text,
        selection: TextSelection.collapsed(offset: oldValue.text.length),
      );
    } else {
      return TextEditingValue(
        text: newValue.text,
        selection: TextSelection.collapsed(offset: newValue.text.length),
      );
    }
  }
}

class VerificationCodeFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.length > 6) {
      return TextEditingValue(
        text: oldValue.text,
        selection: TextSelection.collapsed(offset: oldValue.text.length),
      );
    } else {
      return TextEditingValue(
        text: newValue.text,
        selection: TextSelection.collapsed(offset: newValue.text.length),
      );
    }
  }
}
