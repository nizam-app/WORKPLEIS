import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/core/widget/global_get_started_button.dart';
import 'package:workpleis/core/widget/global_logo.dart';
import 'package:workpleis/features/onboarding/screen/onboarding_screen_02.dart';

class OnboardingScreen01 extends StatelessWidget {
  const OnboardingScreen01({super.key});
  static const String routeName = '/onboarding_screen_01';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AllColor.primary,
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 20.w),
          child: Center(
            child:Column(
                mainAxisSize: MainAxisSize.min,
              children: [
                Spacer(),
                const GlobalLogo(),
                Text("A SUSTAINABLE MARKETPLACE FOR BUSINESSES",style: Theme.of(context).textTheme.headlineSmall,),
                Spacer(),
                GlobalGetStartedButton(onTap: (){context.push(OnboardingScreen02.routeName);},),
                SizedBox(height: 80.h,)
              ],
            )),
        ),
      )
    );
  }
}
