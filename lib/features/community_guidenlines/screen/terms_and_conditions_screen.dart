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
              style: theme.bodyMedium?.copyWith(fontFamily: "bodyFont",fontSize: 26),
          ),

          SizedBox(height: 8.h),

          // 🔹 Subtitle
          Text(
              "Here are our terms and  conditions. Country Specific terms refer \n to Appendix B in this Agreement. Please contact us here if you have any other questions. Thanks for connecting. \n The Workpleis terms & conditions (updated 20 October 2025) outline Workpleis and  your obligationis and responsibilities on the Wrokpleis Platform. In this update to our Terms and Conditions, Workpleis has updated information related to clarifying the process required ( and timing related) when a Task is completed and payment is pending release by the poster. ",
              style: theme.bodyMedium
          ),
                      SizedBox(height: 8.h),
                      Text(
                        'User Workpleis: www.workpleis.com',
                        style: theme.bodyMedium?.copyWith(fontFamily: "bodyFont",fontSize: 26),
                      ),

                      SizedBox(height: 8.h),

                      Text(
                          "Workpleis operates an online platform allowing Users to connect through the Workpleis Plastorm with other Users who provide services.  ",
                          style: theme.bodyMedium
                      ),
                    ],
                  ),
        ),
      ) ,
    );
  }
}
