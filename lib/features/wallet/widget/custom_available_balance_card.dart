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
        color: AllColor.brand2_light,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AllColor.grey, width: 1.w),
      ),
      child: Column(
        children: [
          Text(
            "Available Balance",
            style: TextStyle(
                color: AllColor.black54,
                fontWeight: FontWeight.w400,
                fontSize: 18.sp),
          ),
          SizedBox(height: 6.h),
          Text(
            "\$1,250.00",
            style: TextStyle(
                fontSize: 26.sp, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 10.h),

          Padding(
            padding: const EdgeInsets.all(30.0),
            child: CustomButtom(text: buttonText, color: AllColor.white, ),
          ),

        ],
      ),
    );
  }
}