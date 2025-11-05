

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/color_control/all_color.dart';
import '../../../core/constants/image_control/image_path.dart';
import '../screens/register_screen.dart';

class CustomGmailButton extends StatelessWidget {
  const CustomGmailButton({
    super.key, required this.onTop, required this.taxt,
  });
  final VoidCallback onTop;
  final String taxt ;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 18.h),

        // ── Divider with text
        Row(
          children: [
            Expanded(child: Container(height: 1, color: AllColor.black.withOpacity(.1))),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Text(
                'OR',
                style: TextStyle(fontSize: 18.sp, color: AllColor.grey, fontFamily:"OpenText", fontWeight: FontWeight.w600),
              ),
            ),
            Expanded(child: Container(height: 1, color: AllColor.black.withOpacity(.1))),
          ],
        ),
        SizedBox(height: 14.h),

        SizedBox(
          width: double.infinity,
          height: 46.h,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AllColor.black,
              foregroundColor: AllColor.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              elevation: 0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  ImagePath.google,
                  height: 18.h,
                ),
                SizedBox(width: 8.w),
                Text('Sign in with Google', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, fontFamily:"OpenText")),
              ],
            ),
          ),
        ),
        SizedBox(height: 30.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Don't have an account? ",
              style: TextStyle(fontSize: 16.sp, color: AllColor.grey, fontFamily:"OpenText", fontWeight: FontWeight.w600),
            ),
            SizedBox(width: 5.w),
            GestureDetector(
              onTap: onTop,
              child: Text(
                taxt,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: AllColor.black,
                  fontWeight: FontWeight.w700,
                  fontFamily:"OpenText"
                ),
              ),
            )
          ],
        ),
        SizedBox(height: 18.h),

      ],
    );
  }
}
