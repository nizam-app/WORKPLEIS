import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/features/home/screen/Service_home_screen.dart';

// Screens
import '../../home/screen/client_home_screen.dart';
import '../../jobs/screen/service_jobs_offers.dart';
import '../../projects/screen/project_screen.dart';
import '../../message/screen/chat_screen.dart';
import '../../account/screen/client_account.dart';
import '../../home/screen/see_all_jobs_screen.dart';
import '../logic/botton_nav_bar_controller.dart';

class BottomNavBar extends ConsumerStatefulWidget {
  const BottomNavBar({super.key, required this.child});
  final Widget child;

  static const String routeName = '/BottomNavBar';

  @override
  ConsumerState<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends ConsumerState<BottomNavBar> {
  String _role = "client"; // default

  @override
  void initState() {
    super.initState();
    _loadRole();
  }

  Future<void> _loadRole() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _role = prefs.getString("role") ?? "client";
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = ref.watch(selectedIndexProvider);

    /// CLIENT NAVIGATION
    final clientIcons = [
      [Icons.home, Icons.home_outlined],
      [Icons.folder_copy, Icons.folder_copy_outlined],
      [Icons.chat_bubble, Icons.chat_bubble_outline],
      [Icons.person, Icons.person_outline],
    ];

    final clientLabels = [
      "Home",
      "Projects",
      "Messages",
      "Account",
    ];

    final clientRoutes = [
      HomeScreen.routeName,
      ProjectScreen.routeName,
      ChatScreen.routeName,
      AccountOverviewClientScreen.routeName,
    ];

    /// PROVIDER NAVIGATION
    final providerIcons = [
      [Icons.home, Icons.home_outlined],
      [Icons.work, Icons.work_outline],
      [Icons.business_center, Icons.business_center_outlined],
      [Icons.chat_bubble, Icons.chat_bubble_outline],
      [Icons.person, Icons.person_outline],
    ];

    final providerLabels = [
      "Home",
      "Job",
      "My Offers",
      "Messages",
      "Account",
    ];

    final providerRoutes = [
      ServiceHomeScreen.routeName,
      SeeAllJobsScreen.routeName,
      JobsOffers.routeName, // You can replace with your offers screen
      ChatScreen.routeName,
      AccountOverviewClientScreen.routeName,
    ];

    /// Determine which set to use
    final isClient = _role.toLowerCase() == "client";
    final icons = isClient ? clientIcons : providerIcons;
    final labels = isClient ? clientLabels : providerLabels;
    final routes = isClient ? clientRoutes : providerRoutes;

    return Scaffold(
      body: widget.child,
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: AllColor.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
          border: Border.all(
            color: AllColor.borderColor,
            width: 1.2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(labels.length, (index) {
            final isSelected = selectedIndex == index;
            return InkWell(
              onTap: () {
                ref.read(selectedIndexProvider.notifier).state = index;
                context.go(routes[index]);
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isSelected ? icons[index][0] : icons[index][1],
                    size: 26.sp,
                    color: isSelected
                        ? AllColor.brand2_light
                        : AllColor.black,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    labels[index],
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight:
                      isSelected ? FontWeight.w600 : FontWeight.w400,
                      color: isSelected
                          ? AllColor.brand2_light
                          : AllColor.black,
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
