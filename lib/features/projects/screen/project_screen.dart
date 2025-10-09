import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/core/widget/global_app_bar.dart';
import 'package:workpleis/features/projects/screen/request_tracker.dart';
import 'package:workpleis/features/projects/screen/view_proposal_screen.dart';

class ProjectScreen extends ConsumerWidget {
  const ProjectScreen({super.key});
  static const routeName = "/projectScreen";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedStatus = ref.watch(jobStatusProvider);

    return Scaffold(
      appBar: GlobalAppbar(text: "My Projects"),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🔹 Filter tabs
            const JobStatusList(),
            SizedBox(height: 16.h),

            /// 🔹 Job list
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return JobCard(
                    title: "Deliver something for me",
                    status: selectedStatus,
                    time: "Immediate",
                    budget: "\$5,000–\$20,000",
                    period: "Afternoon (12PM–5PM)",
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
final jobStatusProvider = StateProvider<String>((ref) => "Submitted");

/// 🔹 Horizontal status selector
class JobStatusList extends ConsumerWidget {
  const JobStatusList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedStatus = ref.watch(jobStatusProvider);

    final statuses = [
      "Submitted",
      "Proposal Sent",
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
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: isSelected ? AllColor.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(30.r),
                border: Border.all(
                  color: const Color(0xff154E7B).withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Center(
                child: Text(
                  label,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w300),
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
    required this.time,
    required this.budget,
    required this.period,
    required this.price,
  });

  final String title;
  final String status;
  final String time;
  final String budget;
  final String period;
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
          /// Header (title + status chip)
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                    fontFamily: "bodyFont",
                  ),
                ),
              ),
              _StatusChip(text: status),
            ],
          ),
          SizedBox(height: 8.h),

          /// Details
          _DetailRow(icon: Icons.timer, text: time),
          SizedBox(height: 6.h),
          _DetailRow(icon: Icons.request_quote_outlined, text: budget),
          SizedBox(height: 6.h),
          _DetailRow(icon: Icons.call_outlined, text: period, expandable: true),
          SizedBox(height: 10.h),

          /// Bottom actions + price
          _BottomBar(status: status, price: price),
        ],
      ),
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
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
          color: Colors.black,
          fontFamily: "bodyFont",
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
        fontSize: 13.sp,
        color: const Color(0xFF7A6FA2),
        fontFamily: "bodyFont",
      ),
      overflow: TextOverflow.ellipsis,
    );
    return Row(
      children: [
        Icon(icon, size: 18, color: const Color(0xFF7A6FA2)),
        SizedBox(width: 6.w),
        if (expandable) Expanded(child: content) else content,
      ],
    );
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar({required this.status, required this.price});
  final String status;
  final String price;

  @override
  Widget build(BuildContext context) {
    final showButtons = status != "Submitted";

    final buttons = switch (status) {
      "Proposal Sent" => [
        _PillButton.purple("View Proposal", onTap: () {context.push(ViewProposalScreen.routeName);}),
      ],
      "In Progress" => [
        _PillButton.purple("Track Project", onTap: () {context.push(RequestTrackerScreen.routeName);}),
      ],
      "In Review" => [
        _PillButton.lime("View Details", onTap: () {}),
        SizedBox(width: 8.w),
        _PillButton.purple("Track Project", onTap: () {}), // ← both buttons
      ],
      "Delivered" => [
        _PillButton.lime("View Details", onTap: () {}),   // ← only this
      ],
      _ => <Widget>[],
    };

    if (!showButtons) {
      return Row(children: [
        const Spacer(),
        Text(price, style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500, color: Colors.black)),
      ]);
    }

    return Row(children: [
      Text(price, style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500, color: Colors.black)),
      const Spacer(),
      ...buttons,
    ]);
  }
}


class _PillButton extends StatelessWidget {
  const _PillButton._(this.label, this.bg, this.fg, {required this.onTap});
  final String label;
  final Color bg;
  final Color fg;
  final VoidCallback onTap;

  factory _PillButton.purple(String label, {required VoidCallback onTap}) =>
      _PillButton._(
        label,
         AllColor.borderColor, // শেডেড পার্পল (mock vibe)
        Colors.white,
        onTap: onTap,
      );

  factory _PillButton.lime(String label, {required VoidCallback onTap}) =>
      _PillButton._(
        label,
        AllColor.primary, // lime
        Colors.black,
        onTap: onTap,
      );

  @override
  Widget build(BuildContext context) {
    return Material(
      color: bg,
      borderRadius: BorderRadius.circular(22.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22.r),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: fg,
              fontFamily: "bodyFont",
            ),
          ),
        ),
      ),
    );
  }
}