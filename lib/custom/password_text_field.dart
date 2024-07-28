import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/colors.dart';

import '../gen/assets.gen.dart';
import '../utils/input_formatters.dart';
import 'custom_text_field.dart';

class PasswordTextField extends HookWidget {
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final BoxConstraints? prefixIconConstraints;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String?>? onSaved;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final TextEditingController? controller;
  final AutovalidateMode? autovalidateMode;
  final bool isDisabled;

  ///Default is lock icon
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? hintText;
  final String? labelText;
  final bool? isNewPassword;

  const PasswordTextField({
    this.prefixIconConstraints,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.textInputAction,
    this.textInputType = TextInputType.visiblePassword,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.validator,
    this.onChanged,
    this.onSaved,
    this.hintText,
    this.labelText,
    this.autovalidateMode,
    this.isDisabled = false,
    this.isNewPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    final obscureText = useState(true);
    final focusNode = useFocusNode();
    useListenable(focusNode);

    return CustomTextField(
      maxLines: 1,
      expands: false,
      onFieldSubmitted: onFieldSubmitted,
      onEditingComplete: onEditingComplete,
      textInputType: textInputType,
      inputFormatters: isNewPassword!
          ? newPasswordInputFormatters()
          : passwordInputFormatters(),
      controller: controller,
      focusNode: focusNode,
      onChanged: onChanged,
      onSaved: onSaved,
      obscureText: obscureText.value,
      textInputAction: textInputAction,
      hintText: hintText,
      labelText: labelText,
      validator: validator,
      prefixIcon: prefixIcon,
      prefixIconConstraints: prefixIconConstraints,
      suffixIconConstraints: BoxConstraints(minHeight: 12.r, minWidth: 47.r),
      suffixIcon: GestureDetector(
        onTap: () => obscureText.value = !obscureText.value,
        child: getSuffixIcon(
          context,
          obscureText: obscureText.value,
          hasFocus: focusNode.hasFocus,
        ),
      ),
      enabled: !isDisabled,
      autovalidateMode: autovalidateMode,
    );
  }

  Widget getSuffixIcon(
    BuildContext context, {
    required bool obscureText,
    required bool hasFocus,
  }) {
    late final SvgGenImage image;

    if (obscureText) {
      image = Assets.icons.eyeOff;
    } else {
      image = Assets.icons.eyeOn;
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.r, vertical: 12.h),
      child: image.svg(
        height: 26.h,
        width: 24.r,
        fit: BoxFit.scaleDown,
        colorFilter: ColorFilter.mode(
          isDisabled
              ? darkGray
              : hasFocus
                  ? apsiyonPrimaryColor
                  : darkGray,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
