import 'package:intl/intl.dart';

extension DateFormatX on String {
  String get ddMMyyyyHHmm =>
      DateFormat('dd.MM.yyyy HH:mm').format(DateTime.parse(this));
  String get hhmm => DateFormat('HH:mm').format(DateTime.parse(this));
  String get ddMMyyyy =>
      DateFormat('dd MMM, yyyy').format(DateTime.parse(this));
  DateTime get hhmmssDate => DateFormat('HH:mm:ss').parse(this);
  DateTime get ddMMyyyyHHmmDate => DateFormat('dd.MM.yyyy HH:mm').parse(this);
  DateTime get ddMMyyyyHHmmssDate =>
      DateFormat('dd.MM.yyyy HH:mm:ss').parse(this);
}
