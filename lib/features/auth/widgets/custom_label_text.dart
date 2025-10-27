import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';

class CustomLabelText extends StatelessWidget {
  const CustomLabelText({
    super.key, required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(bottom: 8.h),
      child: Align(
        alignment: Alignment.centerLeft,

        child: Text(title,
            style: TextStyle(
                fontSize: 16.sp, fontWeight: FontWeight.w800, color: AllColor.borderColor, fontFamily: "headFont")),
      ),
    );
  }
}


class CustomPaymentText extends StatelessWidget {
  const CustomPaymentText({
    super.key, required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(left: 5.w, bottom: 5.h),
      child: Align(
        alignment: Alignment.centerLeft,

        child: Text(title,
            style: TextStyle(
                fontSize: 16.sp, fontWeight: FontWeight.w800, color: AllColor.borderColor, fontFamily: "headFont")),
      ),
    );
  }
}