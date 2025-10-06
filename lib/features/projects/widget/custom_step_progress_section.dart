import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/color_control/all_color.dart';

class CustomStepProgressSection extends StatelessWidget {
  final int activeStep; // 1 to 4

  const CustomStepProgressSection({
    super.key,
    required this.activeStep,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        border: Border.all(color: AllColor.brand2_light),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Project Setup Progress",style:
          TextStyle(fontSize: 13.sp,fontWeight:
          FontWeight.w900,color: AllColor.black,fontFamily: "bodyFont"),),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StepItem(number: 1, title: "Basics", step: 1, activeStep: activeStep),
              StepItem(number: 2, title: "Scope", step: 2, activeStep: activeStep),
              StepItem(number: 3, title: "Budget", step: 3, activeStep: activeStep),
              StepItem(number: 4, title: "Contact", step: 4, activeStep: activeStep),
            ],
          ),
        ],
      ),
    );
  }
}

class StepItem extends StatelessWidget {
  final int number;
  final String title;
  final int step;
  final int activeStep;

  const StepItem({
    super.key,
    required this.number,
    required this.title,
    required this.step,
    required this.activeStep,
  });

  @override
  Widget build(BuildContext context) {
    final bool isCurrent = activeStep == step;

    return Column(
      children: [
        Container(
          width: 32.w,
          height: 32.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: isCurrent ? AllColor.primary : AllColor.primary,
              width: 1.6,
            ),
            color: Colors.white,
          ),
          child: Center(
            child: Text(
              "$number",
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          title,
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontFamily: "bodyFont"
          ),
        ),
      ],
    );
  }
}
