import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';

class GlobalGetStartedButton extends StatelessWidget {
  const GlobalGetStartedButton({
    super.key,
    this.buttonName = "Get Started",
    required this.onTap,
    this.color = AllColor.white,
     this.borderRadius = 12,  this.height = 50,  this.textColor = Colors.black,
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
          borderRadius: BorderRadius.circular(borderRadius.r), // rounded corners
        ),
        child: Center(
          child: Text(
            buttonName,
            style: TextStyle(
              fontSize: 18.sp, // responsive font
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}