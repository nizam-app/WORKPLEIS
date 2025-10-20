// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:go_router/go_router.dart';
// import 'package:tabler_icons/tabler_icons.dart';
// import 'package:workpleis/core/constants/color_control/all_color.dart';
// import 'package:workpleis/features/account/screen/account_screen.dart';
// import 'package:workpleis/features/home/screen/Service_home_screen.dart';
// import 'package:workpleis/features/message/screen/chat_screen.dart';
//
// import '../../account/screen/client_account.dart';
// import '../../home/screen/client_home_screen.dart';
// import '../../home/screen/see_all_jobs_screen.dart';
// import '../../jobs/screen/service_jobs.dart';
// import '../../projects/screen/project_screen.dart';
// import '../../verification/screen/verification_screen.dart';
// import '../logic/botton_nav_bar_controller.dart';
//
//
//
// class ServiceBottomNavBar extends ConsumerWidget {
//   ServiceBottomNavBar({super.key, required this.child});
//   final Widget child;
//
//   static const String routeName = '/ServiceBottomNavBar';
//
//   final List<IconData> _selectedIcons = const [
//     Icons.home,
//     Icons.folder_open,
//     Icons.business_center,
//     Icons.chat_bubble,
//     Icons.person,
//   ];
//
//   final List<IconData> _unselectedIcons = const [
//     Icons.home_outlined,
//     Icons.folder_open,
//     Icons.business_center_outlined,
//     Icons.chat_bubble_outline,
//     Icons.person_outline,
//   ];
//
//   final List<String> _labels = const [
//     "Home",
//     "Jobs",
//     "Project",
//     "Messages",
//     "Account",
//   ];
//
//   final List<String> _routes = const [
//     ServiceHomeScreen.routeName,
//     ServiceJobs.routeName,
//     ProjectScreen.routeName,
//     ChatScreen.routeName,
//     AccountOverviewClientScreen.routeName
//   ];
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final selectedIndex = ref.watch(selectedIndexProvider);
//
//     return Scaffold(
//       body: child, // ✅ Router theke asha child render hobe
//       bottomNavigationBar: Container(
//         padding: EdgeInsets.symmetric(vertical: 12.h),
//         decoration: BoxDecoration(
//           color: AllColor.white,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(20.r),
//             topRight: Radius.circular(20.r),
//           ),
//           border: Border.all(
//             color: AllColor.borderColor,
//             width: 1.5,
//           ),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: List.generate(_labels.length, (index) {
//             final isSelected = selectedIndex == index;
//             return InkWell(
//               onTap: () {
//                 ref.read(selectedIndexProvider.notifier).state = index;
//                 context.go(_routes[index]); // ✅ route change via go_router
//               },
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Icon(
//                     isSelected ? _selectedIcons[index] : _unselectedIcons[index],
//                     size: 30.sp,
//                     color:isSelected ? AllColor.brand2_light: AllColor.black,
//                   ),
//                   SizedBox(height: 3.h),
//                   Text(
//                     _labels[index],
//                     style: TextStyle(
//                       fontSize: 12.sp,
//                       fontWeight:
//                       isSelected ? FontWeight.bold : FontWeight.w400,
//                       color:isSelected ? AllColor.brand2_light: AllColor.black,
//                     ),
//                   ),
//                   SizedBox(height: 5.h),
//                 ],
//               ),
//             );
//           }),
//         ),
//       ),
//     );
//   }
// }
