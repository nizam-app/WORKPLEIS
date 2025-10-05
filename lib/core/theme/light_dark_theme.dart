import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/core/constants/color_control/theme_color_controller.dart';
import 'package:workpleis/core/theme/text_theme.dart';
import 'input_decoration_theme.dart';
import 'logic/theme_changer.dart';

final ThemeChanger _themeController = Get.put(ThemeChanger());

ThemeData themeMood() {
  Brightness brightness = _themeController.isDarkMode.value
      ? Brightness.light
      : Brightness.dark;

  return ThemeData(
    brightness: brightness,
    colorScheme: ColorScheme.light(
      brightness: brightness,
      primary: AllColor.lightBlue,
      onPrimary: _themeController.isDarkMode.value
          ? AllColor.white
          : ThemeColorController.black,
      secondary: ThemeColorController.green,
      onSecondary: _themeController.isDarkMode.value
          ? AllColor.white
          : ThemeColorController.black,
      surface: ThemeColorController.grey,
      onSurface: _themeController.isDarkMode.value
          ? ThemeColorController.white
          : AllColor.black,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Color(0xffA49ACF).withOpacity(0.05), // Background same like screenshot
      contentPadding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 14.w),

      hintStyle: TextStyle(
        color: AllColor.grey,
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
      ),

      suffixIconColor: Colors.grey,

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide(color: AllColor.borderColor, width: 1),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide(color: AllColor.borderColor, width: 1.2),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide(color: AllColor.red200, width: 1),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide(color: AllColor.red200, width: 1.2),
      ),

      errorStyle: TextStyle(
        fontSize: 12.sp,
        color: AllColor.red200,
      ),
    ), // apply globally
    useMaterial3: true,
    textTheme: textTheme,
    scaffoldBackgroundColor: _themeController.isDarkMode.value
        ? ThemeColorController.black
        : AllColor.white,
  );
}
