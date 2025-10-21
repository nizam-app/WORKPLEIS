// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:workpleis/core/constants/color_control/all_color.dart';
// import 'package:workpleis/core/constants/color_control/theme_color_controller.dart';
// import 'package:workpleis/core/theme/text_theme.dart';
// import 'input_decoration_theme.dart';
// import 'logic/theme_changer.dart';
//
// final ThemeChanger _themeController = Get.put(ThemeChanger());
//
// ThemeData themeMood() {
//   Brightness brightness = _themeController.isDarkMode.value
//       ? Brightness.light
//       : Brightness.dark;
//
//   return ThemeData(
//     brightness: brightness,
//     colorScheme: ColorScheme.light(
//       brightness: brightness,
//       primary: AllColor.lightBlue,
//       onPrimary:  AllColor.white,
//       secondary: ThemeColorController.green,
//       onSecondary: AllColor.white,
//       surface: ThemeColorController.grey,
//       onSurface: ThemeColorController.white,
//     ),
//     inputDecorationTheme: InputDecorationTheme(
//       filled: true,
//       fillColor: Color(0xffA49ACF).withOpacity(0.05),
//       // Background same like screenshot
//       contentPadding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 14.w),
//
//       hintStyle: TextStyle(
//         color: AllColor.grey,
//         fontSize: 14.sp,
//         fontWeight: FontWeight.w400,
//       ),
//
//       suffixIconColor: Colors.grey,
//       // border: OutlineInputBorder(
//       //   borderRadius: BorderRadius.circular(10.r),
//       //   borderSide: BorderSide(color: AllColor.borderColor, width: 1.2),
//       // ),
//
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(10.r),
//         borderSide: BorderSide(color: AllColor.borderColor, width: 1),
//       ),
//       //
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(10.r),
//         borderSide: BorderSide(color: AllColor.borderColor, width: 1.2),
//       ),
//       //
//       // errorBorder: OutlineInputBorder(
//       //   borderRadius: BorderRadius.circular(10.r),
//       //   borderSide: BorderSide(color: AllColor.red200, width: 1),
//       // ),
//       //
//       // focusedErrorBorder: OutlineInputBorder(
//       //   borderRadius: BorderRadius.circular(10.r),
//       //   borderSide: BorderSide(color: AllColor.red200, width: 1.2),
//       // ),
//       //
//       // errorStyle: TextStyle(
//       //   fontSize: 12.sp,
//       //   color: AllColor.red200,
//       // ),
//     ),
//     // apply globally
//     useMaterial3: true,
//     textTheme: TextTheme(
//       titleLarge: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w500),
//       titleMedium: TextStyle(
//         fontSize: 14.sp,
//         color: Colors.grey,
//         fontFamily: "bodyFont",
//         fontWeight: FontWeight.w400,
//         // letterSpacing: 1
//       ),
//       titleSmall: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w600),
//       headlineSmall: TextStyle(
//         fontSize: 8.sp,
//         fontWeight: FontWeight.w300,
//         color: AllColor.black,
//         fontFamily: "bodyFont",
//       ),
//       headlineMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
//       headlineLarge: TextStyle(
//         fontSize: 22.sp,
//         fontWeight: FontWeight.w500,
//         color: AllColor.black,
//         fontFamily: "bodyFont",
//       ),
//       bodySmall: TextStyle(
//         fontSize: 30,
//         fontWeight: FontWeight.w500,
//         fontFamily: "bodyFont",
//         color: AllColor.black,
//       ),
//       bodyMedium: TextStyle(
//         fontSize: 14,
//         fontWeight: FontWeight.w300,
//         fontFamily: "bodyFont",
//         color: AllColor.black,
//       ),
//     ),
//     scaffoldBackgroundColor: _themeController.isDarkMode.value
//         ? ThemeColorController.black
//         : AllColor.white,
//   );
// }
