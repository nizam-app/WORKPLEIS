import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workpleis/core/constants/image_control/image_path.dart';

import '../../../core/constants/color_control/all_color.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const routeName = '/homeScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: CustomTopBar(),
      drawer: CustomDrawer(),
      body: Column(
        children: [
          CustomHomeTest(),
        ],
      ),
    );
  }
}

class CustomTopBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor:  AllColor.appBar, // dark background
      elevation: 0,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 🔹 Left Menu Icon
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.view_headline_rounded, color: AllColor.white),
          ),

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
                    icon: const Icon(Icons.notifications_none,
                        color: AllColor.white),
                  ),
                  Positioned(
                    right: 10,
                    top: 10,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AllColor.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                  )
                ],
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.chat_bubble_outline, color: AllColor.white),
              ),
            ],
          )
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
                color: AllColor.black,
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
                color: AllColor.green, // তোমার Color class থেকে lime use করো
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
                color: AllColor.black87, // তোমার Color class থেকে grey use করো
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
                color: AllColor.black54,
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
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo + Close Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    "assets/logo.png", // তোমার logo path বসাও
                    height: 40.h,
                  ),
                  IconButton(
                    icon: Icon(Icons.close, size: 26.sp, color: AllColor.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),

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

              _drawerItem(
                  icon: Icons.home, text: "Home", onTap: () {/* TODO */}),
              _drawerItem(
                  icon: Icons.search,
                  text: "Browse Jobs",
                  onTap: () {/* TODO */}),
              _drawerItem(
                  icon: Icons.folder_copy_outlined,
                  text: "My Tasks",
                  onTap: () {/* TODO */}),
              _drawerItem(
                  icon: Icons.message_outlined,
                  text: "Messages",
                  onTap: () {/* TODO */}),

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

              _drawerItem(
                  icon: Icons.person_outline,
                  text: "Profile",
                  onTap: () {/* TODO */}),
              _drawerItem(
                  icon: Icons.notifications_none,
                  text: "Notifications",
                  onTap: () {/* TODO */}),
              _drawerItem(
                  icon: Icons.credit_card_outlined,
                  text: "Payments",
                  onTap: () {/* TODO */}),
              _drawerItem(
                  icon: Icons.help_outline,
                  text: "Help & Support",
                  onTap: () {/* TODO */}),

              Spacer(),

              Divider(),

              // Sign out
              _drawerItem(
                icon: Icons.logout,
                text: "Sign out",
                onTap: () {/* TODO: logout */},
                color: AllColor.red,
              ),

              Divider(),

              // Version Text
              Center(
                child: Text(
                  "Workpleis v1.0.0",
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AllColor.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
