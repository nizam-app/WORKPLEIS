import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';

TextTheme get textTheme {
  return TextTheme(
      titleLarge: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w500),
      titleMedium: TextStyle(
        fontSize: 12.sp,
        color: AllColor.grey,
        fontWeight: FontWeight.w400,
        // letterSpacing: 1
      ),
      titleSmall: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w600),
      headlineSmall: TextStyle(
        fontSize: 8.sp,
        fontWeight: FontWeight.w300,
        color: AllColor.black,
        fontFamily: "bodyFont",
      ),
      headlineMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      headlineLarge: TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.w800,
        color: AllColor.black,
      ),
      bodySmall: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w900,
        fontFamily: "bodyFont",
        color: AllColor.black
      ),
      bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight:
          FontWeight.w300,
          fontFamily: "bodyFont",
          color: AllColor.black
      ));
  }
