import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/core/widget/global_aleart_box.dart';
import 'package:workpleis/core/widget/global_app_bar.dart';
import 'package:workpleis/features/home/screen/client_home_screen.dart';
import '../../projects/widget/custom_back_next_buttons.dart';
import '../../projects/widget/custom_step_progress_section.dart';

class SpecialRequestScreen3 extends StatefulWidget {
  const SpecialRequestScreen3({super.key});

  static const routeName = "/specialRequestScreen3";

  @override
  State<SpecialRequestScreen3> createState() => _SpecialRequestScreen3State();
}

class _SpecialRequestScreen3State extends State<SpecialRequestScreen3> {
  final nameController = TextEditingController();
  final roleController = TextEditingController();

  String? selectedCommunication;
  String? selectedTime;

  final communicationOptions = ["Email", "Phone", "In-App"];
  final timeOptions = [
    "Morning (9AM-12PM)",
    "Afternoon (12PM-5PM)",
    "Evening (5PM-8PM)",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppbar(text: "Project"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomStepProgressSection(activeStep: 3),

            SizedBox(height: 20.h),

            // Full Name
            _label("Full Name"),
            SizedBox(height: 5.h,),
            _inputField(controller: nameController, hint: "Your full name"),
            SizedBox(height: 20.h),

            // Role / Title
            _label("Role / Title"),
            SizedBox(height: 5.h,),
            _inputField(controller: roleController, hint: "Your role or job title"),
            SizedBox(height: 20.h),

            // Preferred Communication
            _label("Preferred Communication"),
            SizedBox(height: 5.h,),
            _dropdownField(
              hint: "How should we contact you?",
              value: selectedCommunication,
              options: communicationOptions,
              onChanged: (val) => setState(() => selectedCommunication = val),
            ),
            SizedBox(height: 20.h),

            // Best Time to Contact
            _label("Best Time to Contact"),
            SizedBox(height: 5.h,),
            _dropdownField(
              hint: "When is the best time to reach you?",
              value: selectedTime,
              options: timeOptions,
              onChanged: (val) => setState(() => selectedTime = val)
            ),
            SizedBox(height: 20.h),
            CustomBackNextButtons(
              onBack: () {
                context.pop();
              },
              onNext: () {
                globalShowAlertDialog(
                  context: context,
                  oneTap: () {
                    context.push(HomeScreen.routeName);
                  },
                  message: "Project request submitted successfully",
                );
              },
              buttonText: "Submit",
            ),
          ],
        ),
      ),
    );
  }


  Widget _label(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w300,
        color: AllColor.black,
      ),
    );
  }
  Widget _inputField({required TextEditingController controller, required String hint}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.r),
          borderSide: BorderSide(color: AllColor.borderColor, width: 1.2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.r),
          borderSide: BorderSide(color: AllColor.borderColor, width: 1.5),
        ),
      ),
    );
  }

  Widget _dropdownField({
    required String hint,
    required String? value,
    required List<String> options,
    required Function(String?) onChanged,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        border: Border.all(color: AllColor.borderColor, width: 1.2),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: Text(hint,
              style: TextStyle(fontSize: 13.sp, color: AllColor.grey)),
          isExpanded: true,
          icon: Icon(Icons.keyboard_arrow_down, color: AllColor.black),
          dropdownColor: AllColor.white,
          style: TextStyle(fontSize: 13.sp, color: AllColor.white),
          onChanged: onChanged,
          items: options
              .map((opt) => DropdownMenuItem(
            value: opt,
            child: Text(opt,
                style: TextStyle(fontSize: 13.sp, color: AllColor.black)),
          ))
              .toList(),
        ),
      ),
    );
  }
}
