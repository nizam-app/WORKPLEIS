import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workpleis/core/widget/global_app_bar.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});
  static const routeName = '/privacyPolicyScreen';

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: GlobalAppbar(text: "Privacy Policy"),
      body:SafeArea(
        child: Padding(
            padding: EdgeInsets.only(right: 15.h,left: 15.h, top: 15.h),
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              'Privacy Policy',
                style: theme.bodyMedium?.copyWith(
                    fontFamily: "bodyFont",fontSize: 24
                )
            ),

            SizedBox(height: 8.h),

            // 🔹 Subtitle
            Text(
              "We’ll send you a one time code to verify your email.",
              style: theme.bodyMedium
            ),
          ],
        )),
      ) ,
    );
  }
}
