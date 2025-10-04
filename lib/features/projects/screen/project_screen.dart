import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/core/widget/global_app_bar.dart';
import 'package:workpleis/features/projects/screen/special_request_screen.dart';

class ProjectScreen extends StatelessWidget {
  const ProjectScreen({super.key});
  static const routeName = "/projectScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppbar(text: "Project"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Header
            Text(
              "Got a Challenge too Complex\nfor the marketplace?",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: AllColor.black,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              "Australia’s trusted marketplace connecting skilled Workpeers\nwith people who need things done.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.sp,
                color: AllColor.black87,
              ),
            ),
            SizedBox(height: 20.h),

            // Badges
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 10.w,
              runSpacing: 10.h,
              children: const [
                _InfoBadge(icon: Icons.lock, text: "Confidentiality"),
                _InfoBadge(icon: Icons.security, text: "Escrow Protected"),
                _InfoBadge(icon: Icons.timer, text: "24h Response"),
              ],
            ),
            SizedBox(height: 20.h),

            // Buttons
            _ActionButton(text: "Start a Special Request"),
            SizedBox(height: 12.h),
            _ActionButton(text: "Talk to Manager"),
            SizedBox(height: 30.h),

            // How it Works Section
            Text(
              "How it works",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: AllColor.black,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              "Simple steps to get your work done\nor start earning",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12.sp, color: AllColor.black87),
            ),
            SizedBox(height: 20.h),

            // Step Cards
            const _StepCard(
              icon: Icons.check_circle_outline,
              title: "Submit",
              subtitle: "Share what you need done, add details, and set your budget.",
            ),
            const _StepCard(
              icon: Icons.people_alt_outlined,
              title: "Dedicated Review",
              subtitle: "Skilled job seekers respond with quotes and availability.",
            ),
            const _StepCard(
              icon: Icons.verified_outlined,
              title: "Secure Delivery",
              subtitle: "Compare profiles, past reviews, and skills.",
            ),
          ],
        ),
      ),
    );
  }
}

/* ================== BADGE ================== */
class _InfoBadge extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoBadge({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AllColor.black,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16.sp, color: AllColor.white),
          SizedBox(width: 6.w),
          Text(
            text,
            style: TextStyle(fontSize: 12.sp, color: AllColor.white),
          ),
        ],
      ),
    );
  }
}

/* ================== BUTTON ================== */
class _ActionButton extends StatelessWidget {
  final String text;
  const _ActionButton({required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AllColor.black,
          padding: EdgeInsets.symmetric(vertical: 14.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        onPressed: () {context.push(ProjectSetupScreen.routeName);},
        child: Text(
          text,
          style: TextStyle(fontSize: 13.sp, color: AllColor.white),
        ),
      ),
    );
  }
}

/* ================== STEP CARD ================== */
class _StepCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _StepCard({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 14.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AllColor.black, // dark background
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: AllColor.borderColor.withOpacity(0.3),
            blurRadius: 6,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon in rounded box
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: AllColor.white,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(icon, size: 20.sp, color: AllColor.borderColor),
          ),
          SizedBox(width: 12.w),

          // Title + Subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                    color: AllColor.white,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: AllColor.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
