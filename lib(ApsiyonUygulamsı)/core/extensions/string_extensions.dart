import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

extension StringExtensions on String {
  String get cutLastThreeElements => substring(0, length - 3);

  String get phoneFormat => MaskTextInputFormatter(
        mask: '0 ### ### ## ##',
        filter: {"#": RegExp('[0-9]')},
        initialText: this,
      ).getMaskedText();

  String convertCurrency([bool addSymbol = true]) {
    return NumberFormat.currency(
      locale: "tr_TR",
      symbol: addSymbol ? "₺" : "",
    ).format(double.tryParse(this));
  }

  //Accepts whitespace
  bool isAlphaNumeric() => RegExp(r'^(?=.*\d)(?=.*[A-Z])(?=.*[a-z])[A-Za-z0-9\s]{5,15}$').hasMatch(this);

  DateTime get parseTime => DateTime(
        0,
        0,
        0,
        int.parse(split(':')[0]),
        int.parse(split(':')[1]),
      );

  String get formatDate {
    final a = replaceAll('-', '.').split('T').first;

    return a.split('.').reversed.join('.');
  }

  String get newLineDateTime => (split(' ')..swap(0, 1)).join('\n');

  String get spaceDateTime => (split(' ')..swap(0, 1)).join(' ');

  String get jpegToJpg => replaceAll('.jpeg', '.jpg');

  ///Compares two version strings. Returns false if equals.
  ///Ex: "v0.0.5".isOlder("v0.0.6") => false
  bool isOlder(String comparedVersion) {
    final version = replaceAll('v', '').split('.');
    final comparedVersionList = comparedVersion.replaceAll('v', '').split('.');

    for (var i = 0; i < version.length; i++) {
      if (int.parse(version[i]) < int.parse(comparedVersionList[i])) {
        return true;
      } else if (int.parse(version[i]) > int.parse(comparedVersionList[i])) {
        return false;
      }
    }

    return false;
  }
}
