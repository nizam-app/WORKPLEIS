import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';

class CustomPillButton extends StatelessWidget {
  const CustomPillButton({
    required this.label,
    required this.onPressed,
    required this.isSelected,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final shape = const StadiumBorder();
    final side = BorderSide(color: AllColor.black, width: 1.3.w);

    final bgColor = isSelected ? AllColor.white : AllColor.primary;
    final textColor = AllColor.black;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: bgColor,
        foregroundColor: textColor,
        shape: shape,
        side: side,
        padding: EdgeInsets.symmetric(
          horizontal: 24.w, // ✅ শুধু width এ space দেবে
          vertical: 0, // ✅ height fix রাখার জন্য vertical padding 0
        ),
        minimumSize: Size(0, 46.h), // ✅ Height fix, width auto expand
        maximumSize: Size(double.infinity, 46.h), // ✅ height কখনো বাড়বে না
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
