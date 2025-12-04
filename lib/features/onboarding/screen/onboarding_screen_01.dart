import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/core/widget/global_get_started_button.dart';
import 'package:workpleis/core/widget/global_logo.dart';
import 'package:workpleis/features/onboarding/screen/onboarding_screen_001.dart';
import 'package:workpleis/features/onboarding/screen/onboarding_screen_05.dart';

class OnboardingScreen01 extends StatefulWidget {
  const OnboardingScreen01({super.key});

  static const String routeName = '/onboarding_screen_01';

  @override
  State<OnboardingScreen01> createState() => _OnboardingScreen01State();
}

class _OnboardingScreen01State extends State<OnboardingScreen01> {
  @override
  void initState() {
    super.initState();

    // 3 seconds por RoleSelectionScreen e navigate
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      context.push(OnboardingScreen05.routeName);
    });
  }

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
                // Spacer(),
                const GlobalLogo(image: "assets/images/goloballogo.png"),
                // SizedBox(height: 15.h,),
                // const CircularProgressIndicator(color: Colors.black87,),

                // Text(
                //   "A SUSTAINABLE MARKETPLACE FOR BUSINESSES",
                //   style: TextStyle(
                //     fontSize: 12.sp, fontFamily: "OpenText", fontWeight: FontWeight.w400,color: AllColor.black
                //   ),
                // ),
                // Spacer(),
                // GlobalGetStartedButton(
                //   onTap: () {
                //   //  context.push(OnboardingScreen03.routeName);
                //     context.push(OnboardingScreen05.routeName);
                //   },
                // ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

