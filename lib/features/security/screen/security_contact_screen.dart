import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/core/widget/global_app_bar.dart';

class SecurityContactScreen extends StatefulWidget {
  const SecurityContactScreen({super.key});
  static const routeName = '/securityContactScreen';

  @override
  State<SecurityContactScreen> createState() =>
      _SecurityContactScreenState();
}

class _SecurityContactScreenState extends State<SecurityContactScreen> {
  String? selectedCategory = "Safety Concern";

  final categories = ["Safety Concern", "Payment Issue", "Other"];
  final subjectController = TextEditingController();
  final messageController = TextEditingController();

  int selectedTab = 1; // 0 = FAQ, 1 = Contact, 2 = Guide

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: GlobalAppbar(text: "Help & Support"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Top Help Card
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
                        Text("Find answers, get help, and learn how to use workpleis",
                            style: TextStyle(
                                fontSize: 11.sp,
                                color: AllColor.white.withOpacity(0.8))),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20.h),

            // Tabs
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

            // Title
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
        ),
      ),
    );
  }

  /* ================= Reusable ================= */

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
}
