import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/color_control/all_color.dart';

class CustomStepProgressSection extends StatelessWidget {
  final int activeStep;
  const CustomStepProgressSection({super.key, required this.activeStep});
  static const _labels = ["Basics", "Scope", "Budget", "Contact"];
  @override
  Widget build(BuildContext context) {
    final lastIndex = _labels.length - 1;

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
          Text(
            "Project Setup Progress",
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w900,
              color: AllColor.black,
              fontFamily: "bodyFont",
            ),
          ),
          SizedBox(height: 10.h),

          // --- Circles + connecting lines ---
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List.generate(_labels.length * 2 - 1, (i) {
              // Even indexes -> circle; Odd indexes -> connector
              if (i.isEven) {
                final idx = i ~/ 2;
                final isCompleted = idx < activeStep;
                final isCurrent = idx == activeStep;
                final shouldFill = isCompleted || isCurrent; // fill current too (nice pop)

                return _StepCircle(
                  index: idx,
                  filled: shouldFill,
                  showCheck: isCompleted,
                );
              } else {
                final leftIdx = (i - 1) ~/ 2;
                // connector completed if the left step is completed
                final connectorDone = leftIdx < activeStep;
                return Expanded(
                  child: Container(
                    height: 2.h,
                    // lime for done, soft outline for pending
                    color: connectorDone
                        ? AllColor.primary
                        : AllColor.brand2_light,
                  ),
                );
              }
            }),
          ),
          SizedBox(height: 8.h),

          // --- Labels row ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(_labels.length, (idx) {
              return SizedBox(
                width: 60.w, // match circle width so text aligns under each
                child: Text(
                  _labels[idx],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AllColor.black,
                    fontWeight: FontWeight.w600,
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

/* ---------- circle widget ---------- */
class _StepCircle extends StatelessWidget {
  final int index;       // 0..3
  final bool filled;     // fill bg
  final bool showCheck;  // show ✓ or number
  const _StepCircle({
    required this.index,
    required this.filled,
    required this.showCheck,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 34.w,
      height: 34.w,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: filled ? AllColor.primary : Colors.white,
          border: Border.all(color: AllColor.primary, width: 1.6),
        ),
        child: Center(
          child: showCheck
              ? Icon(Icons.check, size: 18.sp, color: AllColor.black)
              : Text(
            "${index + 1}",
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AllColor.black,
            ),
          ),
        ),
      ),
    );
  }
}
