import 'package:flutter/material.dart';

import '../../constants/constans.dart';

extension HeightExtensions on BuildContext {
  double get kPageTopPadding =>
      kAppBarHeight + MediaQuery.of(this).viewPadding.top;
}
