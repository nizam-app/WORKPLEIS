import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';

import '../../../core/widget/global_app_bar.dart';

class SecurityScreen extends StatelessWidget {
  const SecurityScreen({super.key});
  static const routeName = '/securityScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:GlobalAppbar(text: "Security") ,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SecurityOverviewCard(),
            SizedBox(height: 20.h),
            Text("Security Settings",
                style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: AllColor.black)),
            SizedBox(height: 12.h),
            const SecuritySettingsList(),
            SizedBox(height: 20.h),
            Text("Security Tips",
                style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: AllColor.black)),
            SizedBox(height: 12.h),
            const SecurityTipsSection(),
          ],
        ),
      ),
    );
  }
}

/* ================= TOP CARD ================= */
class SecurityOverviewCard extends StatelessWidget {
  const SecurityOverviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AllColor.black,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Icon(Icons.verified_user, color: AllColor.green, size: 30.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Standard Security",
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AllColor.white)),
                SizedBox(height: 4.h),
                Text("Enhance your account security by enabling two-factor authentication.",
                    style: TextStyle(fontSize: 12.sp, color: AllColor.white70)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/* ================= SETTINGS LIST ================= */
class SecuritySettingsList extends StatelessWidget {
  const SecuritySettingsList({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = [
      {
        "icon": Icons.lock_outline,
        "title": "Password",
        "subtitle": "Last changed 3 month ago",
        "action": "Change"
      },
      {
        "icon": Icons.security,
        "title": "Two-Factor Authentication",
        "subtitle": "Add extra security to your account",
        "action": "Verify"
      },
    ];

    return Column(
      children: settings
          .map((s) => Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: AllColor.black,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Icon(s["icon"] as IconData,
                color: AllColor.white, size: 28.sp),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(s["title"] as String,
                      style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: AllColor.white)),
                  SizedBox(height: 4.h),
                  Text(s["subtitle"] as String,
                      style: TextStyle(
                          fontSize: 11.sp, color: AllColor.white70)),
                ],
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AllColor.white,
                padding: EdgeInsets.symmetric(
                    horizontal: 14.w, vertical: 8.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              onPressed: () {
                if (s['action'] == "Change") {
                  ChangePasswordBottomSheet.show(context);

                  
                }  
              },
              child: Text(s["action"] as String,
                  style: TextStyle(
                      fontSize: 12.sp, color: AllColor.black)),
            )
          ],
        ),
      ))
          .toList(),
    );
  }
}

/* ================= SECURITY TIPS ================= */
class SecurityTipsSection extends StatelessWidget {
  const SecurityTipsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final tips = [
      "Use a unique, strong password",
      "Enable two-factor authentication",
      "Regularly review your login sessions",
      "Never share your login credentials",
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: tips
          .map((t) => Padding(
        padding: EdgeInsets.only(bottom: 8.h),
        child: Row(
          children: [
            Icon(Icons.check, color: AllColor.green, size: 16.sp),
            SizedBox(width: 8.w),
            Expanded(
                child: Text(t,
                    style: TextStyle(
                        fontSize: 12.sp, color: AllColor.black))),
          ],
        ),
      ))
          .toList(),
    );
  }
}

class ChangePasswordBottomSheet {
  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (context) {
        return const _ChangePasswordForm();
      },
    );
  }
}

class _ChangePasswordForm extends StatefulWidget {
  const _ChangePasswordForm({super.key});

  @override
  State<_ChangePasswordForm> createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<_ChangePasswordForm> {
  final currentController = TextEditingController();
  final newController = TextEditingController();
  final confirmController = TextEditingController();

  bool currentVisible = false;
  bool newVisible = false;
  bool confirmVisible = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16.h,
        top: 16.h,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Change Password",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AllColor.black,
                ),
              ),
              IconButton(
                icon: Icon(Icons.close, color: AllColor.black),
                onPressed: () => Navigator.pop(context),
              )
            ],
          ),
          SizedBox(height: 6.h),

          Text(
            "Enter your current password and choose a new secure password",
            style: TextStyle(fontSize: 11.sp, color: AllColor.black87),
          ),
          SizedBox(height: 16.h),

          // Current Password
          _passwordField(
            controller: currentController,
            hint: "Enter current password",
            visible: currentVisible,
            onToggle: () => setState(() => currentVisible = !currentVisible),
          ),
          SizedBox(height: 14.h),

          // New Password
          _passwordField(
            controller: newController,
            hint: "New password",
            visible: newVisible,
            onToggle: () => setState(() => newVisible = !newVisible),
          ),
          SizedBox(height: 14.h),

          // Confirm Password
          _passwordField(
            controller: confirmController,
            hint: "Confirm your password",
            visible: confirmVisible,
            onToggle: () => setState(() => confirmVisible = !confirmVisible),
          ),
          SizedBox(height: 22.h),

          // Change Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AllColor.black,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              onPressed: () {
                // TODO: password update logic
              },
              child: Text(
                "Change Password",
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: AllColor.white,
                ),
              ),
            ),
          ),
          SizedBox(height: 12.h),

          // Cancel
          Center(
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "Cancel",
                style: TextStyle(fontSize: 12.sp, color: AllColor.black),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _passwordField({
    required TextEditingController controller,
    required String hint,
    required bool visible,
    required VoidCallback onToggle,
  }) {
    return TextField(
      controller: controller,
      obscureText: !visible,
      decoration: InputDecoration(
        hintText: hint,
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AllColor.green, width: 1.2),
          borderRadius: BorderRadius.circular(6.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AllColor.green, width: 1.5),
          borderRadius: BorderRadius.circular(6.r),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            visible ? Icons.visibility_off : Icons.visibility,
            color: AllColor.grey,
          ),
          onPressed: onToggle,
        ),
      ),
    );
  }
}
