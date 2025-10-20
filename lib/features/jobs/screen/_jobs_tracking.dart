// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:workpleis/core/constants/color_control/all_color.dart';
// import 'package:workpleis/core/widget/global_app_bar.dart';
//
// class JobsTracking extends StatelessWidget {
//   final String status;
//   const JobsTracking({super.key, required this.status});
//   static const routeName = "/jobsTracking";
//
//   int _getStepIndex() {
//     switch (status) {
//       case "Assigned":
//         return 1;
//       case "In Progress":
//         return 2;
//       case "Delivered":
//         return 3;
//       case "Completed":
//         return 4;
//       default:
//         return 1;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final currentStep = _getStepIndex();
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: GlobalAppbar(text: "Job Tracking"),
//
//       bottomNavigationBar: status != "Completed"
//           ? Padding(
//         padding: EdgeInsets.all(16.w),
//         child: ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: AllColor.brand2_light,
//             minimumSize: Size(double.infinity, 48.h),
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12.r)),
//           ),
//           onPressed: () {
//             _showActionDialog(context, status);
//           },
//           child: Text("Track Job",
//               style:
//               TextStyle(fontSize: 15.sp, color: Colors.white)),
//         ),
//       )
//           : null,
//
//       body: Padding(
//         padding: EdgeInsets.all(16.w),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // 🔹 Order tracking progress
//             Container(
//               padding: EdgeInsets.all(14.w),
//               decoration: BoxDecoration(
//                 border: Border.all(color: AllColor.grey300),
//                 borderRadius: BorderRadius.circular(12.r),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text("Order Tracking",
//                       style: TextStyle(
//                           fontSize: 14.sp,
//                           fontWeight: FontWeight.w600,
//                           color: AllColor.black)),
//                   SizedBox(height: 12.h),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: List.generate(4, (i) {
//                       final step = i + 1;
//                       final isActive = step <= currentStep;
//                       return Column(
//                         children: [
//                           CircleAvatar(
//                             radius: 14.r,
//                             backgroundColor: isActive
//                                 ? const Color(0xFFD0EF3D)
//                                 : Colors.white,
//                             child: Text(
//                               "$step",
//                               style: TextStyle(
//                                 color:
//                                 isActive ? AllColor.black : AllColor.grey,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 5.h),
//                           Text(
//                             ["Assigned", "In Progress", "Delivered", "Completed"]
//                             [i],
//                             style: TextStyle(
//                                 fontSize: 12.sp,
//                                 color: isActive
//                                     ? AllColor.black
//                                     : AllColor.grey300),
//                           ),
//                         ],
//                       );
//                     }),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 20.h),
//
//             // 🔹 Job card (same design)
//             Container(
//               padding: EdgeInsets.all(14.w),
//               decoration: BoxDecoration(
//                 border: Border.all(color: AllColor.grey300),
//                 borderRadius: BorderRadius.circular(12.r),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text("Deliver something for me",
//                       style: TextStyle(
//                           fontSize: 15.sp, fontWeight: FontWeight.w600)),
//                   SizedBox(height: 6.h),
//                   Text("\$50 • Suburban Area • Jan 10, 2024",
//                       style:
//                       TextStyle(fontSize: 12.sp, color: AllColor.grey600)),
//                   SizedBox(height: 8.h),
//                   Text(
//                     "Complete garden makeover with new plants, pathway, and irrigation system.",
//                     style: TextStyle(
//                       fontSize: 12.sp,
//                       color: AllColor.grey700,
//                       height: 1.4,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _showActionDialog(BuildContext context, String status) {
//     if (status == "Delivered") {
//       showDialog(
//         context: context,
//         builder: (ctx) => AlertDialog(
//           title: const Text("Completed Details"),
//           content: const Text(
//               "Please review the service provider’s work and approve or request modification."),
//           actions: [
//             TextButton(
//                 onPressed: () => Navigator.pop(ctx),
//                 child: const Text("Cancel")),
//             ElevatedButton(
//                 onPressed: () {
//                   Navigator.pop(ctx);
//                   _showCompletionMessage(context);
//                 },
//                 child: const Text("Approve")),
//             OutlinedButton(
//                 onPressed: () => Navigator.pop(ctx),
//                 child: const Text("Request Modification")),
//           ],
//         ),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Status: $status")),
//       );
//     }
//   }
//
//   void _showCompletionMessage(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (ctx) => AlertDialog(
//         content: const Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Icon(Icons.check_circle, color: Colors.green, size: 40),
//             SizedBox(height: 12),
//             Text("Job has been completed successfully!"),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
//
//
// // import 'package:flutter/material.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';
// // import 'package:workpleis/core/constants/color_control/all_color.dart';
// // import 'package:workpleis/core/widget/global_app_bar.dart';
// //
// // class JobsTracking extends StatelessWidget {
// //   final String status; // Assigned, In Progress, Delivered, Completed
// //
// //   const JobsTracking({super.key, required this.status});
// //   static const routeName = "/jobsTracking";
// //
// //   int _getStepIndex() {
// //     switch (status) {
// //       case "Assigned":
// //         return 1;
// //       case "In Progress":
// //         return 2;
// //       case "Delivered":
// //         return 3;
// //       case "Completed":
// //         return 4;
// //       default:
// //         return 1;
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final currentStep = _getStepIndex();
// //
// //     return Scaffold(
// //       backgroundColor: Colors.white,
// //       appBar: GlobalAppbar(text: "Job Tracking"),
// //       body: Padding(
// //         padding: EdgeInsets.all(16.w),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             // 🔹 Order Tracking Box
// //             Container(
// //               width: double.infinity,
// //               padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
// //               decoration: BoxDecoration(
// //                 border: Border.all(color: AllColor.grey300, width: 1.w,),
// //                 borderRadius: BorderRadius.circular(12.r),
// //               ),
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Text(
// //                     "Order Tracking",
// //                     style: TextStyle(
// //                         fontSize: 14.sp,
// //                         fontWeight: FontWeight.w600,
// //                         color: Colors.black87),
// //                   ),
// //                   SizedBox(height: 12.h),
// //                   Row(
// //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                     children: List.generate(4, (index) {
// //                       final step = index + 1;
// //                       final isActive = step <= currentStep;
// //
// //                       return Column(
// //                         children: [
// //                           Container(
// //                             width: 30.w,
// //                             height: 30.w,
// //                             alignment: Alignment.center,
// //                             decoration: BoxDecoration(
// //                               color: isActive
// //                                   ? const Color(0xFFD0EF3D)
// //                                   : Colors.white,
// //                               border: Border.all(
// //                                 color: isActive
// //                                     ? const Color(0xFFD0EF3D)
// //                                     : Colors.grey,
// //                                 width: 2,
// //                               ),
// //                               shape: BoxShape.circle,
// //                             ),
// //                             child: isActive && step == 1
// //                                 ? const Icon(Icons.check,
// //                                 size: 18, color: AllColor.white)
// //                                 : Text(
// //                               "$step",
// //                               style: TextStyle(
// //                                 fontWeight: FontWeight.w600,
// //                                 color: isActive
// //                                     ? AllColor.black
// //                                     : AllColor.grey,
// //                               ),
// //                             ),
// //                           ),
// //                           SizedBox(height: 6.h),
// //                           Text(
// //                             ["Assigned", "In Progress", "Delivered", "Completed"]
// //                             [index],
// //                             style: TextStyle(
// //                               fontSize: 12.sp,
// //                               color: isActive
// //                                   ? AllColor.black
// //                                   : AllColor.grey300,
// //                               fontWeight: FontWeight.w500,
// //                             ),
// //                           ),
// //                         ],
// //                       );
// //                     }),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //             SizedBox(height: 20.h),
// //
// //             // 🔹 Job Card
// //             Container(
// //               padding: EdgeInsets.all(14.w),
// //               decoration: BoxDecoration(
// //                 color: Colors.white,
// //                 borderRadius: BorderRadius.circular(12.r),
// //                 border: Border.all(color: AllColor.grey300, width: 1.w),
// //                 boxShadow: [
// //                   BoxShadow(
// //                     color: Colors.black.withOpacity(0.05),
// //                     blurRadius: 6,
// //                     offset: const Offset(0, 3),
// //                   )
// //                 ],
// //               ),
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   // title + status badge
// //                   Row(
// //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                     children: [
// //                       Text(
// //                         "Deliver something for me",
// //                         style: TextStyle(
// //                           fontSize: 15.sp,
// //                           fontWeight: FontWeight.w600,
// //                           color: Colors.black87,
// //                         ),
// //                       ),
// //                       Container(
// //                         padding:
// //                         EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
// //                         decoration: BoxDecoration(
// //                           color: const Color(0xFFE8E2F4),
// //                           borderRadius: BorderRadius.circular(20.r),
// //                         ),
// //                         child: Text(
// //                           status,
// //                           style: TextStyle(
// //                             fontSize: 11.sp,
// //                             color: const Color(0xFF7568A9),
// //                             fontWeight: FontWeight.w600,
// //                           ),
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                   SizedBox(height: 6.h),
// //
// //                   // service provider
// //                   Row(
// //                     children: [
// //                       const Icon(Icons.person_outline, size: 14),
// //                       SizedBox(width: 4.w),
// //                       Text(
// //                         "Green Thumb Services",
// //                         style: TextStyle(
// //                             fontSize: 12.sp, color: Colors.grey.shade700),
// //                       ),
// //                     ],
// //                   ),
// //                   SizedBox(height: 6.h),
// //
// //                   // price + location + date
// //                   Row(
// //                     children: [
// //                       Text(
// //                         "\$50",
// //                         style: TextStyle(
// //                           fontSize: 13.sp,
// //                           fontWeight: FontWeight.w600,
// //                           color: Colors.black,
// //                         ),
// //                       ),
// //                       SizedBox(width: 12.w),
// //                       const Icon(Icons.location_on_outlined,
// //                           size: 14, color: Colors.grey),
// //                       Text(
// //                         " Suburban Area",
// //                         style: TextStyle(
// //                             fontSize: 12.sp, color: Colors.grey.shade700),
// //                       ),
// //                       const Spacer(),
// //                       const Icon(Icons.calendar_today_outlined,
// //                           size: 14, color: Colors.grey),
// //                       Text(
// //                         " Jan 10, 2024",
// //                         style: TextStyle(
// //                             fontSize: 12.sp, color: Colors.grey.shade700),
// //                       ),
// //                     ],
// //                   ),
// //                   SizedBox(height: 10.h),
// //
// //                   // description
// //                   Text(
// //                     "Complete garden makeover with new plants, pathway, and irrigation system.",
// //                     style: TextStyle(
// //                       fontSize: 12.sp,
// //                       color: Colors.grey.shade800,
// //                       height: 1.4,
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
