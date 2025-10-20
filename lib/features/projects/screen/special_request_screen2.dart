import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/core/widget/global_app_bar.dart';
import 'package:workpleis/features/projects/screen/special_request_screen.dart';
import 'package:workpleis/features/projects/screen/special_request_screen3.dart';
import 'package:workpleis/features/projects/widget/custom_back_next_buttons.dart';

import '../widget/custom_step_progress_section.dart';

// =============== MAIN SCREEN ===============
class SpecialRequestScreen2 extends StatelessWidget {
  const SpecialRequestScreen2({super.key});
  static const routeName = "/specialRequestScreen2";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppbar(text: "Project"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomStepProgressSection(activeStep:2,),
            const SizedBox(height: 20),
            // const BudgetRangeSection(),
            // const SizedBox(height: 20),
            // const SupportingDocumentsSection(),
            // const SizedBox(height: 20),
            // const DisclaimerSection(),
            // const SizedBox(height: 20),
            CustomServiceCard(
              title: "Deliver something for me",
              status: "In Review",
              providerName: "Green Thumb Services",
              price: 50,
              location: "Suburban Area",
              date: "Jan 10, 2024",
              description: "Complete garden makeover with new plants, pathway, and irrigation system.",
              trakingID: 3,
            ),
            SizedBox(height: 25,),
            CustomBackNextButtons(onBack: () {
              context.pop();
            }, onNext: () {
              context.push(SpecialRequestScreen3.routeName) ;},)
          ],
        ),
      ),

    );
  }
}

// =============== CUSTOM WIDGETS ===============




//
// class StepCircle extends StatelessWidget {
//   final int number;
//   final String title;
//   final bool isActive;
//   final bool isCompleted;
//   const StepCircle({
//     super.key,
//     required this.number,
//     required this.title,
//     this.isActive = false,
//     this.isCompleted = false,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         CircleAvatar(
//           radius: 14.r,
//           backgroundColor:
//           isCompleted || isActive ? AllColor.borderColor : AllColor.grey200,
//           child: isCompleted
//               ? Icon(Icons.check, size: 14.sp, color: AllColor.white)
//               : Text(
//             "$number",
//             style: TextStyle(
//               fontSize: 12.sp,
//               fontWeight: FontWeight.bold,
//               color: isActive ? AllColor.black : AllColor.grey,
//             ),
//           ),
//         ),
//         SizedBox(height: 6.h),
//         Text(title,
//             style: TextStyle(
//               fontSize: 12.sp,
//               color: isActive ? AllColor.black : AllColor.grey,
//             )),
//       ],
//     );
//   }
// }
//
// class BudgetRangeSection extends StatefulWidget {
//   const BudgetRangeSection({super.key});
//
//   @override
//   State<BudgetRangeSection> createState() => _BudgetRangeSectionState();
// }
//
// class _BudgetRangeSectionState extends State<BudgetRangeSection> {
//   String? selectedBudget = "Under \$5,000";
//
//   final budgets = [
//     "Under \$5,000",
//     "\$5,000-\$20,000",
//     "Over \$100,000",
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: budgets
//           .map((b) => GestureDetector(
//         onTap: () => setState(() => selectedBudget = b),
//         child: Container(
//           margin: EdgeInsets.only(bottom: 10.h),
//           padding:
//           EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
//           decoration: BoxDecoration(
//             border: Border.all(
//                 color: selectedBudget == b
//                     ? AllColor.borderColor
//                     : AllColor.grey300,
//                 width: 1.2),
//             borderRadius: BorderRadius.circular(8.r),
//           ),
//           child: Row(
//             children: [
//               Icon(
//                 selectedBudget == b
//                     ? Icons.radio_button_checked
//                     : Icons.radio_button_off,
//                 color: selectedBudget == b
//                     ? AllColor.borderColor
//                     : AllColor.grey,
//                 size: 20.sp,
//               ),
//               SizedBox(width: 10.w),
//               Text(b,
//                   style: TextStyle(
//                       fontSize: 13.sp, color: AllColor.black)),
//             ],
//           ),
//         ),
//       ))
//           .toList(),
//     );
//   }
// }
//
// class SupportingDocumentsSection extends StatelessWidget {
//   const SupportingDocumentsSection({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text("Supporting Documents (Optional)",
//             style: TextStyle(
//                 fontSize: 16.sp,
//                 fontWeight: FontWeight.w300,
//                 color: AllColor.black)),
//         SizedBox(height: 5.h),
//         Container(
//           width: double.infinity,
//           padding: EdgeInsets.symmetric(vertical: 30.h),
//           decoration: BoxDecoration(
//             border: Border.all(color: AllColor.grey300),
//             borderRadius: BorderRadius.circular(12.r),
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(Icons.upload_file, size: 36.sp, color: AllColor.grey),
//               SizedBox(height: 8.h),
//               Text("Choose files or drag and drop",
//                   style: TextStyle(fontSize: 13.sp, color: AllColor.black87)),
//               Text("Any file type accepted",
//                   style: TextStyle(fontSize: 12.sp, color: AllColor.grey)),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class DisclaimerSection extends StatelessWidget {
//   const DisclaimerSection({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       "This project involves confidential information that requires a non-disclosure agreement",
//       style: TextStyle(fontSize: 11.sp, color: AllColor.grey),
//     );
//   }
// }
