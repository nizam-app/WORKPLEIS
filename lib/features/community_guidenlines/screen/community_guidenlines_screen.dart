import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/core/widget/global_app_bar.dart';

class CommunityGuidenlinesScreen extends StatelessWidget {
  const CommunityGuidenlinesScreen({super.key});
  static const routeName = '/communityGuidenlinesScreen';

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: GlobalAppbar(text: "Community Guidelines"),
      body:SafeArea(
        child: Padding(
            padding: EdgeInsets.only(right: 15.h,left: 15.h, top: 15.h),
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                'Community Guidelines',
                style: theme.bodyMedium?.copyWith(
                    fontFamily: "bodyFont",fontSize: 24
                )
            ),
        
            SizedBox(height: 8.h),
        
            // 🔹 Subtitle
            Row(
              children: [
                Text(
                    "Community Guidelines Poster",
                    style: theme.bodyMedium
                ),
                Icon(Icons.keyboard_arrow_down ,size: 20,)
              ],
            ),
            SizedBox(height: 8.h),

            Row(
              children: [
                Text(
                    "Community Guidelines Tasker",
                    style: theme.bodyMedium
                ),
                Icon(Icons.keyboard_arrow_down ,size: 20, color: AllColor.brand2_light,)
              ],
            ),

          ],
        )),
      ) ,
    );
  }
}
