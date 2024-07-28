import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:apsiyon/constants/colors.dart';

class CustomDraggableScrollableSheet extends HookWidget {
  final ScrollController? scrollController1;
  final Color? color;
  final String? title;
  final List<Widget> children;

  const CustomDraggableScrollableSheet({
    this.scrollController1,
    this.color,
    this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.2,
      minChildSize: 0.1,
      maxChildSize: 0.9,
      builder: (BuildContext context, scrollController) {
        return Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: color ?? bgColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
            controller: scrollController,
            itemCount: 2,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 6.h,
                          width: 104.w,
                          decoration: BoxDecoration(
                            color: const Color(0xffE6E6E6),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    if (title == null)
                      const SizedBox()
                    else
                      Text(
                        title!,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                  ],
                );
              }
              return Column(
                children: children,
              );
            },
          ),
        );
      },
    );
  }
}
