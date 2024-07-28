extension IntX on int {
  String get remainingTimeFormat {
    final minutes = (this / 60).floor().toString().padLeft(2, '0');
    final seconds = (this % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  String get formatDuration {
    final total = isNegative ? this + 1440 : this;
    final int hour = total ~/ 60;
    final int minutes = total % 60;
    final hourText = hour == 0 ? '' : '${hour}h ';
    final minutesText = minutes == 0 ? '' : '${minutes}m';
    return hourText + minutesText;
  }
}
