import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/features/account/screen/account_screen.dart';
import 'package:workpleis/features/home/screen/home_screen.dart';
import 'package:workpleis/features/message/screen/message_screen.dart';

import '../../home/screen/tasks_screen.dart';
import '../../projects/screen/project_screen.dart';
import '../../verification/screen/verification_screen.dart';
import '../logic/botton_nav_bar_controller.dart';



class BottomNavBar extends ConsumerWidget {
   BottomNavBar({super.key, required this.child});
  final Widget child;

  static const String routeName = '/BottomNavBar';

  final List<IconData> _selectedIcons = const [
    Icons.home,
    Icons.folder,
    Icons.business_center,
    Icons.chat_bubble,
    Icons.person,
  ];

  final List<IconData> _unselectedIcons = const [
    Icons.home_outlined,
    Icons.folder_outlined,
    Icons.business_center_outlined,
    Icons.chat_bubble_outline,
    Icons.person_outline,
  ];

  final List<String> _labels = const [
    "Home",
    "Task",
    "Project",
    "Messages",
    "Account",
  ];

  final List<String> _routes = const [
    HomeScreen.routeName,
    TasksScreen.routeName,
    ProjectScreen.routeName,
   MessageScreen.routeName,
    AccountOverviewScreen.routeName
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedIndexProvider);

    return Scaffold(
      body: child, // ✅ Router theke asha child render hobe
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
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(_labels.length, (index) {
            final isSelected = selectedIndex == index;
            return InkWell(
              onTap: () {
                ref.read(selectedIndexProvider.notifier).state = index;
                context.go(_routes[index]); // ✅ route change via go_router
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isSelected ? _selectedIcons[index] : _unselectedIcons[index],
                    size: 30.sp,
                    color:isSelected ? AllColor.brand2_light: AllColor.black,
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    _labels[index],
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight:
                      isSelected ? FontWeight.bold : FontWeight.w400,
                      color:isSelected ? AllColor.brand2_light: AllColor.black,
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
