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
        border: Border.all(color: AllColor.grey300),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Project Setup Progress",style:
          TextStyle(fontSize: 13.sp,fontWeight:
          FontWeight.w500,color: AllColor.black),),
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
    bool isCompleted = activeStep > step;   // ager step gula
    bool isCurrent = activeStep == step;    // current step
    bool isUpcoming = activeStep < step;    // pore er gula

    return Column(
      children: [
        CircleAvatar(
          radius: 14.r,
          backgroundColor: isCompleted || isCurrent
              ? AllColor.borderColor
              : AllColor.grey200,
          child: isCompleted
              ? Icon(Icons.check, color: AllColor.white, size: 16.r)
              : isCurrent
              ? Text(
            "$number",
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              color: AllColor.black,
            ),
          )
              : Text(
            "$number",
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              color: AllColor.grey,
            ),
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          title,
          style: TextStyle(
            fontSize: 12.sp,
            color: isCompleted || isCurrent ? AllColor.black : AllColor.grey,
          ),
        ),
      ],
    );
  }
}
