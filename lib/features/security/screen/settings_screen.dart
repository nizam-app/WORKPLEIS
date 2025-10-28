
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';

import '../../../core/widget/global_app_bar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  static const routeName = '/settingsScreen';
  @override
  Widget build(BuildContext context) {
    final theme = Theme
        .of(context)
        .textTheme;

    return Scaffold(
      backgroundColor: Colors.white70,
      appBar:GlobalAppbar(text: "Settings") ,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(" Security Settings",
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w800,
                    color: AllColor.black,
                  fontFamily: "headFont",


                )),
            SizedBox(height: 12.h),
             const SecuritySettingsList(),
            SizedBox(height: 10.h),
            Text("Notifications Settings ",
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w800,
                    color: AllColor.black,
                  fontFamily: "headFont"
                )),
            SizedBox(height: 12.h),
            ViaNotificationWidget(),
          ],
        ),
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
      // {
      //   "icon": Icons.security,
      //   "title": "Two-Factor Authentication",
      //   "subtitle": "Add extra security to your account",
      //   "action": "Verify"
      // },
    ];

    return Column(
      children: settings
          .map((s) => Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: AllColor.white,
          border: Border.all(color: AllColor.grey300, width: 1.w),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: AllColor.grey300,
              radius: 20.r,
              child: Icon(s["icon"] as IconData,
                  color: AllColor.white, size: 28.sp),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(s["title"] as String,
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: AllColor.black,
                        fontFamily: "OpenText"

                      )),
                  SizedBox(height: 4.h),
                  Text(s["subtitle"] as String,
                      style: TextStyle(
                          fontSize: 12.sp, color: AllColor.black, fontFamily: "OpenText", fontWeight: FontWeight.w400)),
                ],
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AllColor.primary,
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
                  style:TextStyle(
                      fontSize: 14.sp, color: AllColor.black,fontWeight: FontWeight.w400, fontFamily: "OpenText")),
            )
          ],
        ),
      ))
          .toList(),
    );
  }
}

/* ================= ChangePasswordBottomSheet ================= */


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
    final theme = Theme
        .of(context)
        .textTheme;

    return SingleChildScrollView(
      child: Padding(
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
                  style:TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w800,
                    color: AllColor.black,
                    fontFamily: "headFont"
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
              style: TextStyle(fontSize: 12.sp, color: AllColor.black, fontFamily: "OpenText", fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 10.h),
            Text(
              "Current Password",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w800,
                color: AllColor.black,
                fontFamily: "headFont"
              ),
            ),
            SizedBox(height: 10.h),
            // Current Password
            _passwordField(
              controller: currentController,
              hint: "Enter current password",
              visible: currentVisible,
              onToggle: () => setState(() => currentVisible = !currentVisible),
            ),
            SizedBox(height: 14.h),
            Text(
              "New Password",
              style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w800,
                  color: AllColor.black,
                  fontFamily: "headFont"
              ),
            ),
            SizedBox(height: 10.h),
      
            // New Password
            _passwordField(
              controller: newController,
              hint: "New password",
              visible: newVisible,
              onToggle: () => setState(() => newVisible = !newVisible),
            ),
            SizedBox(height: 14.h),
            Text(
              "Confirm New password",
              style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w800,
                  color: AllColor.black,
                  fontFamily: "headFont"
              ),
            ),
            SizedBox(height: 10.h),
      
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
                  backgroundColor: AllColor.primary,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                onPressed: () {
                  context.pop();
                },
                child: Text(
                  "Change Password",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AllColor.black,
                    fontFamily: "OpenText"
                  ),
                ),
              ),
            ),
            SizedBox(height: 12.h),
      
            // Cancel
            // Center(
            //   child: TextButton(
            //     onPressed: () => Navigator.pop(context),
            //     child: Text(
            //       "Cancel",
            //       style: TextStyle(fontSize: 12.sp, color: AllColor.black),
            //     ),
            //   ),
            // )
          ],
        ),
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
      //  contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
      //  enabledBorder: OutlineInputBorder(
      //     borderSide: BorderSide(color: AllColor.green, width: 1.2),
      //     borderRadius: BorderRadius.circular(6.r),
      //   ),
      //   focusedBorder: OutlineInputBorder(
      //     borderSide: BorderSide(color: AllColor.green, width: 1.5),
      //     borderRadius: BorderRadius.circular(6.r),
      //   ),
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

/* ================= Via Notifications ================= */
class ViaNotificationWidget extends StatefulWidget {
  const ViaNotificationWidget({super.key});

  @override
  State<ViaNotificationWidget> createState() => _ViaNotificationWidgetState();
}

class _ViaNotificationWidgetState extends State<ViaNotificationWidget> {
  bool emailNotification = true;
  bool taskUpdates = false;
  bool messageAlerts = true;
  bool pushNotification = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [



        // Notification Tiles
        _notificationTile(
          title: "Email Notifications",
          subtitle: "Receive updates via email",
          value: emailNotification,
          onChanged: (val) => setState(() => emailNotification = val),
          swtchCheck: true
        ),
        SizedBox(height: 12.h),

        _notificationTile(
          title: "Job Updates",
          subtitle: "Get updates about your ",
          value: taskUpdates,
          onChanged: (val) => setState(() => taskUpdates = val),
          swtchCheck: true
        ),
        SizedBox(height: 12.h),

        _notificationTile(
          title: "Message Notifications",
          subtitle: "New message and chat notifications",
          value: messageAlerts,
          onChanged: (val) => setState(() => messageAlerts = val),
        ),
        SizedBox(height: 12.h),

        _notificationTile(
          title: "Push Notifications",
          subtitle: " Receive Instant via email",
          value: pushNotification,
          onChanged: (val) => setState(() => pushNotification = val),
        ),
        SizedBox(height: 22.h),

        // Save button
      ],
    );
  }

  // 🔹 Notification Tile
  Widget _notificationTile({
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
    bool swtchCheck = false,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: AllColor.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AllColor.grey, width: 1.w),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Text Section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AllColor.black,
                      fontFamily: "OpenText"
                    )),
                SizedBox(height: 4.h),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AllColor.black,
                    fontFamily: "OpenTex",

                  ),
                ),
              ],
            ),
          ),
          // Switch
        if(swtchCheck==false)  Transform.scale(
            scale: 0.9,
            child: Switch(
              value: value,
              onChanged: onChanged,
              activeColor: AllColor.white,
              activeTrackColor: AllColor.primary,
              inactiveThumbColor: AllColor.white,
              inactiveTrackColor: AllColor.grey,
            ),
          ),
        ],
      ),
    );
  }
}


