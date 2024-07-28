// import 'package:flutter/material.dart';

// import '../constants/colors.dart';

// enum _Type { green, gray }

// abstract final class CustomFilledButton extends StatelessWidget {
//   final void Function()? onPressed;
//   final Widget child;
//   final bool isGreen;
//   final void Function()? onLongPress;
//   final void Function(bool)? onHover;
//   final void Function(bool)? onFocusChange;
//   final FocusNode? focusNode;
//   final bool autofocus;
//   final Clip clipBehavior;
//   final MaterialStatesController? statesController;
//   final _Type type;

//   const CustomFilledButton({
//     required this.type,
//     required this.onPressed,
//     required this.child,
//     this.isGreen = false,
//     this.onLongPress,
//     this.onHover,
//     this.onFocusChange,
//     this.focusNode,
//     this.statesController,
//     this.autofocus = false,
//     this.clipBehavior = Clip.none,
//   });

//   const factory CustomFilledButton.orange({
//     required void Function()? onPressed,
//     required Widget child,
//     bool isGreen,
//     void Function()? onLongPress,
//     void Function(bool)? onHover,
//     void Function(bool)? onFocusChange,
//     FocusNode? focusNode,
//     bool autofocus,
//     Clip clipBehavior,
//     MaterialStatesController? statesController,
//   }) = _OrangeButton;

//   const factory CustomFilledButton.darkBlue({
//     required void Function()? onPressed,
//     required Widget child,
//     bool isGreen,
//     void Function()? onLongPress,
//     void Function(bool)? onHover,
//     void Function(bool)? onFocusChange,
//     FocusNode? focusNode,
//     bool autofocus,
//     Clip clipBehavior,
//     MaterialStatesController? statesController,
//   }) = _DarkBlue;

//   // const factory CustomDialog.success({
// }

// final class _DarkBlue extends CustomFilledButton {
//   const _DarkBlue({
//     super.onPressed,
//     required super.child,
//     super.isGreen = false,
//     super.onLongPress,
//     super.onHover,
//     super.onFocusChange,
//     super.focusNode,
//     super.statesController,
//     super.autofocus = false,
//     super.clipBehavior = Clip.none,
//   }) : super(type: _Type.green);

//   @override
//   Widget build(BuildContext context) {
//     return FilledButton(
//       onPressed: onPressed,
//       style: ButtonStyle(
//         backgroundColor: MaterialStateProperty.resolveWith<Color>(
//           (states) {
//             if (states.contains(MaterialState.disabled)) {
//               return gray;
//             } else {
//               return darkBlue;
//             }
//           },
//         ),
//       ),
//       onLongPress: onLongPress,
//       onHover: onHover,
//       onFocusChange: onFocusChange,
//       focusNode: focusNode,
//       autofocus: autofocus,
//       clipBehavior: clipBehavior,
//       statesController: statesController,
//       child: child,
//     );
//   }
// }

// final class _OrangeButton extends CustomFilledButton {
//   const _OrangeButton({
//     super.onPressed,
//     required super.child,
//     super.isGreen = false,
//     super.onLongPress,
//     super.onHover,
//     super.onFocusChange,
//     super.focusNode,
//     super.statesController,
//     super.autofocus = false,
//     super.clipBehavior = Clip.none,
//   }) : super(type: _Type.gray);

//   @override
//   Widget build(BuildContext context) {
//     return FilledButton(
//       onPressed: onPressed,
//       style: ButtonStyle(
//         foregroundColor: MaterialStateProperty.resolveWith<Color>(
//           (states) {
//             if (states.contains(MaterialState.disabled)) {
//               return darkBlue;
//             } else {
//               return yellow;
//             }
//           },
//         ),
//         side: MaterialStateProperty.resolveWith<BorderSide>(
//           (states) => BorderSide.none,
//         ),
//         backgroundColor: MaterialStateProperty.resolveWith<Color>(
//           (states) {
//             if (states.contains(MaterialState.disabled)) {
//               return gray;
//             } else {
//               return yellow.withOpacity(.16);
//             }
//           },
//         ),
//       ),
//       onLongPress: onLongPress,
//       onHover: onHover,
//       onFocusChange: onFocusChange,
//       focusNode: focusNode,
//       autofocus: autofocus,
//       clipBehavior: clipBehavior,
//       statesController: statesController,
//       child: child,
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/colors.dart';

class CustomFilledButton extends HookWidget {
  final VoidCallback? onPressed;
  final Widget? child;
  final Color? color;
  final Color? borderColor;
  final String? buttonText;
  final bool? disabled;

  const CustomFilledButton({
    required this.onPressed,
    this.child,
    this.color,
    this.borderColor,
    this.buttonText,
    this.disabled,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: disabled == true ? null : onPressed,
      style: ButtonStyle(
        //border side color
        side: WidgetStateProperty.resolveWith<BorderSide>(
          (states) => BorderSide(
            color: borderColor ?? (color ?? apsiyonPrimaryColor),
            width: 1.0.r,
          ),
        ),

        backgroundColor: WidgetStateProperty.resolveWith<Color>(
          (states) {
            if (states.contains(WidgetState.disabled)) {
              return color ?? apsiyonPrimaryColor.withOpacity(.5);
            } else {
              return disabled == true
                  ? apsiyonPrimaryColor.withOpacity(0.5)
                  : color ?? apsiyonPrimaryColor;
            }
          },
        ),
      ),
      child: buttonText != null
          ? Text(
              buttonText!,
              style: Theme.of(context)
                  .textTheme
                  .displaySmall!
                  .copyWith(color: Colors.white),
            )
          : child ??
              Text(
                "CustomFilledButton",
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(color: Colors.white),
              ),
    );
  }
}
