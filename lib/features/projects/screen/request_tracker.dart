import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/core/widget/global_app_bar.dart';
import 'package:workpleis/features/message/screen/chat_screen.dart';


class RequestTrackerScreen extends StatelessWidget {
  const RequestTrackerScreen({super.key});
  static const routeName = "/requestTrackerScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppbar(text: "Request Tracker"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ProjectHeaderCard(),
            SizedBox(height: 20.h),
            const ProjectTimelineSection(),
            SizedBox(height: 20.h),
            const RecentUpdatesSection(),
            SizedBox(height: 20.h),
            const ProjectContactSection(),
          ],
        ),
      ),
    );
  }
}

/* ================= HEADER CARD ================= */
class ProjectHeaderCard extends StatelessWidget {
  const ProjectHeaderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AllColor.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AllColor.grey300, width: 1.w),
        
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.assignment, color: AllColor.black, size: 22.sp),
                  SizedBox(width: 8.w),
                  Text("Special Project Request",
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: AllColor.black)),
                ],
              ),
              Container(
                padding:
                EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AllColor.brand2_light ,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text("Under Review",
                    style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                        color: AllColor.white)),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text("Request ID: #30-AE-87",
              style: TextStyle(fontSize: 12.sp, color: AllColor.black)),
          SizedBox(height: 14.h),
          Text("Progress",
              style: TextStyle(fontSize: 11.sp, color: AllColor.black)),
          SizedBox(height: 6.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(6.r),
            child: LinearProgressIndicator(
              value: 0.5,
              backgroundColor: AllColor.grey300,
              color: AllColor.borderColor,
              minHeight: 8.h,
            ),
          ),
        ],
      ),
    );
  }
}

/* ================= TIMELINE ================= */
class ProjectTimelineSection extends StatelessWidget {
  const ProjectTimelineSection({super.key});

  @override
  Widget build(BuildContext context) {
    final steps = [
      {"title": "Submitted", "desc": "Request received and logged in our system", "done": true},
      {"title": "Submitted", "desc": "Request received and logged in our system", "done": true},
      {"title": "Proposal Sent", "desc": "Request received and logged in our system", "done": true},
      {"title": "In Progress", "desc": "Request received and logged in our system", "done": true},
      {"title": "Completed", "desc": "Request received and logged in our system", "done": false},
    ];

    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        border: Border.all(color: AllColor.grey300),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Project Timeline",
              style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AllColor.black)),
          SizedBox(height: 14.h),
          ...steps.map((s) => TimelineItem(
            title: s["title"]! as String,
            desc: s["desc"]! as String,
            isDone: s["done"] as bool,
          )),
        ],
      ),
    );
  }
}

class TimelineItem extends StatelessWidget {
  final String title;
  final String desc;
  final bool isDone;

  const TimelineItem({
    super.key,
    required this.title,
    required this.desc,
    required this.isDone,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            isDone ? Icons.check_circle : Icons.radio_button_unchecked,
            color: isDone ? AllColor.borderColor : AllColor.grey,
            size: 22.sp,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w300,
                        color: AllColor.black)),
                Text(desc,
                    style: TextStyle(fontSize: 12.sp, color: AllColor.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/* ================= RECENT UPDATES ================= */
class RecentUpdatesSection extends StatelessWidget {
  const RecentUpdatesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final updates = [
      {"name": "Jhon Doe", "msg": "has been assigned as your project specialist", "time": "2 hours ago"},
      {"name": "", "msg": "Initial requirements analysis completed", "time": "6 hours ago"},
      {"name": "", "msg": "Initial requirements analysis completed", "time": "6 hours ago"},
      {"name": "", "msg": "Your request has been received and entered our review queue", "time": "20 hours ago"},
    ];

    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        border: Border.all(color: AllColor.grey300),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Recent Updates",
              style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AllColor.black)),
          SizedBox(height: 14.h),
          ...updates.map((u) => UpdateItem(
            name: u["name"]!,
            msg: u["msg"]!,
            time: u["time"]!,
          )),
        ],
      ),
    );
  }
}

class UpdateItem extends StatelessWidget {
  final String name;
  final String msg;
  final String time;

  const UpdateItem({
    super.key,
    required this.name,
    required this.msg,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 18.r,
            backgroundColor: AllColor.grey200,
            child: name.isNotEmpty
                ? Text(name[0],
                style: TextStyle(fontSize: 14.sp, color: AllColor.black))
                : Icon(Icons.person, size: 18.sp, color: AllColor.grey),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: TextStyle(fontSize: 12.sp, color: AllColor.black),
                    children: [
                      if (name.isNotEmpty)
                        TextSpan(
                            text: "$name ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: msg),
                    ],
                  ),
                ),
                Text(time,
                    style: TextStyle(fontSize: 11.sp, color: AllColor.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/* ================= PROJECT CONTACT ================= */
class ProjectContactSection extends StatelessWidget {
  const ProjectContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        border: Border.all(color: AllColor.grey300),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22.r,
            backgroundColor: AllColor.grey200,
            child: Icon(Icons.person, color: AllColor.grey, size: 26.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Jhon Doe",
                    style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                        color: AllColor.black)),
                Text("Senior project Specialist",
                    style: TextStyle(fontSize: 12.sp, color: AllColor.grey)),
              ],
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AllColor.brand2_light ,
              padding:
              EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            onPressed: () {
               context.pop(context);
             context.push(ChatScreen.routeName);
            },
            
            //onPressed: () {context.push(ChatScreen.routeName,);},
            child: Text("Message",
                style: TextStyle(fontSize: 12.sp, color: AllColor.white)),
          )
        ],
      ),
    );
  }
}