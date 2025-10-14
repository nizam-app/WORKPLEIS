import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/core/widget/global_app_bar.dart';
import 'package:workpleis/features/auth/widgets/custom_label_text.dart';
import 'package:workpleis/features/projects/screen/spcial_request_screen1.dart';

import '../widget/custom_back_next_buttons.dart';
import '../widget/custom_step_progress_section.dart';

class ProjectSetupScreen extends StatelessWidget {
  const ProjectSetupScreen({super.key});
  static const routeName = "/projectSetupScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppbar(text: "Project "),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomStepProgressSection(activeStep: 0),
            SizedBox(height: 20.h),
            const ProjectTitleSection(),
            SizedBox(height: 20.h),
            const CustomCategoryDropdown(),
            SizedBox(height: 20.h),
            CustomBackNextButtons(onBack: () {
              context.pop();
            }, onNext: () {
              context.push(SpecialRequestScreen1.routeName) ;},)
          ],
        ),
      ),


    );
  }
}

class ProjectTitleSection extends StatelessWidget {
  const ProjectTitleSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomLabelText(title: 'Project Title'),
        //SizedBox(height: 6.h),
        TextField(
          controller: TextEditingController(),
          decoration: InputDecoration(
            hintText: "Enter project title",
          ),
        ),
      ],
    );
  }
}



final selectedCategoryProvider = StateProvider<String?>((ref) => null);

class CustomCategoryDropdown extends ConsumerWidget {
  const CustomCategoryDropdown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(selectedCategoryProvider);

    final categories = [
      "Compliance",
      "Specialized Procurement",
      "Rare & Specialized Procurement",
      "Technical & Engineering",
      "Confidential & Sensitive Services",
      "Executive & VIP Services",
      "Custom Projects",
      "Custom",
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomLabelText(title: "Category"),
        //SizedBox(height: 6.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: AllColor.borderColor,
              width: 1.2,
            ),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: PopupMenuButton<String>(
            onSelected: (value) {
              ref.read(selectedCategoryProvider.notifier).state = value;
            },
            itemBuilder: (BuildContext context) {
              return categories.map((String value) {
                final isSelected = value == selectedCategory;
                return PopupMenuItem<String>(
                  value: value,
                  height: 48.h,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFF4C4470) : Colors.white,
                    ),
                    child: Text(
                      value,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: isSelected ? Colors.white : Colors.black87,
                        fontWeight: isSelected ? FontWeight.w400 : FontWeight.w400,
                      ),
                    ),
                  ),
                );
              }).toList();
            },
            offset: const Offset(0, -310), // Opens upward
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.r),
              side: BorderSide(
                color: AllColor.borderColor.withOpacity(0.6),
                width: 1.0,
              ),
            ),
            child: SizedBox(
              height: 48.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      selectedCategory ?? "Select a category",
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: selectedCategory == null ? AllColor.grey : Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(Icons.keyboard_arrow_down_rounded,
                      color: AllColor.borderColor),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}