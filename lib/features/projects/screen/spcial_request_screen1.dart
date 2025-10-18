import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/features/projects/screen/special_request_screen2.dart';
import 'package:workpleis/features/projects/widget/custom_back_next_buttons.dart';

import '../../../core/widget/global_app_bar.dart';

import '../widget/custom_step_progress_section.dart';

class SpecialRequestScreen1 extends StatelessWidget {
  const SpecialRequestScreen1({super.key});
  static const routeName = "/specialRequestScreen1";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppbar(text: "Project"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomStepProgressSection(activeStep: 1,),
            const SizedBox(height: 20),
            const ProjectDescriptionSection(),
            const SizedBox(height: 20),
            const UrgencySection(),
            const SizedBox(height: 20),
            const NdaSection(),
            const SizedBox(height: 40),
            CustomBackNextButtons(onBack: () {
              context.pop();
            }, onNext: () {
              context.push(SpecialRequestScreen2.routeName) ;},)

          ],
        ),
      ),

    );
  }
}

/* ============== Progress Indicator ============== */

class ProjectDescriptionSection extends StatelessWidget {
  const ProjectDescriptionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Project Description",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w300,
            color: AllColor.black,
          ),
        ),
        SizedBox(height: 8.h),
        TextField(
          maxLines: 6,
          decoration: InputDecoration(
            hintText: "Write your project details...",
            hintStyle: TextStyle(color: AllColor.grey),
            contentPadding: EdgeInsets.all(14.w),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: AllColor.borderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: AllColor.borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: AllColor.borderColor, width: 1.6),
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

  final options = const [
    ("Immediate", "Start work within 24 hours"),
    ("1-2 weeks", "Standard timeline for complex projects"),
    ("Flexible", "Timeline can be adjusted based on requirements"),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Urgency",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w300,
            color: AllColor.black,
          ),
        ),
        SizedBox(height: 5.h),
        ...options.map(
              (o) => _UrgencyTile(
            title: o.$1,
            subtitle: o.$2,
            selected: urgency == o.$1,
            onTap: () => setState(() => urgency = o.$1),
          ),
        ),
      ],
    );
  }
}

class _UrgencyTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool selected;
  final VoidCallback onTap;

  const _UrgencyTile({
    required this.title,
    required this.subtitle,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final outline = selected ? AllColor.borderColor : AllColor.grey300;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: selected ? AllColor.brand2_light.withOpacity(0.08) : Colors.white,
          border: Border.all(color: outline, width: 1),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Radio<String>(
              value: title,
              groupValue: selected ? title : "",
              onChanged: (_) => onTap(),
              activeColor: AllColor.black,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            SizedBox(width: 6.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w300,
                      color: AllColor.black,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: AllColor.black87,
                    ),
                  ),
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
          scale: 0.9,
          child: Switch(
            value: ndaRequired,
            onChanged: (v) => setState(() => ndaRequired = v),
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
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w300,
                  color: AllColor.black,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                "This project involves confidential information that requires a non-disclosure agreement",
                style: TextStyle(fontSize: 11.sp, color: AllColor.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }
}