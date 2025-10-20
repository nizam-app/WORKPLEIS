import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workpleis/core/widget/global_app_bar.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});
  static const routeName = '/termsAndConditionsScreen';

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: GlobalAppbar(text: "Team and conditions"),
      body:SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(right: 15.h,left: 15.h, top: 15.h),
          child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
          Text(
              'Terms and Conditions',
              style: theme.bodyMedium?.copyWith(fontFamily: "bodyFont",fontSize: 28),
          ),

          SizedBox(height: 8.h),

          // 🔹 Subtitle
          Text(
              "We’ll send you a one time code to verify your email.",
              style: theme.bodyMedium
          ),
                    ],
                  ),
        ),
      ) ,
    );
  }
}
