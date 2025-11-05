import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
class CustomPillButton extends StatelessWidget {
  const CustomPillButton({
    super.key,
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
    final side  = BorderSide(color: AllColor.black, width: 1.3.w);
    final bg    = isSelected ? AllColor.white : AllColor.primary;
    final fg    = AllColor.black;

    return IntrinsicWidth( // ✅ content অনুযায়ী width
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: 46.h), // ✅ height fix
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: bg,
            foregroundColor: fg,
            shape: shape,
            side: side,
            padding: EdgeInsets.symmetric(horizontal: 16.w), // ✅ horiz padding
            minimumSize: Size(0, 46.h), // ✅ width free, height fixed
            // ⛔️ maximumSize দেবেন না, না হলে ফুল-উইডথ ধরে ফেলবে
          ),
          child: Text(
            label,
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: fg),
            softWrap: false, // এক লাইনে
          ),
        ),
      ),
    );
  }
}