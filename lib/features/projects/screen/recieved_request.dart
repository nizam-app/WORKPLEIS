import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/features/projects/screen/request_tracker.dart';

class ReceivedRequest extends StatelessWidget {
  const ReceivedRequest({super.key});
  static const routeName = "/receivedRequest";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AllColor.white,
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Success Icon
            CircleAvatar(
              radius: 30.r,
              backgroundColor: AllColor.borderColor,
              child: Icon(Icons.check, size: 30.sp, color: AllColor.white),
            ),
            SizedBox(height: 20.h),

            // Title
            Text(
              "We’ve recieved your request!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color: AllColor.black,
              ),
            ),
            SizedBox(height: 8.h),

            // Subtitle
            Text(
              "Australia’s trusted marketplace connecting skilled Workpeers with people who need things done.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12.sp, color: AllColor.black87),
            ),
            SizedBox(height: 35.h),

            // Request Summary Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                border: Border.all(color: AllColor.borderColor),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _summaryRow("Project:", "Development"),
                  _summaryRow("Category:", "Specialized Procurement"),
                  _summaryRow("Budget:", "Under \$5000"),
                  _summaryRow("Request ID:", "#AS-2209-24"),
                ],
              ),
            ),
            SizedBox(height: 30.h),

            // Track Button
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
                 context.push(RequestTrackerScreen.routeName);
                },
                child: Text(
                  "Track My Request",
                  style: TextStyle(
                    fontSize: 14.sp,
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

  Widget _summaryRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(fontSize: 12.sp, color: AllColor.black87)),
          Text(
            value,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: AllColor.black,
            ),
          ),
        ],
      ),
    );
  }
}
