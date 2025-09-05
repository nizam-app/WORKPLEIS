import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/image_control/image_path.dart';
import 'package:workpleis/features/home/screen/post_a_job.dart';
import 'package:workpleis/features/security/screen/security_faq_screen.dart';
import 'package:workpleis/features/security/screen/security_screen.dart';
import 'package:workpleis/features/verification/screen/verification_screen.dart';
import '../../../core/constants/color_control/all_color.dart';
import '../widget/custom_category_type.dart';
import '../widget/custom_filter_chips.dart';
import '../widget/custom_job_posts.dart';
import '../widget/custom_search_box_bottom.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const routeName = '/homeScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: CustomTopBar(),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: AllColor.appBar,
                child: Column(
              children: [
                CustomHomeTest(),
                SizedBox(height: 10.h),
                CustomJobButtons(),
                SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _statsCard("50k+", "Posted Jobs", Icons.trending_up),
                    _statsCard("25k+", "Users", Icons.people),
                    _statsCard("4.8", "Users", Icons.star),
                  ],
                ),
                SizedBox(height: 15.h,)
              ],
            )),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  SizedBox(height: 20.h),
                  CustomSearchBoxBottom(),
                  SizedBox(height: 10.h),
                  CustomCategoryType(),
                  SizedBox(height: 10.h),
                  CustomFilterChips(),
                  SizedBox(height: 15.h),
                  // ===== Recent Job Posts =====
                  JobListScreen(),
                  SizedBox(height: 10),
                  CustomHowITWorkTest(),

                  HowItWorksCard(
                    icon: Icons.search,
                    title: "Post a job",
                    subtitle:
                    "Share what you need done, add details, and set your budget.",
                    onTap: () {},
                  ),
                  HowItWorksCard(
                    icon: Icons.group,
                    title: "Get Offers",
                    subtitle:
                    "Skilled job seekers respond with quotes and availability.",
                  ),
                  HowItWorksCard(
                    icon: Icons.verified,
                    title: "Choose with Confidence",
                    subtitle: "Compare profiles, past reviews, and skills.",
                  ),
                  HowItWorksCard(
                    icon: Icons.check_circle,
                    title: "Work Completed",
                    subtitle:
                    "Get your task done and pay securely through our platform.",
                  ),
                ],
              ),
            ),


          ],
        ),
      ),
    );
  }
}

class CustomTopBar extends StatelessWidget implements
    PreferredSizeWidget {
  const CustomTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AllColor.appBar, // dark background
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 🔹 Left Menu Icon
          // IconButton(
          //   onPressed: () {

          //   },
          //   icon: const Icon(Icons.view_headline_rounded, color: AllColor.white),
          // ),

          // 🔹 Center Logo (Workpleis Image)
          Expanded(
            child: Center(
              child: Image.asset(
                ImagePath.logoColorText, // তোমার Workpleis logo image path
                height: 30.h,
                fit: BoxFit.contain,
              ),
            ),
          ),

          // 🔹 Right Icons
          Row(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.notifications_none,
                      color: AllColor.white,
                    ),
                  ),
                  Positioned(
                    right: 10,
                    top: 10,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AllColor.logoColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.chat_bubble_outline,
                  color: AllColor.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.h);
}

class CustomHomeTest extends StatelessWidget {
  const CustomHomeTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Get Work Done
            Text(
              "Get Work Done",
              style: TextStyle(
                fontSize: 28.sp,
                fontWeight: FontWeight.w900,
                color: AllColor.white,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 10.h),

            // Create Opportunities
            Text(
              "Create Opportunities",
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
                color: AllColor.allcolor,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 10.h),

            // Grow Together
            Text(
              "Grow Together",
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w800,
                color: AllColor.white,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 20.h),

            // Description
            Text(
              "Australia's trusted marketplace \n connecting skilled Workpeers with \n people who need things done.",
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                color: AllColor.white,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  Widget _drawerItem({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    Color? color,
  }) {
    return ListTile(
      leading: Icon(icon, color: color ?? AllColor.black, size: 22.sp),
      title: Text(
        text,
        style: TextStyle(
          fontSize: 15.sp,
          color: color ?? AllColor.black,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shadowColor: Colors.white,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Header Section with Background Color
            Container(
              width: double.infinity,
              color: AllColor.appBar, // <-- ekhane background color set korlam
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    ImagePath.logoColorText,
                    height: 35.h,
                    fit: BoxFit.contain,
                  ),
                  IconButton(
                    icon: Icon(Icons.close, size: 26.sp, color: AllColor.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),

            // 🔹 Drawer content scrollable rakhlam
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                child: ListView(
                  children: [
                    SizedBox(height: 20.h),

                    // Main Section
                    Text(
                      "Main",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: AllColor.grey,
                      ),
                    ),
                    _drawerItem(icon: Icons.home, text: "Home", onTap: () {}),
                    _drawerItem(icon: Icons.search, text: "Browse Jobs", onTap: () {}),
                    _drawerItem(icon: Icons.folder_copy_outlined, text: "My Tasks", onTap: () {}),
                    _drawerItem(icon: Icons.message_outlined, text: "Messages", onTap: () {}),

                    SizedBox(height: 20.h),

                    // Account Section
                    Text(
                      "ACCOUNT",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: AllColor.grey,
                      ),
                    ),
                    _drawerItem(icon: Icons.person_outline, text: "Profile", onTap: () {}),
                    _drawerItem(icon: Icons.notifications_none, text: "Notifications", onTap: () {}),
                    _drawerItem(icon: Icons.credit_card_outlined, text: "Payments", onTap: () {}),
                    _drawerItem(icon: Icons.verified_user_outlined, text: "Verification", onTap: () {context.push(VerificationScreen.routeName);}),
                    _drawerItem(icon: Icons.security,
                        text: "security",
                        onTap: () {context.push(
                            SecurityScreen.routeName);}),
                    _drawerItem(icon: Icons.help_outline,
                        text: "Help & Support",
                        onTap: () {context.push(
                            SecurityFAQScreen.routeName);}),

                    Divider(),

                    _drawerItem(
                      icon: Icons.logout,
                      text: "Sign out",
                      onTap: () {},
                      color: AllColor.red,
                    ),

                    Divider(),
                    SizedBox(height: 30.h),

                    Center(
                      child: Text(
                        "Workpleis v1.0.0",
                        style: TextStyle(fontSize: 12.sp, color: AllColor.grey),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _statsCard(String value, String label, IconData icon) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
    width: 120.w,
    decoration: BoxDecoration(
      color: AllColor.black,
      borderRadius: BorderRadius.circular(12.r),
    ),
    child: Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AllColor.logoColor, size: 22.sp),
            SizedBox(width: 4.w),
            Text(
              value,
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
                color: AllColor.logoColor,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: TextStyle(fontSize: 11.sp, color: AllColor.white),
        ),
      ],
    ),
  );
}







class CustomJobButtons extends StatelessWidget {
  const CustomJobButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ==== Post a Job ====
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.h),
          child: GestureDetector(
            onTap: (){context.push(PostJobScreen.routeName);},
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 14.h),
              decoration: BoxDecoration(
                color: AllColor.allcolor, // Background color
                borderRadius: BorderRadius.circular(40.r), // rounded shape
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_circle_outline,
                    color: AllColor.black,
                    size: 18.sp,
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    "Post a Job",
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: AllColor.black
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        SizedBox(height: 14.h),

        // ==== Find Work ====
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.h),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 14.h),
            decoration: BoxDecoration(
              color: AllColor.white,
              borderRadius: BorderRadius.circular(40.r),
              border: Border.all(color: AllColor.logoColor, width: 1.2), // outline
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.search, color: AllColor.black, size: 18.sp),
                SizedBox(width: 6.w),
                Text(
                  "Find Work",
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: AllColor.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}



class CustomHowITWorkTest extends StatelessWidget {
  const CustomHowITWorkTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Get Work Done
            Text(
              "How it work",
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w900,
                color: AllColor.white,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 10.h),

            Text(
              "Simple steps to get your work done \nor start earning",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: AllColor.black87,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class HowItWorksCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const HowItWorksCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // optional tap
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 6.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.black87, // dark background
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.greenAccent), // outline like image
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(icon, color: Colors.black87, size: 20.sp),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    subtitle,
                    style: TextStyle(color: Colors.white70, fontSize: 12.sp),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
