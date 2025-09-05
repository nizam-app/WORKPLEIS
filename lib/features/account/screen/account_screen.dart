import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/core/widget/global_app_bar.dart';

import '../../home/widget/custom_job_posts.dart';
class AccountOverviewScreen extends StatelessWidget {
  const AccountOverviewScreen({super.key});
  static const routeName = "/accountOverviewScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppbar(text: "Account"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const ProfileHeaderSection(),
            SizedBox(height: 20.h),
            const AccountStatsSection(),
            SizedBox(height: 20.h),
            const ExtraStatsSection(),
            SizedBox(height: 20.h),
            const ToggleModeSection(),
            SizedBox(height: 20.h),
            const SkillsSection(),
            SizedBox(height: 20.h),
            CustomApplicationsBar(),
            SizedBox(height: 20.h),
            JobListScreen(),
            SizedBox(height: 20.h),
            RecentTasksSection(),
            SizedBox(height: 20.h),
            SignOutSection(),
            SizedBox(height: 20.h),


          ],
        ),
      ),
    );
  }
}

/* ================= PROFILE HEADER ================= */
class ProfileHeaderSection extends StatelessWidget {
  const ProfileHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AllColor.appBar, // dark header bg
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28.r,
            backgroundColor: AllColor.grey200,
            child: Icon(Icons.person, size: 36.sp, color: AllColor.black),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("jhon@example.com",
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AllColor.white)),
                SizedBox(height: 6.h),
                Container(
                  padding:
                  EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: AllColor.logoColor,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    "Job seeker",
                    style: TextStyle(
                        fontSize: 11.sp,
                        color: AllColor.black,
                        fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/* ================= ACCOUNT STATS ================= */
class AccountStatsSection extends StatelessWidget {
  const AccountStatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final stats = [
      {"title": "28", "subtitle": "Task Completed"},
      {"title": "⭐ 4.8", "subtitle": "Rating"},
      {"title": "\$2390", "subtitle": "Total Earned"},
      {"title": "100%", "subtitle": "Success Rate"},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 2.3),
      itemCount: stats.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.all(6.w),
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: AllColor.appBar,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(stats[index]["title"]!,
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: AllColor.logoColor)),
              Text(stats[index]["subtitle"]!,
                  style: TextStyle(fontSize: 12.sp, color: AllColor.white)),
            ],
          ),
        );
      },
    );
  }
}

/* ================= EXTRA STATS ================= */
class ExtraStatsSection extends StatelessWidget {
  const ExtraStatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 20.w,
          children: [
            _extraItem(Icons.group, "Repeat Clients"),
            _extraItem(Icons.access_time, "Avg Response"),
          ],
        ),
        SizedBox(height: 14.h),
        Text(
          "Member since March 2023",
          style: TextStyle(
            fontSize: 12.sp,
            color: AllColor.grey,
          ),
        ),
      ],
    );
  }

  Widget _extraItem(IconData icon, String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AllColor.logoColor,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20.sp, color: AllColor.black),
          SizedBox(width: 8.w),
          Text(
            text,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: AllColor.black,
            ),
          ),
        ],
      ),
    );
  }
}


/* ================= TOGGLE MODE ================= */
class ToggleModeSection extends StatelessWidget {
  const ToggleModeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Text(
          "Testing Mode",
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: AllColor.black,
          ),
        ),
        SizedBox(height: 8.h),

        // Switch Row
        Row(
          children: [
            Transform.scale(
              scale: 0.9, // একটু ছোট switch
              child: Switch(
                value: false,
                activeColor: AllColor.white,
                activeTrackColor: AllColor.black,
                inactiveThumbColor: AllColor.white,
                inactiveTrackColor: AllColor.grey300,
                onChanged: (v) {},
              ),
            ),
            SizedBox(width: 10.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Switch to Poster View",
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: AllColor.black,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  "Currently viewing as Tasker",
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: AllColor.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}


/* ================= SKILLS ================= */
class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final skills = [
      "Home Cleaning",
      "Furniture Assembly",
      "Move & Delivery",
      "Gardening",
      "Handyman Services"
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Skills & Services",
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600)),
        SizedBox(height: 10.h),
        Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: [
            ...skills.map((s) => Container(
              padding:
              EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: AllColor.black,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(s,
                  style: TextStyle(
                      fontSize: 11.sp, color: AllColor.white)),
            )),
            Container(
              padding:
              EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                border: Border.all(color: AllColor.logoColor),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text("+ Add Skill",
                  style: TextStyle(
                      fontSize: 11.sp, color: AllColor.logoColor)),
            ),
          ],
        ),
      ],
    );
  }
}


/* ================= APPLICATIONS ================= */


class ApplicationCard extends StatelessWidget {
  final String category;
  final String title;
  final String budget;
  final String posted;
  final String deadline;

  const ApplicationCard(
      {super.key,
        required this.category,
        required this.title,
        required this.budget,
        required this.posted,
        required this.deadline});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        border: Border.all(color: AllColor.logoColor),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: AllColor.logoColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Text(category,
                style: TextStyle(fontSize: 10.sp, color: AllColor.black)),
          ),
          SizedBox(height: 6.h),
          Text(title,
              style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                  color: AllColor.black)),
          SizedBox(height: 4.h),
          Text("$budget • $posted • $deadline",
              style: TextStyle(fontSize: 11.sp, color: AllColor.black87)),
        ],
      ),
    );
  }
}

/* ================= RECENT TASKS ================= */
class RecentTasksSection extends StatelessWidget {
  const RecentTasksSection({super.key});

  @override
  Widget build(BuildContext context) {
    final tasks = [
      {"title": "E-commerce Website Development", "status": "Completed"},
      {"title": "Mobile App UI Design", "status": "In Process"},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Recent Tasks",
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600)),
        SizedBox(height: 10.h),
        ...tasks.map((t) => Container(
          margin: EdgeInsets.only(bottom: 8.h),
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          decoration: BoxDecoration(
            border: Border.all(color: AllColor.grey300),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(t["title"]!,
                    style:
                    TextStyle(fontSize: 12.sp, color: AllColor.black)),
              ),
              Container(
                padding:
                EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: t["status"] == "Completed"
                      ? AllColor.logoColor.withOpacity(0.2)
                      : AllColor.orange.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(t["status"]!,
                    style: TextStyle(fontSize: 11.sp, color: AllColor.black)),
              )
            ],
          ),
        ))
      ],
    );
  }
}

/* ================= SIGN OUT ================= */
class SignOutSection extends StatelessWidget {
  const SignOutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AllColor.red,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 30.w),
      ),
      onPressed: () {},
      child: Text("Sign out",
          style: TextStyle(color: AllColor.white, fontSize: 13.sp)),
    );
  }
}


class CustomApplicationsBar extends StatefulWidget {
  const CustomApplicationsBar({super.key});

  @override
  State<CustomApplicationsBar> createState() => _CustomApplicationsBarState();
}

class _CustomApplicationsBarState extends State<CustomApplicationsBar> {
  String selectedTab = "Pending";
  final tabs = ["Pending", "Accepted", "In Progress", "Interviewing"];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "My Applications",
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AllColor.black,
              ),
            ),
            Text(
              "8 total",
              style: TextStyle(
                fontSize: 12.sp,
                color: AllColor.grey,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),

        // Horizontal Scroll Tabs
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: tabs.map((tab) {
              final isSelected = selectedTab == tab;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedTab = tab;
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(right: 8.w),
                  padding:
                  EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AllColor.logoColor
                        : AllColor.white,
                    border: Border.all(
                      color: isSelected
                          ? AllColor.logoColor
                          : AllColor.grey300,
                    ),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    tab,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: AllColor.black,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
