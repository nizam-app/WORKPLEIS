import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/features/my_task/screen/applicants_screen.dart';

import '../../../core/constants/color_control/all_color.dart';
import '../../../core/widget/global_bottom.dart';
import '../../home/screen/job_details_screen.dart';

class CusotmMyTaskCard extends StatelessWidget {
  const CusotmMyTaskCard({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ Client এর নিজের পোস্ট করা job list
    final myJobs = [
      {
        "category": "Writing",
        "time": "1d ago",
        "icon": Icons.access_time,
        "title": "Content Writer Needed",
        "description": "Need 5 SEO-friendly blog posts (1500 words each).",
        "budget": "\$400 - \$600",
        "appliedCount": "8",
        "status": "Active"
      },
      {
        "category": "Marketing",
        "time": "2d ago",
        "icon": Icons.access_time,
        "title": "Facebook Ads Manager",
        "description": "Run & optimize ads for my e-commerce store.",
        "budget": "\$700",
        "appliedCount": "15",
        "status": "Closed"
      },
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: myJobs.length,
      itemBuilder: (context, index) {
        final job = myJobs[index];
        return _jobCard(
          category: job["category"] as String,
          time: job["time"] as String,
          icon: job["icon"] as IconData,
          title: job["title"] as String,
          description: job["description"] as String,
          budget: job["budget"] as String,
          appliedCount: job["appliedCount"] as String,
          status: job["status"] as String,
          context: context,
        );
      },
    );
  }

  Widget _jobCard({
    required String category,
    required String time,
    required IconData icon,
    required String title,
    required String description,
    required String budget,
    required String appliedCount,
    required String status,
    required BuildContext context,
  }) {
    return InkWell(
      onTap: () => context.push(JobDetailScreen.routeName),
      child: Container(
        margin: EdgeInsets.only(bottom: 14.h),
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          border: Border.all(color: AllColor.logoColor),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category + Time
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _tag(category),
                Row(
                  children: [
                    Icon(icon, size: 11.sp, color: AllColor.black87),
                    SizedBox(width: 4.w),
                    Text(
                      time,
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: AllColor.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 8.h),

            // Title
            Text(
              title,
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
                color: AllColor.black,
              ),
            ),
            SizedBox(height: 6.h),

            // Description
            Text(
              description,
              style: TextStyle(fontSize: 12.sp, color: AllColor.black87),
            ),
            SizedBox(height: 8.h),

            // Budget + Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  budget,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w800,
                    color: AllColor.black,
                  ),
                ),
                Container(
                  padding:
                  EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: status == "Active"
                        ? Colors.green.withOpacity(0.2)
                        : Colors.red.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: status == "Active" ? Colors.green : Colors.red,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.h),

            // Applied info
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.verified,
                        size: 14.sp, color: AllColor.logoColor),
                    SizedBox(width: 4.w),
                    Text(
                      "Payment verified",
                      style: TextStyle(fontSize: 10.sp, color: AllColor.black87),
                    ),
                  ],
                ),
                Text(
                  "$appliedCount applied",
                  style: TextStyle(fontSize: 11.sp, color: AllColor.black87),
                ),
              ],
            ),
            SizedBox(height: 15.h),

            // ✅ Client এর জন্য button
            GlobalButton(
              text: "View Applicants",
              onPressed: () {
                context.push(ApplicantsScreen.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _tag(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AllColor.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AllColor.logoColor, width: 2),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 11.sp, color: AllColor.black),
      ),
    );
  }
}