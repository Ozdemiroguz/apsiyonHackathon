// ignore_for_file: non_constant_identifier_names

import 'package:easy_localization/easy_localization.dart';

extension DateTimeX on DateTime {
  String get MMMMy => DateFormat('MMMM y').format(this);
  String get dMMMMyEEEE => DateFormat('d MMMM y, EEEE').format(this);
  String get dmy => DateFormat('dd.MM.y').format(this);
  String get ddMMMyyyy => DateFormat('dd MMM, yyyy').format(this);
  String get eeee => DateFormat('EEEE').format(this);
  String get ddMMyyyy => DateFormat('dd.MM.yyyy').format(this);
  String get hhmmss => DateFormat('HH:mm:ss').format(this);
  String get jmFormat => DateFormat.jm().format(this);
  String get formatDateAndTime => DateFormat('dd.MM.yyyy HH:mm').format(this);
}
