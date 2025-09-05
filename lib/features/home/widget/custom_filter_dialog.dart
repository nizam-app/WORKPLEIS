import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/core/widget/global_snack_bar.dart';

import '../../../core/widget/global_bottom.dart';

class CustomDialog extends StatefulWidget {
  const CustomDialog({super.key});

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  // Category selection
  String selectedCategory = "Home Services";

  // Budget range
  RangeValues _budgetRange = const RangeValues(0, 3000);

  final List<String> categories = [
    "Home Services",
    "Delivery",
    "Tech Support",
    "Business",
    "Web Development",
  ];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(16.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Filter Jobs",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AllColor.black,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close, size: 22.sp, color: AllColor.black),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            ),
            SizedBox(height: 12.h),

            // Categories
            Text(
              "Category",
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AllColor.black,
              ),
            ),
            SizedBox(height: 10.h),
            Wrap(
              spacing: 10.w,
              runSpacing: 10.h,
              children: categories.map((cat) {
                final isSelected = selectedCategory == cat;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCategory = cat;
                    });
                  },
                  child: Container(
                    padding:
                    EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: isSelected ? AllColor.logoColor : AllColor.white,
                      border: Border.all(color: AllColor.logoColor),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      cat,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: AllColor.black,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 20.h),

            // Budget Range
            Text(
              "Budget Range",
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AllColor.black,
              ),
            ),
            RangeSlider(
              values: _budgetRange,
              min: 0,
              max: 3000,
              activeColor: AllColor.logoColor,
              inactiveColor: AllColor.logoColor.withOpacity(0.3),
              labels: RangeLabels(
                "\$${_budgetRange.start.round()}",
                "\$${_budgetRange.end.round()}",
              ),
              onChanged: (RangeValues values) {
                setState(() {
                  _budgetRange = values;
                });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("\$0",
                    style: TextStyle(fontSize: 12.sp, color: AllColor.black)),
                Text("\$3000",
                    style: TextStyle(fontSize: 12.sp, color: AllColor.black)),
              ],
            ),
            SizedBox(height: 20.h),

            // Apply Button
            GlobalButton(
              text: "Apply Filter",
              onPressed: () {
                Navigator.pop(context);
               GlobalSnackBar.show(context, title: "success", message: "filter applied");
              },
            ),
          ],
        ),
      ),
    );
  }
}
