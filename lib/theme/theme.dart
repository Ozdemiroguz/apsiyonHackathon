import 'package:auto_route/auto_route.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/colors.dart';
import '../constants/constans.dart';
import '../constants/font_sizes.dart';
import '../constants/system_ui_overlay_styles.dart';
import '../constants/text_styles.dart';
import '../gen/assets.gen.dart';

final theme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: black),
  scaffoldBackgroundColor: darkBgColor,
  // outlinedButtonTheme: _outLinedButtonThemeData,
  filledButtonTheme: _filledButtomThemeData,
  // datePickerTheme: _datePickerThemeData,
  floatingActionButtonTheme: _floatingActionButtonThemeData,
  cupertinoOverrideTheme: _cupertinoThemeData,
  inputDecorationTheme: _inputDecorationTheme,
  // bottomSheetTheme: _bottomSheetThemeData,
  primaryColorLight: apsiyonSecondaryColor,
  primaryColor: black,
  primaryColorDark: apsiyonSecondaryColor,

  textButtonTheme: _textButtonThemeData,
  actionIconTheme: _actionIconThemeData,
  iconButtonTheme: _iconButtonThemeData,
  dialogBackgroundColor: white,
  // dialogTheme: _dialogTheme,

  primaryTextTheme: _textTheme,
  popupMenuTheme: _popupMenuThemeData,
  dividerTheme: _dividerThemeData,
  dividerColor: darkGray,
  drawerTheme: _drawerThemeData,
  listTileTheme: _listTileThemeData,
  checkboxTheme: _checkboxThemeData,
  radioTheme: _radioThemeData,
  appBarTheme: _appBarTheme,
  textTheme: _textTheme,

  useMaterial3: true,
);

final _filledButtomThemeData = FilledButtonThemeData(
  style: ButtonStyle(
    maximumSize: WidgetStatePropertyAll(Size.fromHeight(47.r)),
    minimumSize: WidgetStatePropertyAll(Size.fromHeight(47.r)),
    backgroundColor: WidgetStateProperty.resolveWith<Color>(
      (states) {
        if (states.contains(WidgetState.disabled)) {
          return darkGray;
        } else {
          return darkGray;
        }
      },
    ),
    side: const WidgetStatePropertyAll(BorderSide.none),
    padding: const WidgetStatePropertyAll(EdgeInsets.zero),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
    ),
    textStyle: WidgetStatePropertyAll(displaySmall.copyWith(color: white)),
    foregroundColor: const WidgetStatePropertyAll(white),
    elevation: const WidgetStatePropertyAll(0),
  ),
);

final _popupMenuThemeData = PopupMenuThemeData(
  color: bgColor,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
  elevation: 0,
  textStyle: titleMedium,
);

final _floatingActionButtonThemeData = FloatingActionButtonThemeData(
  backgroundColor: black,
  foregroundColor: bgColor,
  elevation: 0,
  focusElevation: 0,
  hoverElevation: 0,
  extendedIconLabelSpacing: 0,
  highlightElevation: 0,
  disabledElevation: 0,
  extendedPadding: EdgeInsets.zero,
  sizeConstraints: BoxConstraints.tightFor(width: 60.r, height: 60.r),
  extendedSizeConstraints: BoxConstraints.tightFor(width: 60.r, height: 60.r),
  smallSizeConstraints: BoxConstraints.tightFor(width: 60.r, height: 60.r),
  largeSizeConstraints: BoxConstraints.tightFor(width: 60.r, height: 60.r),
  iconSize: 36.r,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(100.r),
    ),
  ),
);

const _cupertinoThemeData = CupertinoThemeData(
  primaryColor: black,
  applyThemeToAll: true,
  scaffoldBackgroundColor: bgColor,
  barBackgroundColor: Colors.white,
  brightness: Brightness.light,
);

final _inputDecorationTheme = InputDecorationTheme(
  constraints: BoxConstraints(
    minHeight: 50.h,
    maxHeight: 177.h,
    maxWidth: 400.w,
    minWidth: 42.w,
  ),
  fillColor: apsiyonSecondaryColor,
  iconColor: darkGray,
  suffixIconColor: darkBlue,
  prefixIconColor: darkBlue,
  hintStyle: bodyLarge,
  labelStyle: bodyLarge.copyWith(color: red),
  errorStyle: bodySmall.copyWith(color: red),
  errorMaxLines: 2,
  contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
  floatingLabelStyle: bodySmall.copyWith(color: darkBlue),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(4.r),
    borderSide: BorderSide(color: lightGray, width: 1.r),
  ),
  focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4.r),
      borderSide: BorderSide(color: apsiyonPrimaryColor, width: 1.r)),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(4.r),
    borderSide: BorderSide(color: red, width: 1.r),
  ),
  disabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(4.r),
    borderSide: BorderSide(color: lightGray, width: 1.r),
  ),
  focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4.r),
      borderSide: BorderSide(color: apsiyonPrimaryColor, width: 1.r)),
);

final _textButtonThemeData = TextButtonThemeData(
  style: ButtonStyle(
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    foregroundColor: const WidgetStatePropertyAll(darkGray),
    backgroundColor: const WidgetStatePropertyAll(Colors.transparent),
    overlayColor: const WidgetStatePropertyAll(Colors.transparent),
    padding: const WidgetStatePropertyAll(EdgeInsets.zero),
    textStyle:
        WidgetStatePropertyAll(titleMedium.copyWith(fontSize: fontSize14)),
  ),
);

final _actionIconThemeData = ActionIconThemeData(
  backButtonIconBuilder: (context) => IconButton(
    onPressed: context.router.maybePop,
    icon: Assets.icons.arrowLeft.svg(),
  ),
);

final _iconButtonThemeData = IconButtonThemeData(style: _iconButtonStyle);

final _iconButtonStyle = ButtonStyle(
  foregroundColor: const WidgetStatePropertyAll(darkGray),
  backgroundColor: const WidgetStatePropertyAll(darkGray),
  iconColor: const WidgetStatePropertyAll(bgColor),
  padding: WidgetStatePropertyAll(EdgeInsets.all(10.r)),
  shape: const WidgetStatePropertyAll(CircleBorder()),
);

// final _dialogTheme = DialogTheme(
//   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
//   contentTextStyle: bodyLargeMobile.copyWith(color: labelColor),
//   titleTextStyle: titleSmallMobile,
//   backgroundColor: backgroundColor,
//   elevation: 0,
// );

final _dividerThemeData = DividerThemeData(
  color: darkGray,
  thickness: 1.r,
  space: 0,
);

const _drawerThemeData = DrawerThemeData(
  backgroundColor: darkBlue,
  elevation: 0,
);

final _listTileThemeData = ListTileThemeData(
  contentPadding: EdgeInsets.symmetric(horizontal: 60.w),
  titleTextStyle: titleMedium,
  subtitleTextStyle: bodyMedium.copyWith(color: textColor),
  dense: true,
  textColor: textColor,
  tileColor: bgColor,
  horizontalTitleGap: 0,
  iconColor: darkGray,
);

final _checkboxThemeData = CheckboxThemeData(
  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
  checkColor: const WidgetStatePropertyAll(white),
  shape: RoundedRectangleBorder(
    side: BorderSide(color: darkGray, width: 1.r),
    borderRadius: BorderRadius.circular(4.r),
  ),
  side: BorderSide(color: darkBlue.withOpacity(.2), width: 1.r),
  fillColor: WidgetStateProperty.resolveWith((states) {
    if (states.contains(WidgetState.selected)) return darkGray;
    return null;
  }),
);

final _radioThemeData = RadioThemeData(
  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
  fillColor: WidgetStateProperty.resolveWith((states) {
    if (states.contains(WidgetState.selected)) return darkGray;
    return darkGray;
  }),
);

final _appBarTheme = AppBarTheme(
  iconTheme: _iconThemeData,
  systemOverlayStyle: systemUiOverlayDarkStyle,
  actionsIconTheme: _iconThemeData,
  titleTextStyle: titleMedium,
  foregroundColor: bgColor,
  scrolledUnderElevation: 0,
  elevation: 0,
  centerTitle: true,
  toolbarHeight: kAppBarHeight,
  backgroundColor: Colors.transparent,
);

final _iconThemeData = IconThemeData(
  color: darkBlue,
  size: 100.r,
);

final _textTheme = TextTheme(
  titleSmall: titleSmall,
  titleMedium: titleMedium,
  titleLarge: titleLarge,
  headlineSmall: headlineSmall,
  headlineMedium: headlineMedium,
  headlineLarge: headlineLarge,
  bodySmall: bodySmall,
  bodyMedium: bodyMedium,
  bodyLarge: bodyLarge,
  labelSmall: labelSmall,
  labelMedium: labelMedium,
  labelLarge: labelLarge,
  displaySmall: displaySmall,
  displayMedium: displayMedium,
  displayLarge: displayLarge,
);
