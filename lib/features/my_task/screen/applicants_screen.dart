import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';

class ApplicantsScreen extends StatelessWidget {
  const ApplicantsScreen({super.key});
  static const routeName = "/applicantsScreen";

  @override
  Widget build(BuildContext context) {
    // ✅ Dummy Job Info
    final job = {
      "title": "UI/UX Designer Needed",
      "category": "Design",
      "budget": "\$500 - \$700",
      "time": "Posted 2h ago",
      "status": "Active",
      "description":
      "Looking for a skilled designer for a mobile app project. Must be familiar with Figma, prototyping, and responsive design."
    };

    // ✅ Dummy Applicants List
    final applicants = [
      {
        "name": "Asraful",
        "location": "Bangladesh",
        "rating": 4.5,
        "appliedTime": "1h ago",
        "bid": "\$550",
        "skills": "Figma, Flutter UI, Wireframes",
      },
      {
        "name": "Nizam",
        "location": "India",
        "rating": 4.8,
        "appliedTime": "3h ago",
        "bid": "\$600",
        "skills": "UX Research, Prototyping, Adobe XD",
      },
      {
        "name": "John Doe",
        "location": "USA",
        "rating": 4.2,
        "appliedTime": "5h ago",
        "bid": "\$500",
        "skills": "UI Design, Sketch, Animation",
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Applicants"),
        backgroundColor: AllColor.appBar, // Dark header color
        foregroundColor: AllColor.white, // Text & icons white
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Job Overview Card
            Container(
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                border: Border.all(color: AllColor.logoColor),
                borderRadius: BorderRadius.circular(12.r),
                color: AllColor.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(job["title"]!,
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: AllColor.black)),
                  SizedBox(height: 6.h),
                  Text(job["description"]!,
                      style: TextStyle(fontSize: 12.sp, color: AllColor.grey600)),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _jobTag(job["category"]!),
                      Text(job["time"]!,
                          style:
                          TextStyle(fontSize: 11.sp, color: AllColor.grey600)),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Budget: ${job["budget"]!}",
                          style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                              color: AllColor.black)),
                      Container(
                        padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: job["status"] == "Active"
                              ? AllColor.green.withOpacity(0.15)
                              : AllColor.red.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(job["status"]!,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: job["status"] == "Active"
                                  ? AllColor.green
                                  : AllColor.red,
                              fontWeight: FontWeight.w600,
                            )),
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 20.h),

            // 🔹 Applicants List
            Text("Applicants",
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AllColor.black)),
            SizedBox(height: 12.h),

            applicants.isEmpty
                ? _emptyState()
                : ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: applicants.length,
              itemBuilder: (context, index) {
                final applicant = applicants[index];
                return _applicantCard(applicant, context);
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _jobTag(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: AllColor.grey100,
      ),
      child: Text(text,
          style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
              color: AllColor.black)),
    );
  }

  Widget _applicantCard(Map<String, dynamic> applicant, BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 14.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        border: Border.all(color: AllColor.grey300),
        borderRadius: BorderRadius.circular(12.r),
        color: AllColor.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 Top Info (Avatar + Name + Location + Rating + Chat)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar
              CircleAvatar(
                radius: 24.r,
                backgroundColor: AllColor.logoColor.withOpacity(0.3),
                child: Text(applicant["name"]![0],
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp,
                        color: AllColor.black)),
              ),
              SizedBox(width: 10.w),

              // Name + Location
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(applicant["name"]!,
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: AllColor.black)),
                    SizedBox(height: 2.h),
                    Text(applicant["location"]!,
                        style: TextStyle(fontSize: 12.sp, color: AllColor.grey600)),
                  ],
                ),
              ),

              // Rating + Chat
              Column(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.orange, size: 16),
                      SizedBox(width: 2.w),
                      Text("${applicant["rating"]}",
                          style: TextStyle(fontSize: 12.sp, color: AllColor.black)),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      // 👉 এখানে Chat screen এ যাবে
                      // context.push(MessageScreen.routeName);
                    },
                    icon: Icon(Icons.chat_bubble_outline,
                        color: AllColor.appBar, size: 20.sp),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10.h),

          // 🔹 Skills
          Text("Skills: ${applicant["skills"]}",
              style: TextStyle(fontSize: 12.sp, color: AllColor.black87)),
          SizedBox(height: 6.h),

          // 🔹 Bid & Time
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Bid: ${applicant["bid"]}",
                  style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: AllColor.black)),
              Text(applicant["appliedTime"]!,
                  style: TextStyle(fontSize: 11.sp, color: AllColor.grey600)),
            ],
          ),
          SizedBox(height: 10.h),

          // 🔹 Action Buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // ✅ Accept logic
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AllColor.appBar,
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r)),
                  ),
                  child:
                  const Text("Accept", style: TextStyle(color: Colors.white)),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // ❌ Reject logic
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AllColor.red,
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r)),
                  ),
                  child:
                  const Text("Reject", style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }




  Widget _emptyState() {
    return Center(
      child: Column(
        children: [
          Icon(Icons.person_off, size: 60.sp, color: AllColor.grey600),
          SizedBox(height: 10.h),
          Text("No applicants yet",
              style: TextStyle(fontSize: 14.sp, color: AllColor.grey600)),
        ],
      ),
    );
  }
}