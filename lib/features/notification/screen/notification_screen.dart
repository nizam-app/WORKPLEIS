import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});
  static const routeName = '/notificationScreen';

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool emailNotification = true;
  bool taskUpdates = false;
  bool messageNotification = false;
  bool pushNotification = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AllColor.white,
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              "Notification Preferences",
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AllColor.black,
              ),
            ),
            SizedBox(height: 20.h),

            // Cards
            _notificationTile(
              title: "Email Notifications",
              subtitle: "Receive updates via email",
              value: emailNotification,
              onChanged: (val) {
                setState(() => emailNotification = val);
              },
            ),
            SizedBox(height: 12.h),
            _notificationTile(
              title: "Task Updates",
              subtitle: "Updates about your tasks",
              value: taskUpdates,
              onChanged: (val) {
                setState(() => taskUpdates = val);
              },
            ),
            SizedBox(height: 12.h),
            _notificationTile(
              title: "Message Notifications",
              subtitle: "New messages and chat updates",
              value: messageNotification,
              onChanged: (val) {
                setState(() => messageNotification = val);
              },
            ),
            SizedBox(height: 12.h),
            _notificationTile(
              title: "Push Notifications",
              subtitle: "Receive instant via email",
              value: pushNotification,
              onChanged: (val) {
                setState(() => pushNotification = val);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _notificationTile({
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: AllColor.black,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Text Section
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: AllColor.white)),
              SizedBox(height: 4.h),
              Text(
                subtitle,
                style: TextStyle(
                    fontSize: 11.sp, color: AllColor.white.withOpacity(0.8)),
              ),
            ],
          ),

          // Switch
          Transform.scale(
            scale: 0.9,
            child: Switch(
              value: value,
              onChanged: onChanged,
              activeColor: AllColor.white,
              activeTrackColor: AllColor.green,
              inactiveThumbColor: AllColor.white,
              inactiveTrackColor: AllColor.grey300,
            ),
          ),
        ],
      ),
    );
  }
}
