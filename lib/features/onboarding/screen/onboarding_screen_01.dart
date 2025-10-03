import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/core/widget/global_logo.dart';

class OnboardingScreen01 extends StatelessWidget {
  const OnboardingScreen01({super.key});
  static const String routeName = '/onboarding_screen_01';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AllColor.primary,
      body: SafeArea(
        child: Center(
          child:Column(
      mainAxisSize: MainAxisSize.min,
            children: [
              const GlobalLogo(),
              Text("A SUSTAINABLE MARKETPLACE FOR BUSINESSES",style: Theme.of(context).textTheme.headlineSmall,),
              Container(
                width: 320.w,   // responsive width
                height: 60.h,  // responsive height
                decoration: BoxDecoration(
                  color:AllColor.white, // neon green background
                  borderRadius: BorderRadius.circular(12.r), // rounded corners
                ),
                child: Center(
                  child: Text(
                    "Get Started",
                    style: TextStyle(
                      fontSize: 18.sp,   // responsive font
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          )),
      )
    );
  }
}
