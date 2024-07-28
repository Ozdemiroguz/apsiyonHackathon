import 'package:flutter/painting.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors.dart';

final dropdownShadow = BoxShadow(
  color: dropdownShadowColor,
  blurRadius: 24.r,
  offset: const Offset(0, -8),
);

final imageContainerShadow = BoxShadow(
  color: dropdownShadowColor,
  blurRadius: 24.r,
  offset: const Offset(0, 8),
);
