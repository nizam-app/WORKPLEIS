import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/color_control/all_color.dart';
import 'custom_filter_dialog.dart';

class CustomSearchBoxBottom extends StatelessWidget {
  const CustomSearchBoxBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 2.h,),
                      // suffixIcon: Icon(Icons.tune, color: AllColor.grey),
                      prefixIcon: Icon(Icons.search, color: AllColor.grey),
                      hintText: "What do you need done today?",

                    ),
            ),
        ),
        SizedBox(width: 10.w),
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              builder: (_) => const FilterJobsBottomSheet(),
            );

            },
          child: Container(
            height: 37.h,
            width: 37.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AllColor.primary,
            ),
            child: Center(
              child: Icon(Icons.filter_alt_outlined, size: 25.sp, color: AllColor.white),
            ),
          ),
        ),
      ],
    );
  }
}
