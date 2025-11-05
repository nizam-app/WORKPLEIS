import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';

import '../screens/indentity_verification_screen.dart';

class CustomChooseFile extends StatelessWidget {
  const CustomChooseFile({super.key, this.title = 'Front Side', this.onTap});

  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// ---- Title ----
        Padding(
          padding: EdgeInsets.only(bottom: 8.h),
          child: Text(
            title,
            style: TextStyle(
              color: AllColor.borderColor, // soft purple-gray
              fontSize: 18.sp,
              fontWeight: FontWeight.w800,
              fontFamily: "headFont",
            ),
          ),
        ),

        /// ---- Upload Box ----
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            height: 140.h,
            decoration: BoxDecoration(
              color: const Color(0xFFF7F6FB), // soft lavender background
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: const Color(0xFFD1CCE1), // dotted look
                width: 1,
                style: BorderStyle.solid,
              ),
            ),
            child: DottedBorderOverlay(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.upload_outlined,
                    size: 28.sp,
                    color: const Color(0xFF8A7CA8),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    'Choose files or drag and drop',
                    style: TextStyle(
                      color: AllColor.borderColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      fontFamily: "OpenText",
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Only jpg or png file type accepted',
                    style: TextStyle(
                      color: AllColor.borderColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      fontFamily: "OpenText",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}