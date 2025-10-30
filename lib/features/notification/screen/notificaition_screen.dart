import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workpleis/core/widget/global_app_bar.dart';
import '../../../core/constants/color_control/all_color.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});
  static final routeName = "/notificationScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GlobalAppbar(text: "Notifications"),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  final item = notifications[index];
                  return NotificationTile(
                    title: item['title']!,
                    time: item['time']!,
                    isUnread: item['unread'] == 'true',
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class NotificationTile extends StatelessWidget {
  final String title;
  final String time;
  final bool isUnread;

  const NotificationTile({
    super.key,
    required this.title,
    required this.time,
    required this.isUnread,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h, top: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: isUnread ? AllColor.white : AllColor.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AllColor.black,
            blurRadius: 5.r,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Row(
        children: [
          // 🔹 Icon section
          CircleAvatar(
            backgroundColor: AllColor.brand2_light, // light lime bg
            radius: 24.r,
            child: Icon(Icons.notifications_none, color: AllColor.black),
          ),
          SizedBox(width: 12.w),

          // 🔹 Text section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: AllColor.black,
                    fontFamily: "headFont",
                    fontSize: 16.sp,

                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Learn more about managing account info and activity',
                  style: TextStyle(
                    color: AllColor.brand2_light,
                    fontSize: 12.sp,
                    fontFamily: "OpenText",
                    fontWeight: FontWeight.w400
                  ),
                )
              ],
            ),
          ),
          SizedBox(width: 8.w),

          // 🔹 Time + Unread Dot
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                time,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AllColor.grey,
                  fontWeight: FontWeight.w400,
                  fontFamily: "OpenText"
                ),
              ),
              SizedBox(height: 8.h),
              if (isUnread)
                CircleAvatar(
                  radius: 5.r,
                  backgroundColor: AllColor.black, // 🔹 brand color
                )
            ],
          )
        ],
      ),
    );
  }
}

final List<Map<String, String>> notifications = const [
  {
    'title': 'Reminder for your Night life',
    'time': '9min ago',
    'unread': 'true'
  },
  {
    'title': 'Reminder for your Dinner',
    'time': '13min ago',
    'unread': 'false'
  },
  {
    'title': 'Payment Method Added',
    'time': '20min ago',
    'unread': 'true'
  },
  {
    'title': 'Job Invitation from David',
    'time': '45min ago',
    'unread': 'false'
  },
];