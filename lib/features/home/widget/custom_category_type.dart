import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/color_control/all_color.dart';

class CustomCategoryType extends StatelessWidget {
  const CustomCategoryType({super.key, this.checkSeeButton = false});
  final bool? checkSeeButton;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Job Posts",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w900,
            color: AllColor.black87,
          ),
        ),

if (checkSeeButton == false)
        InkWell(
          onTap: () {},
          child: Text(
            "See All",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w800,
              color: AllColor.black87,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
