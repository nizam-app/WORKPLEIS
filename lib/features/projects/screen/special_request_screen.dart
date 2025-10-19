import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/core/widget/global_app_bar.dart';
import 'package:workpleis/features/auth/widgets/custom_label_text.dart';
import 'package:workpleis/features/projects/screen/project_screen.dart';
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
            // const ProjectTitleSection(),
            // SizedBox(height: 20.h),
            // const CustomCategoryDropdown(),
            CustomServiceCard(
              title: "Deliver something for me",
              status: "Assigned",
              providerName: "Green Thumb Services",
              price: 50,
              location: "Suburban Area",
              date: "Jan 10, 2024",
              description: "Complete garden makeover with new plants, pathway, and irrigation system.",
            ),

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

// class ProjectTitleSection extends StatelessWidget {
//   const ProjectTitleSection({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const CustomLabelText(title: 'Project Title'),
//         //SizedBox(height: 6.h),
//         TextField(
//           controller: TextEditingController(),
//           decoration: InputDecoration(
//             hintText: "Enter project title",
//           ),
//         ),
//       ],
//     );
//   }
// }



// final selectedCategoryProvider = StateProvider<String?>((ref) => null);
//
// class CustomCategoryDropdown extends ConsumerWidget {
//   const CustomCategoryDropdown({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final selectedCategory = ref.watch(selectedCategoryProvider);
//
//     final categories = [
//       "Compliance",
//       "Specialized Procurement",
//       "Rare & Specialized Procurement",
//       "Technical & Engineering",
//       "Confidential & Sensitive Services",
//       "Executive & VIP Services",
//       "Custom Projects",
//       "Custom",
//     ];
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const CustomLabelText(title: "Category"),
//         Container(
//           padding: EdgeInsets.symmetric(horizontal: 12.w),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             border: Border.all(
//               color: AllColor.borderColor,
//               width: 1.2,
//             ),
//             borderRadius: BorderRadius.circular(12.r),
//           ),
//           child: LayoutBuilder(
//             builder: (context, box) {
//               return PopupMenuButton<String>(
//                 // ✅ নির্বাচিত আইটেম হাইলাইট হবে
//                 initialValue: selectedCategory,
//
//                 // ✅ মেনু ফিল্ডের ঠিক নিচে ওপেন হবে
//                 position: PopupMenuPosition.under,
//
//                 // ✅ সামান্য গ্যাপ
//                 offset: Offset(0, 4.h),
//
//                 // ✅ মেনুর চওড়া = ফিল্ডের চওড়া
//                 constraints: BoxConstraints(
//                   minWidth: box.maxWidth,
//                 ),
//
//                 onSelected: (value) {
//                   ref.read(selectedCategoryProvider.notifier).state = value;
//                 },
//
//                 itemBuilder: (BuildContext context) {
//                   return categories.map((String value) {
//                     final isSelected = value == selectedCategory;
//                     return PopupMenuItem<String>(
//                       value: value,
//                       height: 48.h,
//                       child: Container(
//                         width: double.infinity,
//                         padding: EdgeInsets.symmetric(
//                           vertical: 10.h,
//                           horizontal: 8.w,
//                         ),
//                         decoration: BoxDecoration(
//                           color: isSelected
//                               ? AllColor.brand2_light
//                               : Colors.white,
//                           borderRadius: BorderRadius.circular(6.r),
//                         ),
//                         child: Text(
//                           value,
//                           style: TextStyle(
//                             fontSize: 14.sp,
//                             color: isSelected ? Colors.white : Colors.black87,
//                             fontWeight: FontWeight.w400,
//                           ),
//                         ),
//                       ),
//                     );
//                   }).toList();
//                 },
//
//                 // ⛔ পুরনো negative offset মুছে দেওয়া হলো
//
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(6.r),
//                   side: BorderSide(
//                     color: AllColor.brand2_light,
//                     width: 1.0,
//                   ),
//                 ),
//
//                 // ট্রিগার (আগের মতোই)
//                 child: SizedBox(
//                   height: 48.h,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Expanded(
//                         child: Text(
//                           selectedCategory ?? "Select a category",
//                           style: TextStyle(
//                             fontSize: 13.sp,
//                             color: selectedCategory == null
//                                 ? AllColor.grey
//                                 : Colors.black,
//                             fontWeight: FontWeight.w400,
//                           ),
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                       Icon(Icons.keyboard_arrow_down_rounded,
//                           color: AllColor.borderColor),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }

class CustomServiceCard extends StatelessWidget {
  final String title;
  final String status;
  final String providerName;
  final int price;
  final String location;
  final String date;
  final String description;
  final int trakingID;

  const CustomServiceCard({
    super.key,
    required this.title,
    required this.status,
    required this.providerName,
    required this.price,
    required this.location,
    required this.date,
    required this.description,
    this.trakingID = 0
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AllColor.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AllColor.borderColor.withOpacity(.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title + Status badge
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: theme.titleSmall?.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AllColor.black,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AllColor.brand2_light,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  status,
                  style: theme.titleMedium?.copyWith(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                    color: AllColor.white,
                  ),
                ),
              ),
            ],
          ),
          8.verticalSpace,

          // Provider / Client name
          Text(
            providerName,
            style: theme.titleMedium?.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AllColor.black.withOpacity(.7),
            ),
          ),
          8.verticalSpace,

          // Price + Location + Date
          Row(
            children: [
              Text(
                "\$${price}",
                style: theme.titleSmall?.copyWith(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  color: AllColor.black,
                ),
              ),
              16.horizontalSpace,
              Icon(Icons.location_on_outlined, size: 14.sp, color: AllColor.black.withOpacity(.6)),
              4.horizontalSpace,
              Expanded(
                child: Text(
                  location,
                  style: theme.titleMedium?.copyWith(
                    fontSize: 12.sp,
                    color: AllColor.black.withOpacity(.6),
                  ),
                ),
              ),
              Text(
                date,
                style: theme.titleMedium?.copyWith(
                  fontSize: 12.sp,
                  color: AllColor.black.withOpacity(.6),
                ),
              ),
            ],
          ),
          12.verticalSpace,
        if (trakingID >= 2)  ReviewNoticeCard(onTap: () {showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          ),
          builder: (_) => const CustomProjectCompletionBottomSheet(),
        );},),
          12.verticalSpace,

          // Description
          Text(
            description,
            style: theme.bodyMedium?.copyWith(
              fontSize: 13.sp,
              color: AllColor.black87,
              height: 1.3,
            ),
          ),
          SizedBox(height: 12.h),
          if (trakingID == 4)  ReviewForm()
        ],
      ),
    );
  }
}

class ReviewNoticeCard extends StatelessWidget {
  final VoidCallback onTap;

  const ReviewNoticeCard({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFCF5), // light yellow background
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Colors.orange.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ✅ Top Row with dot + text
          Row(
            children: [
              Container(
                width: 8.w,
                height: 8.w,
                decoration: BoxDecoration(
                  color: Colors.orange.shade300,
                  shape: BoxShape.circle,
                ),
              ),
              8.horizontalSpace,
              Text(
                "Review the completed job",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                  fontFamily: "bodyFond"
                ),
              ),
            ],
          ),
          6.verticalSpace,

          // ✅ View Details Link
          GestureDetector(
            onTap: onTap,
            child: Row(
              children: [
                Text(
                  "View Details",
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.red,
                    fontFamily: "bodyFont"
                  ),
                ),
                4.horizontalSpace,
                Icon(Icons.arrow_forward, size: 14.sp, color: Colors.deepOrange),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
class ReviewForm extends StatefulWidget {
  const ReviewForm({super.key});

  @override
  State<ReviewForm> createState() => _ReviewFormState();
}

class _ReviewFormState extends State<ReviewForm> {
  int rating = 4;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// 🔶 Ratings Label
        Row(
          children: [
            Text(
              "Ratings",
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontFamily: "bodyFond"

              ),
            ),
            SizedBox(width: 10.w,),
            StarRating(rating: 3.5, color: AllColor.borderColor,size: 18.r,),
          ],
        ),
        6.verticalSpace,
        12.verticalSpace,

        /// 🔶 Message Label
        Text(
          "Message",
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        6.verticalSpace,

        /// 📝 Text Field
        TextField(
          controller: _controller,
          maxLines: 4,
          decoration: InputDecoration(
            hintText: "wow, that was a great experience.",
            hintStyle: TextStyle(color: Colors.grey.shade500),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: Colors.deepPurple.shade100),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: Colors.deepPurple),
            ),
          ),
        ),
        16.verticalSpace,

        /// ✅ Submit Button
        ElevatedButton(
          onPressed: () {

          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFD8FF3F), // Light lime green
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(999.r),
            ),
          ),
          child: Text(
            "Submit Review",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 13.sp,
            ),
          ),
        ),
      ],
    );
  }
}
