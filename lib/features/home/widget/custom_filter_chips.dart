import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/color_control/all_color.dart';

class CustomFilterChips extends StatefulWidget {
  const CustomFilterChips({super.key});

  @override
  State<CustomFilterChips> createState() => _CustomFilterChipsState();
}

class _CustomFilterChipsState extends State<CustomFilterChips> {
  int selectedIndex = 0;

  Widget _filterChip(String text, int index) {
    final bool selected = index == selectedIndex;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        margin: EdgeInsets.only(right: 8.w),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: selected ? AllColor.borderColor : AllColor.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AllColor.borderColor),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(fontSize: 12.sp, color: AllColor.black),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filters = ["All", "Nearby", "Urgent", "High Budget", "Remote"];

    return SizedBox(
      height: 40.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        itemBuilder: (context, index) {
          return _filterChip(filters[index], index);
        },
      ),
    );
  }
}
