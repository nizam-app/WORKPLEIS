import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';

class GlobalGetStartedButton extends StatelessWidget {
  const GlobalGetStartedButton({
    super.key,
    this.buttonName = "Get Started",
    required this.onTap,
    this.color = AllColor.white,
     this.borderRadius = 50,  this.height = 50,  this.textColor = Colors.black,
  });

  final String buttonName;
  final VoidCallback onTap;
  final Color color;
  final double borderRadius;
  final double height ;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // responsive width
        height: height.h, // responsive height
        decoration: BoxDecoration(
          color: color, // neon green background
          borderRadius: BorderRadius.circular(borderRadius.r),
          border: Border.all(width: 1.w, color:AllColor.black),
          // rounded corners
        ),
        child: Center(
          child: Text(
            buttonName,
            style: TextStyle(
              fontSize: 16.sp, // responsive font
              fontWeight: FontWeight.w600,
              color: textColor,
              fontFamily: "sf_pro"

            ),
          ),
        ),
      ),
    );
  }
}


class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color bgColor;
  final Color textColor;
  final IconData? icon;

  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
    this.bgColor = Colors.black,
    this.textColor = Colors.white,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(32.r),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 14.h),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(32.r),
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                text,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: textColor,
                  fontFamily: "sf_pro",
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (icon != null) ...[
                SizedBox(width: 8.w),
                Icon(
                  icon,
                  color: textColor,
                  size: 16.sp,
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
