// import 'package:auto_route/auto_route.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import '../constants/colors.dart';
// import '../constants/constans.dart';
// import '../gen/assets.gen.dart';

// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final String? title;
//   final Widget? leading;
//   final double? leadingWidth;
//   final double bottomHeight;
//   final List<Widget>? actions;
//   final PreferredSizeWidget? bottom;
//   final VoidCallback? onBackPressed;

//   const CustomAppBar({
//     super.key,
//     this.title,
//     this.actions,
//     this.leading,
//     this.leadingWidth,
//     this.bottom,
//     this.bottomHeight = 0,
//     this.onBackPressed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(
//         left: 20.w,
//         right: 20.w,
//       ),
//       child: AppBar(
//         title: title != null
//             ? Text(
//                 title!,
//                 overflow: TextOverflow.ellipsis,
//               )
//             : null,
//         leading: leading ??
//             (context.router.canPop()
//                 ? IconButton.filled(
//                     onPressed: onBackPressed ?? () => context.popRoute(),
//                     style: IconButton.styleFrom(
//                       padding: EdgeInsets.zero,
//                       backgroundColor: Colors.transparent,
//                       elevation: 0,
//                     ),
//                     icon: Assets.icons.arrowLeft.svg(colorFilter: const ColorFilter.mode(AppColors.primary, BlendMode.srcIn)),
//                   )
//                 : null),
//         toolbarHeight: 44.h,
//         leadingWidth: 200.w,
//         actions: actions,
//         bottom: bottom,
//       ),
//     );
//   }

//   @override
//   Size get preferredSize => Size.fromHeight(kAppBarHeight + bottomHeight + 24.h);
// }
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/colors.dart';
import '../gen/assets.gen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final String? leadingText;
  final Widget? leading;
  final double? leadingWidth;
  final double? toolbarHeight;
  final double bottomHeight;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;
  final VoidCallback? onBackPressed;
  final Color? backgroundColor;

  const CustomAppBar({
    super.key,
    this.leadingText,
    this.title,
    this.actions,
    this.leading,
    this.leadingWidth,
    this.toolbarHeight,
    this.bottom,
    this.bottomHeight = 0,
    this.onBackPressed,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: white,
        boxShadow: [
          BoxShadow(
            color: black.withOpacity(0.1),
            offset: const Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      padding:
          EdgeInsets.only(left: 30.w, right: 30.w, top: 50.h, bottom: 24.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: onBackPressed ??
                () {
                  context.router.maybePop();
                },
            child: leading ??
                GestureDetector(
                  onTap: onBackPressed ?? () => context.router.maybePop(),
                  child: SizedBox(
                    width: 24.w,
                    height: 24.h,
                    child: Assets.icons.vector.svg(),
                  ),
                ),
          ),
          Assets.images.tododysLogo.image(
            height: 36.h,
          ),
          SizedBox(height: 24.h, child: Assets.icons.threedot.svg()),

          //actions null değilse ekle yoksa boş bırak
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight((toolbarHeight ?? 30.h) + 80.h);
}
