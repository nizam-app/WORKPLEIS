import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/features/projects/screen/special_request_screen2.dart';

import '../../../core/widget/global_app_bar.dart';
import '../widget/custom_bottom_buttons_section.dart';
import '../widget/custom_step_progress_section.dart';

class SpecialRequestScreen1 extends StatelessWidget {
  const SpecialRequestScreen1({super.key});
  static const routeName = "/specialRequestScreen1";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppbar(text: "Special Request"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            CustomStepProgressSection(activeStep: 1,),
            SizedBox(height: 20),
            ProjectDescriptionSection(),
            SizedBox(height: 20),
            UrgencySection(),
            SizedBox(height: 20),
            NdaSection(),
            SizedBox(height: 40),
          ],
        ),
      ),
      bottomNavigationBar:  CustomBottomButtonsSection(
        onPressed: () {context.push(
            SpecialRequestScreen2.routeName);},),
    );
  }
}

/* ============== Progress Indicator ============== */


/* ============== Project Description ============== */
class ProjectDescriptionSection extends StatelessWidget {
  const ProjectDescriptionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Project Description",
            style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: AllColor.black)),
        SizedBox(height: 8.h),
        TextField(
          maxLines: 5,
          decoration: InputDecoration(
            hintText: "Write your project details...",
            contentPadding: EdgeInsets.all(12.w),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: AllColor.borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: AllColor.borderColor, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}

/* ============== Urgency Options ============== */
class UrgencySection extends StatefulWidget {
  const UrgencySection({super.key});

  @override
  State<UrgencySection> createState() => _UrgencySectionState();
}

class _UrgencySectionState extends State<UrgencySection> {
  String urgency = "1-2 weeks";

  final options = [
    {
      "value": "Immediate",
      "title": "Immediate",
      "subtitle": "Start work within 24 hours",
    },
    {
      "value": "1-2 weeks",
      "title": "1-2 weeks",
      "subtitle": "Standard timeline for complex projects",
    },
    {
      "value": "Flexible",
      "title": "Flexible",
      "subtitle": "Timeline can be adjusted based on requirements",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Urgency",
            style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: AllColor.black)),
        SizedBox(height: 12.h),
        ...options.map((opt) => _urgencyOption(
          value: opt["value"]!,
          title: opt["title"]!,
          subtitle: opt["subtitle"]!,
        )),
      ],
    );
  }

  Widget _urgencyOption({
    required String value,
    required String title,
    required String subtitle,
  }) {
    final isSelected = urgency == value;
    return GestureDetector(
      onTap: () => setState(() => urgency = value),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
        decoration: BoxDecoration(
          border: Border.all(
              color: isSelected ? AllColor.borderColor : AllColor.grey300, width: 1),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Radio<String>(
              value: value,
              groupValue: urgency,
              activeColor: AllColor.black,
              onChanged: (val) => setState(() => urgency = val!),
            ),
            SizedBox(width: 6.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: AllColor.black)),
                  SizedBox(height: 4.h),
                  Text(subtitle,
                      style:
                      TextStyle(fontSize: 11.sp, color: AllColor.black87)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* ============== NDA Section ============== */
class NdaSection extends StatefulWidget {
  const NdaSection({super.key});

  @override
  State<NdaSection> createState() => _NdaSectionState();
}

class _NdaSectionState extends State<NdaSection> {
  bool ndaRequired = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Transform.scale(
          scale: 0.9, // ছোট সুন্দর switch
          child: Switch(
            value: ndaRequired,
            onChanged: (val) {
              setState(() => ndaRequired = val);
            },
            activeColor: AllColor.white,
            activeTrackColor: AllColor.black,
            inactiveThumbColor: AllColor.white,
            inactiveTrackColor: AllColor.grey300,
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "NDA Required",
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: AllColor.black,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                "This project involves confidential information that requires a non-disclosure agreement",
                style: TextStyle(
                  fontSize: 11.sp,
                  color: AllColor.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}


/* ============== Bottom Buttons ============== */
