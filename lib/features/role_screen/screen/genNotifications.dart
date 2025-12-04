import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Gennotifications extends StatelessWidget {
  const Gennotifications({super.key});

  static const String routeName = '/notification';

  @override
  Widget build(BuildContext context) {
    // main colors (approx same as UI)
    const Color kTitleGreen = Color(0xFF064E3B);
    const Color kHighlight = Color(0xFFE4FF5A);
    const Color kBodyText = Color(0xFF4B5563);
    const Color kPrimaryDark = Color(0xFF03051A);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// top logo
              Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: Image.asset(
                  'assets/images/splashlogo.png', // your logo
                  height: 47.h,
                  fit: BoxFit.contain,
                ),
              ),

              SizedBox(height: 40.h),

              /// bell icon
              Center(
                child: Image.asset(
                  'assets/images/getNotification.png', // your bell 3D icon
                  height: 150.h,
                  fit: BoxFit.contain,
                ),
              ),

              SizedBox(height: 32.h),

              /// title with highlight
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Get notified when',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize:40.sp,
                        fontFamily: 'sf_Pro',
                        fontWeight: FontWeight.w700,
                        color: kTitleGreen,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Container(
                      padding:
                      EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: kHighlight,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        "it's payday.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 40.sp,
                          fontFamily: 'sf_Pro',
                          fontWeight: FontWeight.w700,
                          color: kTitleGreen,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16.h),

              /// subtitle
              Center(
                child: Text(
                  "Enable notifications and we’ll let\n"
                      "you know the moment your\n"
                      "payout is ready.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontFamily: 'sf_Pro',
                    fontWeight: FontWeight.w500,
                    height: 1.35,
                    color: kBodyText,
                  ),
                ),
              ),

              const Spacer(),

              /// Enable notifications button
              SizedBox(
                width: double.infinity,
                height: 56.h,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: request notification permission / next
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryDark,
                    shape: const StadiumBorder(),
                    elevation: 0,
                  ),
                  child: Text(
                    'Enable notifications',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontFamily: 'sf_Pro',
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 16.h),

              /// Skip
              Center(
                child: TextButton(
                  onPressed: () {
                    // TODO: skip navigation
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.zero,
                  ),
                  child: Text(
                    'Skip',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontFamily: 'sf_Pro',
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.black,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 8.h),
            ],
          ),
        ),
      ),
    );
  }
}
