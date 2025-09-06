import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/core/widget/global_app_bar.dart';
import 'package:workpleis/features/projects/screen/spcial_request_screen1.dart';

import '../widget/custom_bottom_buttons_section.dart';
import '../widget/custom_step_progress_section.dart';

class ProjectSetupScreen extends StatelessWidget {
  const ProjectSetupScreen({super.key});
  static const routeName = "/projectSetupScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppbar(text: "Special Request"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            CustomStepProgressSection(activeStep: 0,),
            SizedBox(height: 20),
            ProjectTitleSection(),
            SizedBox(height: 20),
            CategoryDropdownSection(),

          ],
        ),
      ),
      bottomNavigationBar:  CustomBottomButtonsSection(onPressed: (){context.push(SpecialRequestScreen1.routeName);},)
    );
  }
}

/* ================= Step Progress ================= */




/* ================= Project Title ================= */
class ProjectTitleSection extends StatelessWidget {
  const ProjectTitleSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Project Title",
            style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: AllColor.black)),
        SizedBox(height: 6.h),
        TextField(
          controller: TextEditingController(text: "Development"),
          decoration: InputDecoration(
            contentPadding:
            EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AllColor.logoColor, width: 1.2),
              borderRadius: BorderRadius.circular(6.r),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AllColor.logoColor, width: 1.5),
              borderRadius: BorderRadius.circular(6.r),
            ),
          ),
        ),
      ],
    );
  }
}

/* ================= Category Dropdown ================= */
class CategoryDropdownSection extends StatefulWidget {
  const CategoryDropdownSection({super.key});

  @override
  State<CategoryDropdownSection> createState() =>
      _CategoryDropdownSectionState();
}

class _CategoryDropdownSectionState extends State<CategoryDropdownSection> {
  String? selectedCategory;

  final categories = [
    "Compliance",
    "Complaince",
    "Specialized Procurement",
    "Custom",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Category",
            style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: AllColor.black)),
        SizedBox(height: 6.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          decoration: BoxDecoration(
            border: Border.all(color: AllColor.logoColor, width: 1.2),
            borderRadius: BorderRadius.circular(6.r),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedCategory,
              hint: Text(
                "Select a category",
                style: TextStyle(fontSize: 13.sp, color: AllColor.grey),
              ),
              isExpanded: true,
              icon: Icon(Icons.keyboard_arrow_down, color: AllColor.black),
              dropdownColor: AllColor.black,
              style: TextStyle(fontSize: 13.sp, color: AllColor.white),
              onChanged: (value) {
                setState(() {
                  selectedCategory = value;
                });
              },
              items: categories
                  .map((cat) => DropdownMenuItem(
                value: cat,
                child: Text(cat,
                    style: TextStyle(
                        fontSize: 13.sp, color:AllColor.grey)),
              ))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
