import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workpleis/core/widget/global_app_bar.dart';

import '../widget/custom_category_type.dart';
import '../widget/custom_filter_chips.dart';
import '../widget/custom_job_posts.dart';
import '../widget/custom_search_box_bottom.dart';
import 'Service_home_screen.dart';
class SeeAllJobsScreen extends StatelessWidget {
  const SeeAllJobsScreen({super.key});
  static const routeName = '/seeAllJobsScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppbar(text: "Browse Jobs"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  SizedBox(height: 20.h),
                  CustomSearchBoxBottom(),
                  SizedBox(height: 10.h),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 5.w),
                    child: CustomCategoryType(checkSeeButton: true,),
                  ),
                  SizedBox(height: 10.h),

                ],
              ),
            ),

          CustomJobListScreen(),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
