import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';

class CustomStepProgressSection extends StatelessWidget {
  final int activeStep; // 0 = Basics, 1 = Scope, 2 = Budget, 3 = Contact
  const CustomStepProgressSection({super.key, required this.activeStep});

  static const _labels = ["Basics", "Scope", "Budget", "Contact"];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AllColor.brand2_light),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 Title
          Text(
            "Project Setup Progress",
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: AllColor.black,
              fontFamily: "bodyFont",
            ),
          ),
          SizedBox(height: 10.h),

          // 🔹 Circles + Connecting Lines
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List.generate(_labels.length * 2 - 1, (i) {
              if (i.isEven) {
                final idx = i ~/ 2;
                final isCompleted = idx < activeStep; // ✅ previous steps checked
                final isCurrent = idx == activeStep;
                final filled = isCompleted || isCurrent;

                return _StepCircle(
                  index: idx,
                  isCurrent: isCurrent,
                  isCompleted: isCompleted,
                  filled: filled,
                );
              } else {
                final leftIdx = (i - 1) ~/ 1;
                final connectorDone = leftIdx < activeStep;
                return Expanded(
                  child: Container(
                    height: 2.h,
                    color: connectorDone
                        ? AllColor.brand2_light
                        : AllColor.primary.withOpacity(0.4),
                  ),
                );
              }
            }),
          ),
          SizedBox(height: 8.h),

          // 🔹 Labels
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(_labels.length, (idx) {
              return SizedBox(
                width: 60.w,
                child: Text(
                  _labels[idx],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AllColor.black,
                    fontFamily: "bodyFont",
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

/* =====================================================
   ✅ Custom Step Circle Widget (Final Version)
   ===================================================== */
class _StepCircle extends StatelessWidget {
  final int index;
  final bool isCurrent;
  final bool isCompleted;
  final bool filled;

  const _StepCircle({
    required this.index,
    required this.isCurrent,
    required this.isCompleted,
    required this.filled,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 34.w,
      height: 34.w,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: filled ? AllColor.brand2_light : Colors.white,
          border: Border.all(
            color: filled ? AllColor.brand2_light : AllColor.primary,
            width: 1.6,
          ),
        ),
        child: Center(
          child: isCompleted
              ? Icon(Icons.check, size: 18.sp, color: AllColor.white)
              : Text(
            "${index + 1}",
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: filled ? AllColor.white : AllColor.black,
            ),
          ),
        ),
      ),
    );
  }
}