import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/color_control/all_color.dart';

class CustomBottomButtonsSection extends StatelessWidget {
  const CustomBottomButtonsSection({super.key, required this.onPressed, this.text = "Next"});
  final VoidCallback onPressed;
  final String? text ;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
        height: 80.h,
      color: AllColor.grey200,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: (){context.pop();},
            child: Text("Back",
                style: TextStyle(fontSize: 18.sp, color: AllColor.black, fontWeight: FontWeight.w600)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AllColor.black,
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            onPressed:onPressed,
            child: Text("$text",
                style: TextStyle(fontSize: 13.sp, color: AllColor.white)),
          ),
        ],
      ),
    );
  }
}
