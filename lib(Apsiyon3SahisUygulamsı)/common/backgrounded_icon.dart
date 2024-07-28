import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../gen/assets.gen.dart';

class BackgroundedIcon extends StatelessWidget {
  final Color backgroundColor;
  final SvgGenImage icon;
  final Color? iconColor;
  final double? height;
  final double? width;
  final double? iconSize;
  const BackgroundedIcon({
    super.key,
    required this.backgroundColor,
    required this.icon,
    this.iconColor,
    this.iconSize,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 80.h,
      width: width ?? 145.w,
      alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.center,
        children: [
          icon.svg(
            height: iconSize ?? 32.r,
            width: iconSize ?? 32.r,
            colorFilter: iconColor != null
                ? ColorFilter.mode(iconColor!, BlendMode.srcIn)
                : null,
          ),
        ],
      ),
    );
  }
}
