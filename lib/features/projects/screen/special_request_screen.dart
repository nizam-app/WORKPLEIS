import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/core/widget/global_app_bar.dart';
import 'package:workpleis/features/auth/widgets/custom_label_text.dart';
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
        CustomLabelText(title: 'Project Title',),
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


class CategoryDropdownSection extends StatefulWidget {
  const CategoryDropdownSection({super.key});

  @override
  State<CategoryDropdownSection> createState() =>
      _CategoryDropdownSectionState();
}

class _CategoryDropdownSectionState extends State<CategoryDropdownSection> {
  String? selectedCategory;
  bool menuOpened = false;

  final categories = [
    "Compliance",
    "Complaince",
    "Specialized Procurement",
    "Rare & Specialized Procurement",
    "Technical & Engineering",
    "Confidential & Sensitive Services",
    "Executive & VIP Services",
    "Custom Projects",
    "Custom",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomLabelText(title: 'Category'),
        SizedBox(height: 6.h),

        /// Dropdown container
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          decoration: BoxDecoration(
            border: Border.all(color: AllColor.borderColor, width: 1.2),
            borderRadius: BorderRadius.circular(6.r),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedCategory,
              hint: Text(
                "Select a category",
                style: TextStyle(
                  fontSize: 13.sp,
                  color: AllColor.grey,
                ),
              ),
              isExpanded: true,
              icon: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: AllColor.borderColor,
              ),
              dropdownColor: Colors.white,
              style: TextStyle(
                fontSize: 13.sp,
                color: Colors.black,
              ),

              /// 👇 When dropdown opens or closes
              onTap: () async {
                // showMenu returns when dropdown closes, so:
                setState(() => menuOpened = true);
                await Future.delayed(const Duration(milliseconds: 400));
                setState(() => menuOpened = false);
              },

              onChanged: (value) {
                setState(() {
                  selectedCategory = value;
                  menuOpened = false;
                });
              },

              /// Dropdown items
              items: categories.map((cat) {
                final isSelected = cat == selectedCategory;
                return DropdownMenuItem(
                  value: cat,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    decoration: BoxDecoration(
                      color: (menuOpened && isSelected)
                          ? AllColor.borderColor.withOpacity(0.9)
                          : Colors.transparent,
                      border: Border(
                        bottom: BorderSide(
                          color: AllColor.borderColor.withOpacity(0.3),
                          width: 0.6,
                        ),
                      ),
                    ),
                    child: Text(
                      cat,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight:
                        isSelected ? FontWeight.w600 : FontWeight.w400,
                        color: (menuOpened && isSelected)
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
