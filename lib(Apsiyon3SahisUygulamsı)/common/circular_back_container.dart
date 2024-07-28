import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/colors.dart';

class CircularBackContainer extends StatelessWidget {
  final Color? color;
  final Widget child;
  final double? size;

  const CircularBackContainer({this.color, required this.child, this.size});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: size?.w ?? 36.w,
      height: size?.h ?? 36.h,
      decoration: BoxDecoration(
        color: color ?? darkBgColor2,
        shape: BoxShape.circle,
      ),
      child: Align(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            child,
          ],
        ),
      ),
    );
    // TODO: implement build
  }
}
