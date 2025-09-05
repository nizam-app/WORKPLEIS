import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/core/widget/global_app_bar.dart';

class SecurityFAQScreen extends StatefulWidget {
  const SecurityFAQScreen({super.key});
  static const routeName = '/securityFAQScreen';

  @override
  State<SecurityFAQScreen> createState() => _SecurityFAQScreenState();
}

class _SecurityFAQScreenState extends State<SecurityFAQScreen> {
  int selectedTab = 0; // 0 = FAQ, 1 = Contact, 2 = Guide

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppbar(text: "Security"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            /* ================= TOP HELP CARD ================= */
            Container(
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                color: AllColor.black,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 18.r,
                    backgroundColor: AllColor.green.withOpacity(0.2),
                    child: Icon(Icons.verified_user,
                        size: 20.sp, color: AllColor.green),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Help & Support",
                            style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                                color: AllColor.white)),
                        SizedBox(height: 4.h),
                        Text(
                          "Find answers, get help, and learn how to use workpleis",
                          style: TextStyle(
                              fontSize: 11.sp,
                              color: AllColor.white.withOpacity(0.8)),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20.h),

            /* ================= TABS ================= */
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _tabItem("FAQ", 0),
                SizedBox(width: 12.w),
                _tabItem("Contact", 1),
                SizedBox(width: 12.w),
                _tabItem("Guide", 2),
              ],
            ),
            SizedBox(height: 20.h),

            /* ================= BODY CONTENT ================= */
            if (selectedTab == 0) const FAQ(),
            if (selectedTab == 1) const Contact(),
            if (selectedTab == 2) const Guide(),
          ],
        ),
      ),
    );
  }

  /* ============== Reusable Tab Item ============== */
  Widget _tabItem(String text, int index) {
    final isActive = selectedTab == index;
    return GestureDetector(
      onTap: () => setState(() => selectedTab = index),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isActive ? AllColor.black : AllColor.white,
          border: Border.all(
              color: isActive ? AllColor.black : AllColor.grey300),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: isActive ? AllColor.white : AllColor.black,
          ),
        ),
      ),
    );
  }
}

class FAQ extends StatelessWidget {
  const FAQ({super.key});

  @override
  Widget build(BuildContext context) {
    final faqItems = [
      {"icon": Icons.play_circle, "title": "Getting Started"},
      {"icon": Icons.payment, "title": "Task & Payments"},
      {"icon": Icons.shield, "title": "Safety & Trust"},
      {"icon": Icons.person, "title": "Account & Profile"},
    ];
    return  Column(
      children: [
        SizedBox(height: 20.h),

        // Search
        TextField(
          decoration: InputDecoration(
            hintText: "Search frequently asked questions..",
            hintStyle: TextStyle(fontSize: 12.sp, color: AllColor.grey),
            prefixIcon: Icon(Icons.search, color: AllColor.grey),
            contentPadding:
            EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: AllColor.green),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: AllColor.green),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: AllColor.green, width: 1.5),
            ),
          ),
        ),
        SizedBox(height: 20.h),

        // FAQ Items
        Column(
          children: faqItems
              .map((faq) => Container(
            margin: EdgeInsets.only(bottom: 12.h),
            padding: EdgeInsets.symmetric(
                horizontal: 14.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: AllColor.black,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(faq["icon"] as IconData,
                        color: AllColor.white, size: 18.sp),
                    SizedBox(width: 10.w),
                    Text(faq["title"].toString(),
                        style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            color: AllColor.white)),
                  ],
                ),
                Icon(Icons.keyboard_arrow_down,
                    color: AllColor.white, size: 20.sp),
              ],
            ),
          ))
              .toList(),
        )

      ],
    );
  }

}
class Contact extends StatefulWidget {
  const Contact({super.key});

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  String? selectedCategory = "Safety Concern";

  final categories = ["Safety Concern", "Payment Issue", "Other"];
  final subjectController = TextEditingController();
  final messageController = TextEditingController();

  int selectedTab = 1; // 0 = FAQ, 1 = Contact, 2 = Guide
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Send us a message",
          style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AllColor.black),
        ),
        SizedBox(height: 20.h),

        // Category Dropdown
        _label("Category"),
        _dropdownField(
          value: selectedCategory,
          hint: "Select category",
          options: categories,
          onChanged: (val) => setState(() => selectedCategory = val),
        ),
        SizedBox(height: 16.h),

        // Subject
        _label("Subject"),
        _inputField(subjectController, hint: "Brief description of your issue"),
        SizedBox(height: 16.h),

        // Message
        _label("Message"),
        _inputField(messageController,
            hint: "please provide as much detail as possible...", maxLines: 4),
        SizedBox(height: 30.h),

        // Send Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: AllColor.black,
              padding: EdgeInsets.symmetric(vertical: 14.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            onPressed: () {
              // TODO: send message
            },
            icon: Icon(Icons.send, size: 16.sp, color: AllColor.white),
            label: Text(
              "Send Message",
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: AllColor.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _label(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(bottom: 6.h),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: AllColor.black,
          ),
        ),
      ),
    );
  }

  Widget _dropdownField({
    required String? value,
    required String hint,
    required List<String> options,
    required Function(String?) onChanged,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        border: Border.all(color: AllColor.green, width: 1.2),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: Text(hint,
              style: TextStyle(fontSize: 13.sp, color: AllColor.grey)),
          isExpanded: true,
          icon: Icon(Icons.keyboard_arrow_down, color: AllColor.black),
          dropdownColor: AllColor.black,
          style: TextStyle(fontSize: 13.sp, color: AllColor.white),
          onChanged: onChanged,
          items: options
              .map((opt) => DropdownMenuItem(
            value: opt,
            child: Text(opt,
                style: TextStyle(fontSize: 13.sp, color: AllColor.white)),
          ))
              .toList(),
        ),
      ),
    );
  }
  Widget _inputField(TextEditingController controller,
      {required String hint, int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(fontSize: 12.sp, color: AllColor.grey),
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AllColor.green, width: 1.2),
          borderRadius: BorderRadius.circular(6.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AllColor.green, width: 1.5),
          borderRadius: BorderRadius.circular(6.r),
        ),
      ),
    );
  }
}
class Guide extends StatelessWidget {
  const Guide({super.key});

  @override
  Widget build(BuildContext context) {
    final guides = [
      {"icon": Icons.menu_book, "title": "Quick Start Guide", "subtitle": "3 sections"},
      {"icon": Icons.people_alt_outlined, "title": "For Posters", "subtitle": "3 sections"},
      {"icon": Icons.person_outline, "title": "For Taskers", "subtitle": "3 sections"},
      {"icon": Icons.shield_outlined, "title": "Safety Guidelines", "subtitle": "3 sections"},
    ];
    return Column(
      children: [
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
    );
  }

}
