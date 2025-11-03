import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';

class CustomBackNextButtons extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onNext;
final String buttonText;

  const CustomBackNextButtons({
    super.key,
    required this.onBack,
    required this.onNext,
     this.buttonText = "Next",
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        /// Back Button
        GestureDetector(
          onTap: onBack,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: AllColor.grey, // Light grey
              borderRadius: BorderRadius.circular(30.r),
            ),
            child: Text(
              "Back",
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontFamily:"OpenText"
              ),
            ),
          ),
        ),

        /// Next Button
        GestureDetector(
          onTap: onNext,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: AllColor.primary, // Neon green
              borderRadius: BorderRadius.circular(30.r),
            ),
            child: Text(
              buttonText,
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontFamily: "OpenText"
              ),
            ),
          ),
        ),
      ],
    );
  }
}