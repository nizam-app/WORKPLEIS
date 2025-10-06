import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/core/widget/global_app_bar.dart';

class ProjectScreen extends ConsumerWidget {
  const ProjectScreen({super.key});
  static const routeName = "/projectScreen";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedStatus = ref.watch(jobStatusProvider);

    return Scaffold(
      appBar: GlobalAppbar(text: "Project"),
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
      "Completed",
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
                      .copyWith(fontWeight: FontWeight.w600),
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
          /// 🔹 Header Row (title + status chip)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                    fontFamily: "bodyFont"
                  ),
                ),
              ),
              Container(
                padding:
                EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AllColor.primary,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                      fontFamily: "bodyFont"
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),

          /// 🔹 Details
          Row(
            children: [
              const Icon(Icons.local_shipping_outlined,
                  size: 18, color: Color(0xFF7A6FA2)),
              SizedBox(width: 6.w),
              Text(
                time,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: const Color(0xFF7A6FA2),
                    fontFamily: "bodyFont"
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),

          Row(
            children: [
              const Icon(Icons.request_quote_outlined,
                  size: 18, color: Color(0xFF7A6FA2)),
              SizedBox(width: 6.w),
              Text(
                budget,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: const Color(0xFF7A6FA2),
                    fontFamily: "bodyFont"
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),

          Row(
            children: [
              const Icon(Icons.call_outlined,
                  size: 18, color: Color(0xFF7A6FA2)),
              SizedBox(width: 6.w),
              Expanded(
                child: Text(
                  period,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: const Color(0xFF7A6FA2),
                  ),
                ),
              ),
              Text(
                price,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
