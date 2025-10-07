import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';

InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
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
);
