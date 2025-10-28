import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/core/widget/global_app_bar.dart';
import '../../tracking/client_offer_tracking/offer_tacking_screen.dart';
import '../../proposal/screen/view_proposal_screen.dart';

class JobsScreen extends ConsumerWidget {
  const JobsScreen({super.key});
  static const routeName = "/jobsScreen";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedStatus = ref.watch(jobStatusProvider);
    final theme = Theme
        .of(context)
        .textTheme;
    return Scaffold(
      appBar: GlobalAppbar(text: "Jobs"),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const JobStatusList(),
            SizedBox(height: 16.h),

            Expanded(
              child: ListView.builder(
                itemCount: 6,
                itemBuilder: (context, index) {
                  return JobCard(
                    title: "Deliver something for me",
                    status: selectedStatus,
                    locations: "Topasham Me 04",
                    calender: "Today",
                    time: "Any Time",
                    price: "\$50",
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 🔹 Riverpod provider to track selected status
final jobStatusProvider = StateProvider<String>((ref) => "Open");

/// 🔹 Horizontal status selector
class JobStatusList extends ConsumerWidget {
  const JobStatusList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedStatus = ref.watch(jobStatusProvider);

    final statuses = [
      "Open",
      "Assigned",
      "In Progress",
      "In Review",
      "Delivered", // ← new
    ];

    return SizedBox(
      height: 40.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        itemCount: statuses.length,
        separatorBuilder: (_, __) => SizedBox(width: 10.w),
        itemBuilder: (context, index) {
          final label = statuses[index];
          final isSelected = label == selectedStatus;

          return GestureDetector(
            onTap: () {
              ref.read(jobStatusProvider.notifier).state = label;
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: isSelected ? AllColor.bgcolor  : Colors.transparent,
                borderRadius: BorderRadius.circular(30.r),
                border: Border.all(
                  color: const Color(0xff154E7B).withOpacity(0.2),
                  width: 1.w,
                ),
              ),
              child: Center(
                child: Text(
                  label,
                  style: TextStyle(
                      fontWeight: FontWeight.w200,
                      //color: isSelected? AllColor.white: AllColor.black ,
                      color: AllColor.black,
                      fontSize: 12.sp,
                      fontFamily: "headFont"),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// 🔹 Single job card widget
class JobCard extends StatelessWidget {
  const JobCard({
    super.key,
    required this.title,
    required this.status,
    required this.locations,
    required this.calender,
    required this.time,
    required this.price,
  });

  final String title;
  final String status;
  final String locations;
  final String calender;
  final String time;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 14.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(color: Colors.black.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    fontFamily: "bodyFont",
                  ),
                ),
              ),
              _StatusChip(text: status),
            ],
          ),

          // Text(
          //         title,
          //         style: TextStyle(
          //           fontSize: 16.sp,
          //           fontWeight: FontWeight.w700,
          //           fontFamily: "headFont",
          //         ),
          //       ),
          //
          // _StatusChip(text: status),

                     SizedBox(height: 8.h),

                    /// Details
                    _DetailRow(icon: Icons.location_on, text: locations),
                    SizedBox(height: 6.h),
                    _DetailRow(icon: Icons.calendar_today, text: calender, ),
                    SizedBox(height: 6.h),
                    _DetailRow(icon: Icons.schedule, text: time, ),
                     SizedBox(height: 10.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              JobPriceText(price: price),


              JobStatusAction(status: status),

              //_BottomBar(status: status, price: price),
            ],
          )

        ]
      )
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AllColor.primary, // lime chip (mock-এর মতো)
        borderRadius: BorderRadius.circular(8.r),
        //border: Border.all(color:Colors.black, width: 1)
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color:AllColor.black,
          fontFamily: "OpenText",
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.icon,
    required this.text,
    this.expandable = false,
  });
  final IconData icon;
  final String text;
  final bool expandable;

  @override
  Widget build(BuildContext context) {
    final content = Text(
      text,
      style: TextStyle(
        fontSize: 12.sp,
        color: AllColor.brand2_light,
        fontFamily: "OpenText",
        fontWeight: FontWeight.w400
      ),
      overflow: TextOverflow.ellipsis,
    );
    return Row(
      children: [

        Icon(icon, size: 18, color: AllColor.brand2_light),
        SizedBox(width: 6.w),
        if (expandable) Expanded(child: content) else content,
      ],
    );
  }
}



/// 🔹 Custom price widget
class JobPriceText extends StatelessWidget {
  final String price;
  const JobPriceText({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    return Text(
      price,
      style: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        color: AllColor.black87,
        fontFamily: "OpenText",
      ),
    );
  }
}

/// 🔹 Custom status action button widget
class JobStatusAction extends StatelessWidget {
  final String status;
  const JobStatusAction({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    // Track Job button depending on status
    final Widget? trackButton = switch (status) {
      "Open" => _PillButton.purple("View Offers",  onTap: () {
        context.push(ViewProposalScreen.routeName);
      }),
      "Assigned" => _PillButton.purple("Track Job", onTap: () {
        context.push(OfferTackingScreen.routeName);
      }),
      "In Progress" => _PillButton.purple("Track Job", onTap: () {
        context.push(OfferTackingScreen.routeName);
      }),
      "In Review" => _PillButton.lime("Track Job", onTap: () {
        context.push(OfferTackingScreen.routeName);
      }),
      "Delivered" => _PillButton.lime("Track Job", onTap: () {
        context.push(OfferTackingScreen.routeName);
      }),
      _ => null,
    };

    return trackButton ?? const SizedBox.shrink();
  }
}

/// 🔹 Reusable pill button
class _PillButton extends StatelessWidget {
  const _PillButton._(this.label, this.bg, this.fg, {required this.onTap});

  final String label;
  final Color bg;
  final Color fg;
  final VoidCallback onTap;

  factory _PillButton.purple(String label, {required VoidCallback onTap}) =>
      _PillButton._(
        label,
        AllColor.white,
        AllColor.brand2_light,
        onTap: onTap,
      );

  factory _PillButton.lime(String label, {required VoidCallback onTap}) =>
      _PillButton._(
        label,
        AllColor.grey,
        AllColor.brand2_light,
        onTap: onTap,

      );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AllColor.brand2_light,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: AllColor.white,
          fontFamily: "OpenText",
        ),
      ),
    ),
    );
  }
}


//
// class _BottomBar extends StatelessWidget {
//   const _BottomBar({required this.status, required this.price});
//   final String status;
//   final String price;
//
//   @override
//   Widget build(BuildContext context) {
//     // show button if not submitted
//     final showButtons = true;
//
//     // Track Job button depending on status
//     final Widget? trackButton = switch (status) {
//       "Open" => _PillButton.purple("View Offers", onTap: () {
//         context.push(ViewProposalScreen.routeName);
//       }),
//       "Assigned" => _PillButton.purple("Track Job", onTap: () {
//         context.push(OfferTackingScreen.routeName) ;
//       }),
//       "In Progress" => _PillButton.purple("Track Job", onTap: () {
//         // TODO: Add your navigation or logic here
//       }),
//       "In Review" => _PillButton.lime("Track Job", onTap: () {
//         // TODO: Add your navigation or logic here
//       }),
//       "Delivered" => _PillButton.lime("Track Job", onTap: () {
//         // TODO: Add your navigation or logic here
//       }),
//       _ => null,
//     };
//
//     return Padding(
//       padding: EdgeInsets.symmetric(),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           // Price text
//           // Text(
//           //   price,
//           //   style: TextStyle(
//           //     fontSize: 16.sp,
//           //     fontWeight: FontWeight.w500,
//           //     color: AllColor.black,
//           //   ),
//           // ),
//           if ( trackButton != null) trackButton,
//         ],
//       ),
//     );
//   }
// }
//
//
// class _PillButton extends StatelessWidget {
//   const _PillButton._(this.label, this.bg, this.fg, { required this.onTap});
//   final String label;
//   final Color bg;
//   final Color fg;
//   final VoidCallback onTap;
//
//   factory _PillButton.purple(String label, {required VoidCallback onTap}) =>
//       _PillButton._(
//         label,
//         AllColor.white, // শেডেড পার্পল (mock vibe)
//         AllColor.brand2_light,
//
//         onTap: onTap,
//       );
//
//   factory _PillButton.lime(String label, {required VoidCallback onTap}) =>
//       _PillButton._(
//         label,
//         AllColor.white , // lime
//         AllColor.brand2_light,
//         onTap: onTap,
//       );
//
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: bg,
//       borderRadius: BorderRadius.circular(22.r),
//       child: InkWell(
//         onTap: onTap,
//         borderRadius: BorderRadius.circular(22.r),
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
//           child: Text(
//             label,
//             style: TextStyle(
//               fontSize: 14.sp,
//               fontWeight: FontWeight.w600,
//               color: fg,
//               fontFamily: "bodyFont",
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//  }
