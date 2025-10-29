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
            // const RecentUpdatesSection(),
            // SizedBox(height: 20.h),
            // const ProjectContactSection(),
          ],
        ),
      ),
    );
  }
}

class ProjectHeaderCard extends StatelessWidget {
  final double progressPercent;

  const ProjectHeaderCard({super.key, this.progressPercent = 0.45});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final progress = (progressPercent * 100).toInt();

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AllColor.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AllColor.grey300, width: 0.8.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Top Row: Icon + Title + Status Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8.r),
                    decoration: BoxDecoration(
                      color: AllColor.grey300,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(
                      Icons.rocket_launch_outlined,
                      size: 20.sp,
                      color: AllColor.white,
                    ),
                  ),
                  8.horizontalSpace,
                  Text(
                    "Special Project",
                    style:TextStyle(
                      fontSize: 16.h,
                      color: AllColor.black87,
                      fontWeight: FontWeight.w800,
                      fontFamily: "headFont"
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: AllColor.primary,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Text(
                  "in progress",
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AllColor.black,
                    fontWeight: FontWeight.w400,
                    fontFamily: "OpenText"
                  ),
                ),
              ),
            ],
          ),

          4.verticalSpace,
              Padding(
                padding:  EdgeInsets.only(right: 35.w, left: 40.w),
                child: Text(
                  "Title ",
                  style: TextStyle(color: AllColor.black, fontFamily: "OpenText", fontWeight: FontWeight.w400, fontSize: 14.sp),
                ),
              ),
              6.verticalSpace,
              Padding(
                padding:  EdgeInsets.only(right: 35.w, left: 40.w),
                child: Text(
                  "Progress",
                  style: TextStyle(fontSize: 12.sp, fontFamily: "OpenText", fontWeight: FontWeight.w400, color: AllColor.black87),
                ),
              ),


          /// Progress Label + Bar

          6.verticalSpace,
          Padding(
            padding:  EdgeInsets.only(right: 35.w, left: 40.w),
            child: Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6.r),
                    child: LinearProgressIndicator(
                      value: progressPercent,
                      backgroundColor: AllColor.grey300,
                      color: AllColor.primary,
                      minHeight: 5.h,
                    ),
                  ),
                ),
                8.horizontalSpace,
                Text(
                  "$progress%",
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    fontFamily: "OpenText "
                  ),
                ),
              ],
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
      {
        "title": "Submitted",
        "desc": "Your request has been successfully submitted and recorded in our system.",
        "done": true,
      },
      {
        "title": "Proposal Sent",
        "desc": "Our team has reviewed your request and a proposal has been prepared and shared with you",
        "done": true,
      },
      {
        "title": "In Progress",
        "desc": "Work on your project has started, and our team is actively making progress toward completion.",
        "done": true,
      },
      {
        "title": "Completed",
        "desc": "The project has been successfully completed. please review you project.",
        "done": true,
      },
      {
        "title": "In Review",
        "desc": "WThe project has been reviewed by client",
        "done": true,
      },
      {
        "title": "Delivered",
        "desc": "Project has been delivered and accepted by client.",
        "done": false,
      },
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
          Text(
            "Project Timeline",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: AllColor.black,
              fontFamily: "headFont",
            ),
          ),
          SizedBox(height: 14.h),
          ...steps.map(
            (s) => TimelineItem(
              title: s["title"]! as String,
              desc: s["desc"]! as String,
              isDone: s["done"] as bool,
            ),
          ),
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
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            isDone ? Icons.check_circle : Icons.radio_button_unchecked,
            color: isDone ? AllColor.primary : AllColor.black,
            size: 22.sp,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AllColor.black,
                    fontFamily: "OpenText"
                  ),
                ),
                Text(
                  desc,
                  style: TextStyle(fontSize: 12.sp, color: AllColor.black, fontWeight: FontWeight.w400, fontFamily: "OpenText"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/* ================= RECENT UPDATES ================= */
// class RecentUpdatesSection extends StatelessWidget {
//   const RecentUpdatesSection({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final updates = [
//       {
//         "name": "Jhon Doe",
//         "msg": "has been assigned as your project specialist",
//         "time": "2 hours ago",
//       },
//       {
//         "name": "",
//         "msg": "Initial requirements analysis completed",
//         "time": "6 hours ago",
//       },
//       {
//         "name": "",
//         "msg": "Initial requirements analysis completed",
//         "time": "6 hours ago",
//       },
//       {
//         "name": "",
//         "msg": "Your request has been received and entered our review queue",
//         "time": "20 hours ago",
//       },
//     ];
//
//     return Container(
//       padding: EdgeInsets.all(14.w),
//       decoration: BoxDecoration(
//         border: Border.all(color: AllColor.grey300),
//         borderRadius: BorderRadius.circular(12.r),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "Recent Updates",
//             style: TextStyle(
//               fontSize: 14.sp,
//               fontWeight: FontWeight.w400,
//               color: AllColor.black,
//             ),
//           ),
//           SizedBox(height: 14.h),
//           ...updates.map(
//             (u) =>
//                 UpdateItem(name: u["name"]!, msg: u["msg"]!, time: u["time"]!),
//           ),
//         ],
//       ),
//     );
//   }
// }

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
                ? Text(
                    name[0],
                    style: TextStyle(fontSize: 14.sp, color: AllColor.black),
                  )
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
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      TextSpan(text: msg),
                    ],
                  ),
                ),
                Text(
                  time,
                  style: TextStyle(fontSize: 11.sp, color: AllColor.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}




/* ================= PROJECT CONTACT ================= */
// class ProjectContactSection extends StatelessWidget {
//   const ProjectContactSection({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(14.w),
//       decoration: BoxDecoration(
//         border: Border.all(color: AllColor.grey300),
//         borderRadius: BorderRadius.circular(12.r),
//       ),
//       child: Row(
//         children: [
//           CircleAvatar(
//             radius: 22.r,
//             backgroundColor: AllColor.grey200,
//             child: Icon(Icons.person, color: AllColor.grey, size: 26.sp),
//           ),
//           SizedBox(width: 12.w),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Jhon Doe",
//                   style: TextStyle(
//                     fontSize: 13.sp,
//                     fontWeight: FontWeight.w400,
//                     color: AllColor.black,
//                   ),
//                 ),
//                 Text(
//                   "Senior project Specialist",
//                   style: TextStyle(fontSize: 12.sp, color: AllColor.grey),
//                 ),
//               ],
//             ),
//           ),
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               backgroundColor: AllColor.brand2_light,
//               padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8.r),
//               ),
//             ),
//             onPressed: () {
//               context.pop(context);
//               context.push(ChatScreen.routeName);
//             },
//
//             //onPressed: () {context.push(ChatScreen.routeName,);},
//             child: Text(
//               "Message",
//               style: TextStyle(fontSize: 12.sp, color: AllColor.white),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
