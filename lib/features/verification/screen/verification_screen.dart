import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';

import '../../../core/widget/global_app_bar.dart';
import '../../../core/widget/global_bottom.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});
  static const routeName = "/verificationScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: GlobalAppbar(text: "Verification"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            VerificationPendingCard(),
            SizedBox(height: 20),
            VerificationStepsSection(),
            SizedBox(height: 20),
            VerificationBenefitsSection(),
          ],
        ),
      ),
    );
  }
}

/* ================= PENDING CARD ================= */
class VerificationPendingCard extends StatelessWidget {
  const VerificationPendingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AllColor.appBar,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Icon(Icons.verified, color: AllColor.borderColor, size: 28.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Verification Pending",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: AllColor.white,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  "Complete your identity verification to unlock all features and build trust with clients",
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: AllColor.white,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

/* ================= VERIFICATION STEPS ================= */
class VerificationStepsSection extends StatelessWidget {
  const VerificationStepsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Verification Steps",
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.bold,
            color: AllColor.black,
          ),
        ),
        SizedBox(height: 12.h),
        VerificationStepTile(
          icon: Icons.email,
          title: "Email Verified",
          subtitle: "Your email has been confirmed",
          status: "done",
          onTap: () {},
        ),
        VerificationStepTile(
          icon: Icons.phone,
          title: "Phone Verification",
          subtitle: "Verify your phone number",
          status: "verify",
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: AllColor.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
              ),
              builder: (_) => const VerifyPhoneBottomSheet(),
            );
          },
        ),
        VerificationStepTile(
          icon: Icons.credit_card,
          title: "Identity Verification",
          subtitle: "Upload your ID",
          status: "upload",
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: AllColor.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
              ),
              builder: (_) => const UploadIdBottomSheet(),
            );
          },
        ),
      ],
    );
  }
}

class VerificationStepTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String status; // done | verify | upload
  final VoidCallback onTap;

  const VerificationStepTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.status, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onTap ,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: AllColor.appBar,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: [
            Icon(icon, size: 28.sp, color: AllColor.white),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: AllColor.white)),
                  SizedBox(height: 4.h),
                  Text(subtitle,
                      style: TextStyle(fontSize: 11.sp, color: AllColor.white)),
                ],
              ),
            ),
            if (status == "done")
              Icon(Icons.check_circle, color: AllColor.borderColor, size: 20.sp),
            if (status == "verify")
              TextButton(
                onPressed: () {},
                child: Text("Verify",
                    style: TextStyle(fontSize: 11.sp, color: AllColor.black)),
              ),
            if (status == "upload")
              TextButton(
                onPressed: () {},
                child: Text("Upload",
                    style: TextStyle(fontSize: 11.sp, color: AllColor.black)),
              ),
          ],
        ),
      ),
    );
  }
}

/* ================= VERIFICATION BENEFITS ================= */
class VerificationBenefitsSection extends StatelessWidget {
  const VerificationBenefitsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final benefits = [
      "Higher visibility in search results",
      "Build trust with potential clients",
      "Access to premium features",
      "Priority customer support",
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Verification Benefits",
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.bold,
            color: AllColor.black,
          ),
        ),
        SizedBox(height: 12.h),
        ...benefits.map((b) => Padding(
          padding: EdgeInsets.only(bottom: 10.h),
          child: Row(
            children: [
              Icon(Icons.check_circle, color: AllColor.green, size: 18.sp),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  b,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AllColor.black,
                  ),
                ),
              ),
            ],
          ),
        )),
      ],
    );
  }
}
class VerifyPhoneBottomSheet extends StatelessWidget {
  const VerifyPhoneBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final codeController = TextEditingController();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            "Verify Phone Number",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: AllColor.black,
            ),
          ),
          SizedBox(height: 8.h),

          // Description
          Text(
            "We have sent you a verification code. Please enter the code below to verify your phone number.",
            style: TextStyle(
              fontSize: 12.sp,
              color: AllColor.black87,
            ),
          ),
          SizedBox(height: 16.h),

          // Code Field
          Text(
            "Verification Code",
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: AllColor.black,
            ),
          ),
          SizedBox(height: 6.h),
          TextField(
            controller: codeController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "Enter Code",
              hintStyle: TextStyle(fontSize: 12.sp, color: AllColor.grey),
              contentPadding:
              EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: AllColor.borderColor, width: 1.2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: AllColor.borderColor, width: 1.5),
              ),
            ),
          ),
          SizedBox(height: 20.h),

          // Verify Button
          GlobalButton(
            text: "Verify Phone",
            onPressed: () {
              // TODO: handle verify logic
              Navigator.pop(context);
            },
          ),
          SizedBox(height: 10.h),

          // Cancel Button
          Center(
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "Cancel",
                style: TextStyle(fontSize: 13.sp, color: AllColor.black),
              ),
            ),
          ),

          SizedBox(height: 10.h),
          Center(
            child: Text(
              "Use code 0007 for demo purposes",
              style: TextStyle(fontSize: 11.sp, color: AllColor.grey),
            ),
          ),
        ],
      ),
    );
  }
}


class UploadIdBottomSheet extends StatelessWidget {
  const UploadIdBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Upload Identity Document",
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
          SizedBox(height: 8.h),

          // Description
          Text(
            "Upload a clear photo of your government-issued ID (driver's license, passport, or national ID card)",
            style: TextStyle(fontSize: 12.sp, color: AllColor.black87),
          ),
          SizedBox(height: 16.h),

          // Upload Area
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 30.h),
            decoration: BoxDecoration(
              border: Border.all(
                color: AllColor.grey300,
                style: BorderStyle.solid, // 👉 If you want dashed, use dotted_border pkg
              ),
              borderRadius: BorderRadius.circular(12.r),
              color: AllColor.white, // transparent feel
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.person_outline,
                  size: 48.sp,
                  color: AllColor.grey, // light grey outline
                ),
                SizedBox(height: 10.h),
                Text(
                  "Drag & drop your ID here",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AllColor.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "or click to browse files",
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AllColor.grey,
                  ),
                ),
                SizedBox(height: 16.h),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AllColor.black87, // dark navy/charcoal
                    padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r), // rounded pill shape
                    ),
                  ),
                  onPressed: () {
                    // TODO: file picker
                  },
                  child: Text(
                    "Choose File",
                    style: TextStyle(
                      color: AllColor.white,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          )
,
          SizedBox(height: 14.h),

          // Cancel Button
          Center(
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "Cancel",
                style: TextStyle(fontSize: 13.sp, color: AllColor.black),
              ),
            ),
          ),
          SizedBox(height: 16.h),

          // Requirements
          Text(
            "Requirements :",
            style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: AllColor.black),
          ),
          SizedBox(height: 10.h),
          _requirement("Document must be current and not expired"),
          _requirement("Photo must be clear and readable"),
          _requirement("All corners of the document must be visible"),
          _requirement("Accepted formats: JPG, PNG, PDF"),
          SizedBox(height: 10.h),
        ],
      ),
    );
  }

  Widget _requirement(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.circle, size: 6.sp, color: AllColor.black87),
          SizedBox(width: 6.w),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 11.sp, color: AllColor.black87),
            ),
          ),
        ],
      ),
    );
  }
}
