import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/core/widget/global_app_bar.dart';
import 'package:workpleis/core/widget/global_get_started_button.dart';
import 'package:workpleis/features/projects/widget/custom_back_next_buttons.dart';
import 'package:workpleis/features/tracking/client_offer_tracking/widget/custom_service_card.dart';
import 'package:workpleis/features/tracking/client_project_tracking/special_request_screen.dart';
import 'package:workpleis/features/tracking/client_project_tracking/special_request_screen3.dart';
import '../../projects/widget/custom_step_progress_section.dart';
import 'offer_tacking_screen3.dart';

class OfferTackingScreen2 extends StatelessWidget {
  const OfferTackingScreen2({super.key});
  static const routeName = "/offerTackingScreen2";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppbar(text: "Project"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomStepProgressSection(activeStep: 2),
            SizedBox(height: 20.h),
            CustomServiceCard(
              title: "Deliver something for me",
              status: "In Review",
              providerName: "Green Thumb Services",
              price: 50,
              location: "Suburban Area",
              date: "Jan 10, 2024",
              description:
              "Complete garden makeover with new plants, pathway, and irrigation system.",
              trakingID: 3,
              buttonText: "Delivery Order",
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (_) => const JobCompletedBottomSheet(),
                );
              },
            ),
            SizedBox(height: 25.h),
            // CustomBackNextButtons(
            //   onBack: () {
            //     context.pop();
            //   },
            //   onNext: () {
            //     context.push(OfferTackingScreen3.routeName);
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}

// =================== MODAL BOTTOM SHEET ===================

class JobCompletedBottomSheet extends StatelessWidget {
  const JobCompletedBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AllColor.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Job Completed",
                  style: theme.titleSmall?.copyWith(
                    color: AllColor.black,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close, color: AllColor.black, size: 22.sp),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            SizedBox(height: 4.h),
            Text(
              "Let the client know you've finished the work.",
              style: theme.titleMedium?.copyWith(
                color: AllColor.grey,
                fontSize: 13.sp,
              ),
            ),
            SizedBox(height: 20.h),

            // Completion Message
            Text(
              "Completion Message",
              style: theme.titleSmall?.copyWith(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.h),
            TextField(
              maxLines: 4,
              style: theme.bodyMedium,
              decoration: InputDecoration(
                hintText: "Describe what you have completed.",
                hintStyle: theme.titleMedium,
                filled: true,
                fillColor: AllColor.grey.withOpacity(0.2),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6.r),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                  vertical: 10.h,
                ),
              ),
            ),
            SizedBox(height: 20.h),

            // Attachments
            Text(
              "Attachments",
              style: theme.titleSmall?.copyWith(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10.h),

            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: AllColor.grey.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Center(
                      child: Text("  project_details.pdf",
                        style: theme.titleMedium?.copyWith(
                          color: AllColor.black.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                SizedBox(
                  height: 38.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AllColor.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      foregroundColor: AllColor.black,
                      padding: EdgeInsets.symmetric(horizontal: 18.w),
                    ),
                    onPressed: () {},
                    child: Text(
                      "Add",
                      style: theme.titleMedium?.copyWith(
                        color: AllColor.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),

            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: AllColor.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Center(
                      child: Text("  project_details.pdf",
                        style: theme.titleMedium?.copyWith(
                          color: AllColor.black.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.close, size: 22.sp, color: AllColor.black),
                ),
              ],
            ),
            SizedBox(height: 25.h),

            // Submit Button
            GlobalGetStartedButton(onTap: (){context.pop();},buttonName: "Submit", color: AllColor.primary,height: 40.h,),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
}