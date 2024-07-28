import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../constants/colors.dart';

void showToast(
  BuildContext context, {
  required String text,
  Color? backgroundColor = white,

  ///Default value is primary color
  Color? textColor,
  Widget? icon,
  Duration duration = const Duration(seconds: 2),
}) {
  final fToast = FToast()
    ..init(context)
    ..removeQueuedCustomToasts();

  final toast = Container(
    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(4.r),
      color: backgroundColor,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          icon,
          SizedBox(width: 6.w),
        ],
        Flexible(
          child: Text(
            text,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: textColor,
                ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );

  fToast.showToast(child: toast, gravity: ToastGravity.BOTTOM, toastDuration: duration);
}
