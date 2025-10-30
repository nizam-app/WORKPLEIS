import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/core/widget/global_app_bar.dart';
import 'package:workpleis/features/auth/widgets/custom_label_text.dart';
import 'package:workpleis/features/tracking/client_project_tracking/spcial_request_screen1.dart';

import '../../projects/widget/custom_back_next_buttons.dart';
import '../../projects/widget/custom_step_progress_section.dart';

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
            Column(
              children: [
                const ProjectTitleSection(),
                SizedBox(height: 20.h),
                const CustomCategoryDropdown(),
              ],
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
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: AllColor.borderColor,
              width: 1,

            ),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: LayoutBuilder(
            builder: (context, box) {
              return PopupMenuButton<String>(
                // ✅ নির্বাচিত আইটেম হাইলাইট হবে
                initialValue: selectedCategory,

                // ✅ মেনু ফিল্ডের ঠিক নিচে ওপেন হবে
                position: PopupMenuPosition.under,

                // ✅ সামান্য গ্যাপ
                offset: Offset(0, 4.h),

                // ✅ মেনুর চওড়া = ফিল্ডের চওড়া
                constraints: BoxConstraints(
                  minWidth: box.maxWidth,
                ),

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
                        padding: EdgeInsets.symmetric(
                          vertical: 10.h,
                          horizontal: 8.w,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AllColor.brand2_light
                              : Colors.white,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Text(
                          value,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: isSelected ? Colors.white : Colors.black,
                            fontWeight: FontWeight.w400,
                            fontFamily: "OpenText"
                          ),
                        ),
                      ),
                    );
                  }).toList();
                },

                // ⛔ পুরনো negative offset মুছে দেওয়া হলো

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.r),
                  side: BorderSide(
                    color: AllColor.brand2_light,
                    width: 1.0,
                  ),
                ),

                // ট্রিগার (আগের মতোই)
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
                            color: selectedCategory == null
                                ? AllColor.grey
                                : Colors.black,
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
              );
            },
          ),
        ),
      ],
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
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                  fontFamily: "OpenText"
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
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.red,
                    fontFamily: "OpenText"
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
  final VoidCallback onSubmit;
  const ReviewForm({super.key, required this.onSubmit});

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
        Row(
          children: [
            Text(
              "Ratings",
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            10.horizontalSpace,
            StarRating(
              rating: rating.toDouble(),
              color: AllColor.brand2_light,
              size: 20.r,
              onRatingChanged: (r) => setState(() => rating = r.toInt()),
            ),
          ],
        ),
        16.verticalSpace,
        Text(
          "Message",
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        6.verticalSpace,
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
        ElevatedButton(
          onPressed: widget.onSubmit, // ✅ প্যারেন্টের ফাংশন কল হবে
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFD8FF3F),
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


class ReviewCard extends StatelessWidget {
  final String name;
  final double rating;
  final String comment;
  final bool isYou;

  const ReviewCard({
    super.key,
    required this.name,
    required this.rating,
    required this.comment,
    this.isYou = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         10.verticalSpace,
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.person_outline,
                  size: 20, color: Colors.black54),
              6.horizontalSpace,
              Text(
                isYou ? "You" : name,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AllColor.black,
                  fontFamily: "OpenText"
                ),
              ),
              6.horizontalSpace,

              /// --- Stars ---
              Row(
                children: List.generate(5, (i) {
                  final filled = i < rating;
                  return Icon(
                    filled ? Icons.star : Icons.star_border,
                    size: 16.sp,
                    color: const Color(0xFFB8A9F5),
                  );
                }),
              ),
              4.horizontalSpace,
              Text(
                rating.toStringAsFixed(0),
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AllColor.black,
                  fontWeight: FontWeight.w400,
                  fontFamily: "OpenText"
                ),
              ),
            ],
          ),

          10.verticalSpace,

          /// --- Comment box ---
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              comment,
              style: TextStyle(
                fontSize: 14.sp,
                color: AllColor.black,
                height: 1.3,
                fontFamily: "OpenText"
              ),
            ),
          ),
        ],
      ),
    );
  }
}
