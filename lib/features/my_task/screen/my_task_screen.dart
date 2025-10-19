import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workpleis/core/widget/global_app_bar.dart';

import '../../home/widget/custom_category_type.dart';
import '../../home/widget/custom_filter_chips.dart';
import '../../home/widget/custom_job_posts.dart';
import '../../home/widget/custom_search_box_bottom.dart';
import '../widget/my_task_card.dart';
class MyTaskScreen extends StatelessWidget {
  const MyTaskScreen({super.key});
  static const routeName = '/myTaskScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppbar(text: "Browse Tasks"),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              SizedBox(height: 20.h),
              CustomSearchBoxBottom(),
              SizedBox(height: 10.h),
              CustomCategoryType(),
              SizedBox(height: 10.h),
              CustomFilterChips(),
              SizedBox(height: 15.h),
              // ===== Recent Job Posts =====
              CusotmMyTaskCard(),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}