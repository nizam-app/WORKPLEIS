import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';

class CustomButtom extends StatelessWidget {
  final String text;
  final Color color;
  final Color? textColor;
  final double? height;
  final double? width;
  final double? borderRadius;
  final FontWeight? fontWeight;
  final VoidCallback? onTap;
  final bool hasShadow;
  final IconData? icon; // 🔹 optional icon
  final double? iconSize;
  final Color? iconColor;
  final bool centerContent;

  const CustomButtom({
    super.key,
    required this.text,
    required this.color,
    this.textColor,
    this.height,
    this.width,
    this.borderRadius,
    this.fontWeight,
    this.onTap,
    this.hasShadow = true,
    this.icon,
    this.iconSize,
    this.iconColor,
    this.centerContent = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? double.infinity,
        height: height ?? 34.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(borderRadius ?? 10.r),
          border: Border.all(color: AllColor.grey, width: 1),
          boxShadow: hasShadow
              ? [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ]
              : [],
        ),
        child: Row(
          mainAxisAlignment:
          centerContent ? MainAxisAlignment.center : MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: iconSize ?? 18.sp,
                color: iconColor ?? textColor ?? Colors.black,
              ),
              SizedBox(width: 6.w),
            ],
            Text(
              text,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: fontWeight ?? FontWeight.w400,
                color: textColor ?? Colors.black,
                letterSpacing: 0.5,
                fontFamily: "OpenText"
              ),
            ),
          ],
        ),
      ),
    );
  }
}