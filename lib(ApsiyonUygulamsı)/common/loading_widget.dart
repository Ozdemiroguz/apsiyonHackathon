import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class LoadingWidget extends StatelessWidget {
  const LoadingWidget();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.r,
      width: 40.r,
      child: const Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
