import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';

class GlobalAleartBox extends StatelessWidget {
  const GlobalAleartBox({
    super.key,
    required this.message,
    required this.oneTap,
  });

  final String message;
  final VoidCallback oneTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 24.w),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
      decoration: BoxDecoration(
        color: AllColor.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AllColor.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ✅ Lime check circle
          Container(
            height: 60.h,
            width: 60.w,
            decoration: const BoxDecoration(
              color: AllColor.primary,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check, color: AllColor.white, size: 40),
          ),
          SizedBox(height: 20.h),

          // ✅ Message text
          Text(
            message ?? "Summit Successfully",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black,
              height: 1.4,
              fontFamily: "OpenText"
            ),
          ),
          SizedBox(height: 24.h),

          // ✅ Close Button
          SizedBox(
            width: 120.w,
            height: 40.h,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AllColor.bgcolor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.r),
                ),
                elevation: 0,
              ),
              onPressed: oneTap,
              child: Text(
                "OK",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: "OpenText"
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// ✅ Use this function to show the dialog
void globalShowAlertDialog({
  required BuildContext context,
  required VoidCallback oneTap,
   String message ="You’ve successfully completed all verification "
   "steps. Our team will verify your information"
   " and notify you once your account is approved.",
}) {
  showDialog(
    context: context,
    barrierDismissible: false, // prevent closing by tapping outside
    builder: (BuildContext context) {
      return Dialog(

        backgroundColor: Colors.transparent,

        insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
        child: GlobalAleartBox(oneTap: oneTap, message: message),
      );
    },
  );
}