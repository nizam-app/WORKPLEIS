import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workpleis/core/widget/global_app_bar.dart';

class CommunityGuidenlinesScreen extends StatelessWidget {
  const CommunityGuidenlinesScreen({super.key});
  static const routeName = '/communityGuidenlinesScreen';

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: GlobalAppbar(text: "Community Guidelines"),
      body:SafeArea(child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30.h,),
          Text(
              'Community Guidelines',
              style: theme.bodySmall
          ),

          SizedBox(height: 8.h),

          // 🔹 Subtitle
          Text(
              "We’ll send you a one time code to verify your email.",
              style: theme.bodyMedium
          ),
        ],
      )) ,
    );
  }
}
