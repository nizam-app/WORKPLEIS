
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/core/widget/global_app_bar.dart';

class SecurityGuideScreen extends StatefulWidget {
  const SecurityGuideScreen({super.key});
  static const routeName = '/securityGuideScreen';

  @override
  State<SecurityGuideScreen> createState() => _SecurityGuideScreenState();
}

class _SecurityGuideScreenState extends State<SecurityGuideScreen> {
  int selectedTab = 2; // 0=FAQ, 1=Contact, 2=Guide

  final guides = [
    {"icon": Icons.menu_book, "title": "Quick Start Guide", "subtitle": "3 sections"},
    {"icon": Icons.people_alt_outlined, "title": "For Posters", "subtitle": "3 sections"},
    {"icon": Icons.person_outline, "title": "For Taskers", "subtitle": "3 sections"},
    {"icon": Icons.shield_outlined, "title": "Safety Guidelines", "subtitle": "3 sections"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppbar(text: "Security"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /* ================= TOP CARD ================= */
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: AllColor.black,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                children: [
                  Icon(Icons.verified_user,
                      color: AllColor.green, size: 30.sp),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Help & Support",
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: AllColor.white)),
                        SizedBox(height: 4.h),
                        Text("Find answers, get help, and learn how to use workpleis",
                            style: TextStyle(
                                fontSize: 12.sp, color: AllColor.white70)),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20.h),

            /* ================= TABS ================= */
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _tabItem("FAQ", 0),
                _tabItem("Contact", 1),
                _tabItem("Guide", 2),
              ],
            ),

            SizedBox(height: 16.h),

            /* ================= SEARCH ================= */
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              decoration: BoxDecoration(
                border: Border.all(color: AllColor.grey300),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: AllColor.grey, size: 20.sp),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search frequently asked questions..",
                        hintStyle: TextStyle(
                            fontSize: 12.sp, color: AllColor.grey),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20.h),

            /* ================= GUIDE LIST ================= */
            ...guides.map((g) => Container(
              margin: EdgeInsets.only(bottom: 12.h),
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                color: AllColor.black,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                children: [
                  Icon(g["icon"] as IconData,
                      color: AllColor.white, size: 26.sp),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(g["title"] as String,
                            style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                                color: AllColor.white)),
                        SizedBox(height: 4.h),
                        Text(g["subtitle"] as String,
                            style: TextStyle(
                                fontSize: 11.sp, color: AllColor.white70)),
                      ],
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios,
                      color: AllColor.white, size: 16.sp),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _tabItem(String text, int index) {
    final isSelected = selectedTab == index;
    return GestureDetector(
      onTap: () => setState(() => selectedTab = index),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? AllColor.black : Colors.transparent,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
              color: isSelected ? AllColor.black : AllColor.grey300),
        ),
        child: Text(text,
            style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: isSelected ? AllColor.white : AllColor.black)),
      ),
    );
  }
}
