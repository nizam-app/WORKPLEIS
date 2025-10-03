
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workpleis/core/widget/global_logo.dart';
import 'package:workpleis/features/onboarding/widget/custom_onboarding_upper_logo.dart';

class OnboardingScreen02 extends StatelessWidget {
  const OnboardingScreen02({super.key});

  static const String routeName = '/onboarding_screen_02';

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    return Scaffold(body: SafeArea(child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10.h,),
        CustomOnboardingUpperLogo(),
        SizedBox(height: 50.h,),
        Image.asset("assets/images/Onboardin02.png", width: double.infinity,),
        SizedBox(height: 30.h,),
        buildColumn(theme),
        

      ],
    )));
  }

  Column buildColumn(TextTheme theme) {
    return Column(
      mainAxisSize: MainAxisSize.max,
        children: [
          Center(child: Text("Team up For Success",style: theme.bodySmall,)),
          SizedBox(height: 5.h,),
          Text("Get ready to unleash your potential and \n"
              " witness the power of teamwork",textAlign: TextAlign.center,style: TextStyle(fontFamily: "bodyFont",),)
        ],
      );
  }
}
