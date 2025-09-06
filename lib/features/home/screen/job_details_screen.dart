import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/core/widget/global_app_bar.dart';

import '../../../core/widget/global_bottom.dart';

class JobDetailScreen extends StatelessWidget {
  const JobDetailScreen({super.key});
  static const routeName = "/job-detail";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppbar(text: "Job Details"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            JobHeaderSection(),
            SizedBox(height: 16),
            JobDetailsSection(),
            SizedBox(height: 16),
            AboutJobSection(),
            SizedBox(height: 16),
            JobLocationSection(),
            SizedBox(height: 16),
            SecurePaymentBox(),
            SizedBox(height: 30),
            ApplyButtonSection(),
          ],
        ),
      ),
    );
  }
}

/* ========================= JOB HEADER ========================= */
class JobHeaderSection extends StatelessWidget {
  const JobHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title + Price
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                "Deep house cleaning service needed",
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w600,
                  color: AllColor.black,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "\$500",
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                    color: AllColor.black,
                  ),
                ),
                Text(
                  "Fixed",
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AllColor.black87,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            Icon(Icons.access_time, size: 14.sp, color: AllColor.black87),
            SizedBox(width: 4.w),
            Text("Posted 2h ago",
                style: TextStyle(fontSize: 12.sp, color: AllColor.black87,fontWeight: FontWeight.w400)),
            SizedBox(width: 14.w),
            Icon(Icons.group, size: 14.sp, color: AllColor.black87),
            SizedBox(width: 4.w),
            Text("12 applied",
                style: TextStyle(fontSize: 11.sp, color: AllColor.black87)),
            SizedBox(width: 14.w),
            Icon(Icons.star, size: 14.sp, color: AllColor.logoColor),
            SizedBox(width: 4.w),
            Text("4.9",
                style: TextStyle(fontSize: 11.sp, color: AllColor.logoColor)),
          ],
        ),
      ],
    );
  }
}

/* ========================= JOB DETAILS ========================= */
class JobDetailsSection extends StatelessWidget {
  const JobDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AllColor.grey100,
        border: Border.all(color: AllColor.logoColor),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Job Details",
              style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: AllColor.black)),
          SizedBox(height: 8.h),
          _detailRow("Project Type", "One-time"),
          _detailRow("Experience Level", "Intermediate"),
          _detailRow("Timeline", "2-4days"),
          _detailRow("Urgency", "Urgent"),
        ],
      ),
    );
  }

  Widget _detailRow(String key, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3.h),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              "$key :",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: AllColor.black,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(fontSize: 16.sp, color: AllColor.black87,fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }
}

/* ========================= ABOUT JOB ========================= */
class AboutJobSection extends StatelessWidget {
  const AboutJobSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "About This Job",
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.w500,
            color: AllColor.black,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          "Looking for experienced cleaner for weekly deep cleaning of modern 3-bedroom house near Bondi Beach. Includes kitchen deep clean, bathroom sanitizing, living areas, and window cleaning. Must bring own eco-friendly supplies and equipment.",
          style: TextStyle(fontSize: 14.sp, color: AllColor.black87),
        ),
      ],
    );
  }
}

/* ========================= LOCATION ========================= */
class JobLocationSection extends StatelessWidget {
  const JobLocationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.location_on, size: 14.sp, color: AllColor.black),
        SizedBox(width: 4.w),
        Text("United States",
            style: TextStyle(fontSize: 12.sp, color: AllColor.black87)),
      ],
    );
  }
}

/* ========================= PAYMENT BOX ========================= */
class SecurePaymentBox extends StatelessWidget {
  const SecurePaymentBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        border: Border.all(color: AllColor.grey300),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.security, size: 28.sp, color: AllColor.black),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Secure Payment",
                    style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: AllColor.black)),
                SizedBox(height: 4.h),
                Text(
                  "Payment is released when you complete the work and the client approves.",
                  style: TextStyle(fontSize: 11.sp, color: AllColor.black87),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/* ========================= APPLY BUTTON ========================= */
class ApplyButtonSection extends StatelessWidget {
  const ApplyButtonSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalButton(
      text: "Apply Now",
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: AllColor.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
          ),
          builder: (_) => const CustomBottomDialog(),
        );
      },
    );
  }
}

class CustomBottomDialog extends StatelessWidget {
  const CustomBottomDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final priceController = TextEditingController();
    final noteController = TextEditingController();
    final completionController = TextEditingController();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Make an Offer",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: AllColor.black,
                ),
              ),
              IconButton(
                icon: Icon(Icons.close, color: AllColor.black, size: 22.sp),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // Your Price
          Text("Your Price",
              style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: AllColor.black)),
          SizedBox(height: 6.h),
          _inputField(priceController, "Total amount (\$)"),
          SizedBox(height: 14.h),

          // Note to Client
          Text("Note to Client",
              style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: AllColor.black)),
          SizedBox(height: 6.h),
          _inputField(noteController,
              "Explain why you are the right person for this job...",
              maxLines: 3),
          SizedBox(height: 14.h),

          // Estimated Completion
          Text("Estimated Completion",
              style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: AllColor.black)),
          SizedBox(height: 6.h),
          _inputField(completionController, "e.g. 2 days, 1 week"),
          SizedBox(height: 20.h),

          // Submit Button
          GlobalButton(
            text: "Submit Offer",
            onPressed: () {
              Navigator.pop(context);
              // TODO: handle submit logic here
            },
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _inputField(TextEditingController controller, String hint,
      {int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: TextStyle(fontSize: 12.sp, color: AllColor.black),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(fontSize: 12.sp, color: AllColor.grey),
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: AllColor.logoColor, width: 1.2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: AllColor.logoColor, width: 1.5),
        ),
      ),
    );
  }
}
