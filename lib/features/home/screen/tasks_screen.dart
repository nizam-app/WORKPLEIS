import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workpleis/core/widget/global_app_bar.dart';

import '../widget/custom_category_type.dart';
import '../widget/custom_filter_chips.dart';
import '../widget/custom_job_posts.dart';
import '../widget/custom_search_box_bottom.dart';
class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});
  static const routeName = '/tasksScreen';

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
              JobListScreen(),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
