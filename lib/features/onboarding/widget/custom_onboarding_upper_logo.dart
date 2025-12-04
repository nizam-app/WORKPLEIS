import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workpleis/core/widget/global_logo.dart';

class CustomOnboardingUpperLogo extends StatelessWidget {
  const CustomOnboardingUpperLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 20.w),
      child: GlobalLogo(
     //   width: 120,

        height: 26,),
    );
  }
}
