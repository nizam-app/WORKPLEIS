import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/color_control/all_color.dart';
import '../../../core/widget/global_bottom.dart';
import '../screen/job_details_screen.dart';

class JobListScreen extends StatelessWidget {
  const JobListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final jobs = [
      {
        "category": "Design",
        "time": "2h ago",
        "icon": Icons.access_time,
        "title": "UI/UX Designer Needed",
        "description": "Looking for a skilled designer for a mobile app project.",
        "budget": "\$500 - \$700",
      },
      {
        "category": "Development",
        "time": "5h ago",
        "icon": Icons.access_time,
        "title": "Flutter Developer",
        "description": "Build a cross-platform app with Firebase backend.",
        "budget": "\$1200 - \$1500",
      },
      {
        "category": "Writing",
        "time": "1d ago",
        "icon": Icons.access_time,
        "title": "Content Writer",
        "description": "Need 10 SEO-friendly blog posts (1000 words each).",
        "budget": "\$300 - \$400",
      },
      {
        "category": "Marketing",
        "time": "2d ago",
        "icon": Icons.access_time,
        "title": "Social Media Manager",
        "description": "Manage IG & FB ads for 1 month campaign.",
        "budget": "\$800",
      },
      {
        "category": "Data Entry",
        "time": "3d ago",
        "icon": Icons.access_time,
        "title": "Data Entry Clerk",
        "description": "Transfer data from PDFs to Excel (500 entries).",
        "budget": "\$200 total budget",
      },
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
        itemCount: jobs.length,
        itemBuilder: (context, index) {
          final job = jobs[index];
          return _jobCard(
            category: job["category"] as String,
            time: job["time"] as String,
            icon: job["icon"] as IconData,
            title: job["title"] as String,
            description: job["description"] as String,
            budget: job["budget"] as String,
            context: context
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
    required BuildContext context,
  }) {
    return InkWell(
      onTap: (){context.push(JobDetailScreen.routeName);},
      child: Container(
        margin: EdgeInsets.only(bottom: 14.h), // spacing between cards
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
                      style: TextStyle(fontSize: 11.sp, color: AllColor.black,fontWeight: FontWeight.w400),
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

            // Budget
            Text(
              budget,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w800,
                color: AllColor.black,
              ),
            ),
            SizedBox(height: 15.h),

            // Bottom Info + Apply Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.location_on, size: 12.sp, color: AllColor.black),
                    SizedBox(width: 4.w),
                    Text("United States",
                        style: TextStyle(fontSize: 10.sp, color: AllColor.black87)),
                    SizedBox(width: 8.w),
                    Icon(Icons.home_work_outlined,
                        size: 14.sp, color: AllColor.black),
                    SizedBox(width: 4.w),
                    Text("Remote",
                        style: TextStyle(fontSize: 10.sp, color: AllColor.black87)),
                    SizedBox(width: 8.w),
                    Icon(Icons.verified, size: 14.sp, color: AllColor.logoColor),
                    SizedBox(width: 4.w),
                    Text("Payment verified",
                        style: TextStyle(fontSize: 10.sp, color: AllColor.black87)),
                  ],
                ),
                Text(
                  "12 applied",
                  style: TextStyle(fontSize: 11.sp, color: AllColor.black87),
                ),
              ],
            ),
            SizedBox(height: 15.h),

            // Apply Button
            GlobalButton(text: "Apply Now", onPressed: () {}),
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