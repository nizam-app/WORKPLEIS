import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';

class GlobalButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? color;
  final double? fontSize;
  final EdgeInsetsGeometry? padding;
  final Color? textColor;

  const GlobalButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color,
    this.fontSize,
    this.padding,
    this.textColor = AllColor.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width:140.w, // full width
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? AllColor.bgcolor, // default black
          padding: padding ?? EdgeInsets.symmetric(vertical: 12.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color:AllColor.grey,
            fontSize: fontSize ?? 18.sp,
            fontWeight: FontWeight.w600,
            fontFamily: "OpenText"
          ),
        ),
      ),
    );
  }
}
