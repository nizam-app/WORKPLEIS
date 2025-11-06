import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/color_control/all_color.dart';
import '../../account/widget/custom_buttom.dart';

class CustomAavailableBalanceCard extends StatelessWidget {
  const CustomAavailableBalanceCard({
    super.key, required this.buttonText,
  });
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 20.h),
      decoration: BoxDecoration(
        color: AllColor.white24,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AllColor.grey, width: 1.w),
      ),
      child: Column(
        children: [
          Text(
            "Available Balance",
            style: TextStyle(
                color: AllColor.black,
                fontWeight: FontWeight.w800,
                fontSize: 18.sp,
              fontFamily: "headFont"
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            "\$1,250.00",
            style: TextStyle(
                fontSize: 26.sp, fontWeight: FontWeight.w400, fontFamily: "OpenText"),
          ),
          // SizedBox(height: 10.h),

          Padding(
            padding: const EdgeInsets.all(20.0),
            child: CustomButtom(text: buttonText, color: AllColor.primary, fontWeight: FontWeight.w400, ),
          ),

        ],
      ),
    );
  }
}