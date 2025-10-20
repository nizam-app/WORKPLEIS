import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
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
                color: isSelected ? AllColor.brand2_light : Colors.transparent,
                borderRadius: BorderRadius.circular(30.r),
                border: Border.all(
                  color: const Color(0xff154E7B).withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Center(
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w300,
                    color: isSelected ? AllColor.white : AllColor.black,
                  ),
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
          // SizedBox(height: 10.h),

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
        color: AllColor.white, // lime chip (mock-এর মতো)
        borderRadius: BorderRadius.circular(8.r),
        //border: Border.all(color:Colors.black, width: 1)
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: AllColor.brand2_light,
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
        _PillButton.purple(
          "View Proposal",
          onTap: () {
            context.push(ViewProposalScreen.routeName);
          },
        ),
      ],
      "In Progress" => [
        _PillButton.purple(
          "Track Project",
          onTap: () {
            context.push(RequestTrackerScreen.routeName);
          },
        ),
      ],
      "In Review" => [
        _PillButton.lime(
          "View Details",
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
              ),
              builder: (_) => const CustomProjectCompletionBottomSheet(),
            );
          },
        ),
        SizedBox(width: 8.w),
        _PillButton.purple(
          "Track Project",
          onTap: () {
            context.push(RequestTrackerScreen.routeName);
          },
        ), // ← both buttons
      ],
      "Delivered" => [
        _PillButton.purple(
          "Leave us a review",
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
              ),
              builder: (_) => const ReviewBottomSheet(),
            );
          },
        ),
        SizedBox(width: 8.w),
        _PillButton.lime(
          "View Details",
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
              ),
              builder: (_) =>
                  const CustomProjectCompletionBottomSheet(check: true),
            );
          },
        ), // ← only this
      ],
      _ => <Widget>[],
    };

    if (!showButtons) {
      return Padding(
        padding: const EdgeInsets.only(right: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(),

            Text(
              price,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ],
        ),
      );
    }

    return Row(
      children: [
        Text(
          price,
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
            color: AllColor.black,
          ),
        ),
        const Spacer(),
        ...buttons,
      ],
    );
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
        AllColor.white, // শেডেড পার্পল (mock vibe)
        AllColor.brand2_light,

        onTap: onTap,
      );

  factory _PillButton.lime(String label, {required VoidCallback onTap}) =>
      _PillButton._(
        label,
        AllColor.white, // lime
        AllColor.brand2_light,
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
              fontWeight: FontWeight.w600,
              color: fg,
              fontFamily: "bodyFont",
            ),
          ),
        ),
      ),
    );
  }
}

class CustomProjectCompletionBottomSheet extends StatelessWidget {
  const CustomProjectCompletionBottomSheet({super.key, this.check = false});

  final bool check;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        padding: EdgeInsets.all(20.r),
        decoration: BoxDecoration(
          color: AllColor.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Header Row
            Row(
              children: [
                Text(
                  "Project Completion",
                  style: theme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AllColor.black,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: Icon(Icons.close, color: AllColor.black),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),

            6.verticalSpace,

            /// Subtitle
            Text(
              "The team has completed this order.",
              style: theme.titleMedium?.copyWith(
                fontSize: 13.sp,
                color: AllColor.black.withOpacity(0.6),
              ),
            ),

            16.verticalSpace,

            /// Message Label
            Text(
              "Message",
              style: theme.titleSmall?.copyWith(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
              ),
            ),

            8.verticalSpace,

            /// Message Box
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                color: AllColor.black.withOpacity(.05),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                "All plumbing issues have been resolved. Replaced the faulty pipes and installed new faucets as requested. System tested and working perfectly.",
                style: theme.titleMedium?.copyWith(
                  fontSize: 12.sp,
                  height: 1.4,
                ),
              ),
            ),

            16.verticalSpace,

            /// Attachments Label
            Text(
              "Attachments",
              style: theme.titleSmall?.copyWith(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
              ),
            ),

            8.verticalSpace,

            /// Attachments List
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _attachment("photos.pdf"),
                6.verticalSpace,
                _attachment("projects.zip"),
              ],
            ),

            24.verticalSpace,

            if (check == false)
              Row(
                children: [
                  /// Approve
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AllColor.primary,
                        foregroundColor: AllColor.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.r),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 8.h,
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        "Approve",
                        style: theme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AllColor.borderColor,
                        ),
                      ),
                    ),
                  ),
                  12.horizontalSpace,

                  /// Needs Modification
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20.r),
                            ),
                          ),
                          builder: (context) => CustomRejectBottomSheet(
                            onSubmit: (reason) {
                              context.pop();
                              Navigator.pop(context);
                            },
                            text1: "Modification Message",
                            text2: "Tell something for modification",
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: AllColor.black.withOpacity(0.4),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.r),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 8.h,
                        ),
                      ),
                      child: Text(
                        "Needs Modification",
                        style: theme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AllColor.borderColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  /// 🔗 Attachment item widget
  Widget _attachment(String fileName) {
    return Row(
      children: [
        Icon(
          Icons.attach_file_rounded,
          size: 16.sp,
          color: AllColor.black.withOpacity(.7),
        ),
        6.horizontalSpace,
        Text(
          fileName,
          style: TextStyle(
            color: AllColor.brand2_light,
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class ReviewBottomSheet extends StatefulWidget {
  const ReviewBottomSheet({super.key});

  @override
  State<ReviewBottomSheet> createState() => _ReviewBottomSheetState();
}

class _ReviewBottomSheetState extends State<ReviewBottomSheet> {
  int selectedRating = 4;
  final TextEditingController _controller = TextEditingController(
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        padding: EdgeInsets.all(20.r),
        decoration: BoxDecoration(
          color: AllColor.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Top Row: Ratings + Close
            Row(
              children: [
                Text(
                  "Ratings",
                  style: theme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AllColor.black,
                  ),
                ),
                SizedBox(width: 18.w,),
                StarRating(rating: 3.5, color: AllColor.borderColor,),
                const Spacer(),
                IconButton(
                  icon: Icon(Icons.close, color: AllColor.black),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            6.verticalSpace,

            16.verticalSpace,

            /// Message label
            Text(
              "Message",
              style: theme.titleSmall?.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 13.sp,
              ),
            ),

            8.verticalSpace,

            /// Message Box
            TextField(
              controller: _controller,
              maxLines: 4,
              style: theme.titleMedium?.copyWith(color: AllColor.black),
              decoration: const InputDecoration(
                  // border: InputBorder.none,
              hintText: "Write your review here..."),
            ),

            20.verticalSpace,

            /// Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final rating = selectedRating;
                  final message = _controller.text.trim();
                  // TODO: handle submission
                  showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (context) => Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: const ProjectReviewCard(),
                    ),
                  );

                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AllColor.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999.r),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  elevation: 0,
                ),
                child: Text(
                  "Submit Review",
                  style: theme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AllColor.borderColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class ProjectReviewCard extends StatelessWidget {
  const ProjectReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AllColor.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AllColor.grey300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          /// Title + Badge
          Row(
            children: [
              Expanded(
                child: Text(
                  "Deliver something for me",
                  style: theme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AllColor.primary,
                  borderRadius: BorderRadius.circular(999.r),
                ),
                child: Text(
                  "Delivered",
                  style: theme.titleMedium?.copyWith(
                    color: AllColor.borderColor,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),

          12.verticalSpace,

          /// Info rows
          _infoRow(Icons.watch_later_outlined, "Immediate"),
          4.verticalSpace,
          _infoRow(Icons.attach_money_sharp, "\$5,000–\$20,000"),
          4.verticalSpace,
          _infoRow(Icons.phone_in_talk_rounded, "Afternoon ( 12PM–5PM)"),

          16.verticalSpace,

          /// Reviews
          _reviewRow("Jhon", 4, "nizam is working great. thanks"),
          12.verticalSpace,
          _reviewRow("You", 5, "great work experience. thanks"),

          16.verticalSpace,

          /// Bottom Row: Price & View Details
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\$50",
                style: theme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                  color: AllColor.black,
                ),
              ),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
                    ),
                    builder: (_) => const CustomProjectCompletionBottomSheet(check: true,),
                  );
                },
                child: Text(
                  "View Details",
                  style: theme.titleMedium?.copyWith(
                    color: AllColor.brand2_light,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  /// Info row with icon + text
  Widget _infoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16.sp, color: AllColor.brand2_light),
        6.horizontalSpace,
        Text(
          text,
          style: TextStyle(
            fontSize: 13.sp,
            color: AllColor.borderColor,
            fontWeight: FontWeight.w500,
            fontFamily: "bodyFond"
          ),
        )
      ],
    );
  }

  /// Reviewer block
  Widget _reviewRow(String user, int stars, String comment) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Name + Stars
        Row(
          children: [
            Icon(Icons.person_outline_rounded,
                size: 18.sp, color: AllColor.black),
            6.horizontalSpace,
            Text(
              user,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: AllColor.black,
                fontFamily: "bodyFont"
              ),
            ),
            4.horizontalSpace,
            StarRating(rating: 3.5, color: AllColor.borderColor,size: 16.r,),
            6.horizontalSpace,
            Text(
              stars.toString(),
              style: TextStyle(fontSize: 12.sp, color: AllColor.black),
            ),
          ],
        ),

        6.verticalSpace,

        /// Comment
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(
            color: AllColor.grey200.withOpacity(0.4),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Text(
            comment,
            style: TextStyle(
              fontSize: 12.sp,
              color: AllColor.black.withOpacity(0.85),
            ),
          ),
        ),
      ],
    );
  }
}
