import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/core/widget/global_get_started_button.dart';
import 'package:workpleis/core/widget/global_logo.dart';
import 'package:workpleis/features/onboarding/screen/onboarding_screen_001.dart';

class OnboardingScreen01 extends StatelessWidget {
  const OnboardingScreen01({super.key});

  static const String routeName = '/onboarding_screen_01';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AllColor.primary,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(),
                const GlobalLogo(image: "assets/images/workpleis1.png"),
                SizedBox(height: 5.h),
                Text(
                  "A SUSTAINABLE MARKETPLACE FOR BUSINESSES",
                  style: TextStyle(
                    fontSize: 9.sp, fontFamily: "OpenText", fontWeight: FontWeight.w400,
                  ),
                ),
                Spacer(),
                GlobalGetStartedButton(
                  onTap: () {
                    context.push(OnboardingScreen03.routeName);
                  },
                ),
                SizedBox(height: 75.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
