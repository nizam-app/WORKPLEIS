import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/widget/global_bottom.dart';
import 'package:workpleis/core/widget/global_get_started_button.dart';

import 'package:workpleis/features/home/screen/post_job_screen.dart';
import 'package:workpleis/features/home/screen/see_all_jobs_screen.dart';

import 'package:workpleis/features/projects/screen/special_request_screen.dart';

import '../../../core/constants/color_control/all_color.dart';

class ServiceHomeScreen extends StatelessWidget {
  ServiceHomeScreen({super.key});

  static const routeName = '/service_home';

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Color(0xFFF6F6F6),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HomeHeaderSection(),

            CategoriesSection(),
            SizedBox(height: 15.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Recent Jobs", style: theme.headlineLarge),
              ),
            ),
            JobListScreen(),
            const SizedBox(height: 6),
            GlobalButton(
              text: "See All",
              onPressed: () {
                context.push(SeeAllJobsScreen.routeName);
              },
              textColor: AllColor.black,
              padding: EdgeInsets.symmetric(vertical: 8.h),
            ),
            HowItWorksSection(),
          ],
        ),
      ),
    );
  }

  Padding buildPadding(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      child: Column(
        children: [
          SizedBox(
            height: 40.h,
            child: TextFormField(
              decoration:
                  InputDecoration(
                    hintText: 'What do you need done today ?',
                  )!.copyWith(
                    fillColor: AllColor.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.r),
                    ),
                  ),
            ),
          ),
          SizedBox(height: 20.h),
          GlobalGetStartedButton(
            onTap: () {
              showChooseJobTypeBottomBar(context);
            },
            color: AllColor.primary,
            buttonName: "Next",
            borderRadius: 25,
            height: 40,
            textColor: AllColor.borderColor,
          ),
        ],
      ),
    );
  }
}

class HomeHeaderSection extends StatelessWidget {
  const HomeHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Container(
      color: const Color(0xFFF9F9F9), // light grey background
      padding: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
        top: 50.h,
        bottom: 20.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// 🔹 Left side (avatar + text)
          Row(
            children: [
              // Avatar
              Container(
                width: 60.w,
                height: 60.w,
                decoration: BoxDecoration(
                  color: AllColor.brand2_light,
                  shape: BoxShape.circle,
                  image: const DecorationImage(
                    image: NetworkImage(
                      'https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=880&q=80',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 12.w),

              // Texts
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello,',
                    style: theme.bodyMedium?.copyWith(
                      color: AllColor.brand2_light,
                      fontFamily: "headFont",
                      fontWeight: FontWeight.w600,
                      fontSize: 18.sp,
                    ),
                  ),
                  Text(
                    'Jhone Doe',
                    style: theme.titleMedium?.copyWith(
                      color: AllColor.brand2_light,
                      fontWeight: FontWeight.w600,
                      fontFamily: "headFont",
                      fontSize: 26.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),

          /// 🔹 Right side (icons)
          Row(
            children: [
              _buildCircleIcon(icon: Icons.search_rounded, onTap: () {}),
              SizedBox(width: 10.w),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  _buildCircleIcon(
                    icon: Icons.notifications_none_rounded,
                    onTap: () {
                      context.push("/notificationScreen");
                    },
                  ),
                  // green dot
                  Positioned(
                    top: 6,
                    right: 6,
                    child: Container(
                      width: 8.w,
                      height: 8.w,
                      decoration: const BoxDecoration(
                        color: Color(0xFFCCFF33), // lime green
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCircleIcon({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40.w,
        height: 40.w,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.black87, size: 22.sp),
      ),
    );
  }
}

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    final categories = [
      {
        'icon': Icons.assignment,
        'bgColor': const Color(0xFFDFFF6F),
        'iconColor': Colors.black87,
        'jobs': '15 Jobs posted',
        'title': 'Everyday Tasks',
      },
      {
        'icon': Icons.business_center,
        'bgColor': const Color(0xFFCEC8E3),
        'iconColor': const Color(0xFF3B2F73),
        'jobs': '12 Jobs posted',
        'title': 'Professional Help',
      },
      {
        'icon': Icons.trending_up,
        'bgColor': const Color(0xFFD2CFE5),
        'iconColor': const Color(0xFF3B2F73),
        'jobs': '10 Jobs posted',
        'title': 'Business Support',
      },
      {
        'icon': Icons.calendar_today,
        'bgColor': const Color(0xFFD2CFE5),
        'iconColor': const Color(0xFF3B2F73),
        'jobs': '08 Jobs posted',
        'title': 'Business Support',
      },
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Category',
            style: theme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontSize: 18.sp,
            ),
          ),
          SizedBox(height: 10.h),

          /// 🔹 Category list
          SizedBox(
            height: 140.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              separatorBuilder: (_, __) => SizedBox(width: 14.w),
              itemBuilder: (context, index) {
                final item = categories[index];
                return _CategoryCard(
                  icon: item['icon'] as IconData,
                  bgColor: item['bgColor'] as Color,
                  iconColor: item['iconColor'] as Color,
                  jobs: item['jobs'] as String,
                  title: item['title'] as String,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({
    required this.icon,
    required this.bgColor,
    required this.iconColor,
    required this.jobs,
    required this.title,
  });

  final IconData icon;
  final Color bgColor;
  final Color iconColor;
  final String jobs;
  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Container(
      width: 160.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.only(left: 15.w, top: 10.h, bottom: 25.h, right: 5.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // icon box
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(icon, color: iconColor, size: 22.sp),
          ),
          Spacer(),
          Text(
            jobs,
            style: theme.bodySmall?.copyWith(
              color: Colors.grey[600],
              fontSize: 10.sp,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            title,
            style: theme.bodyMedium?.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }
}

class JobModel {
  final String title;
  final String poster;
  final String timeAgo;
  final String category;
  final String description;
  final String budget;
  final String location;
  final int offers;
  final String status;

  JobModel({
    required this.title,
    required this.poster,
    required this.timeAgo,
    required this.category,
    required this.description,
    required this.budget,
    required this.location,
    required this.offers,
    required this.status,
  });
}

class JobListScreen extends StatelessWidget {
  const JobListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<JobModel> jobs = [
      JobModel(
        title: "Bathroom Plumbing Repair",
        poster: "Robert Wilson",
        timeAgo: "3h ago",
        category: "Plumbing",
        description:
            "Need urgent plumbing repair for bathroom sink and shower drain issues.",
        budget: "\$300 - \$500",
        location: "Boston, USA",
        offers: 5,
        status: "Open",
      ),
      JobModel(
        title: "Kitchen Pipe Fix",
        poster: "Sarah Taylor",
        timeAgo: "5h ago",
        category: "Plumbing",
        description:
            "Replace leaking kitchen pipe and ensure water flow is stable.",
        budget: "\$250 - \$400",
        location: "New York, USA",
        offers: 3,
        status: "Open",
      ),
      JobModel(
        title: "Shower Drain Cleaning",
        poster: "John Martin",
        timeAgo: "1d ago",
        category: "Maintenance",
        description:
            "Drain clogged with hair and soap residue, need thorough cleaning.",
        budget: "\$100 - \$200",
        location: "Chicago, USA",
        offers: 8,
        status: "Closed",
      ),
      JobModel(
        title: "Shower Drain Cleaning",
        poster: "John Martin",
        timeAgo: "1d ago",
        category: "Maintenance",
        description:
            "Drain clogged with hair and soap residue, need thorough cleaning.",
        budget: "\$100 - \$200",
        location: "Chicago, USA",
        offers: 8,
        status: "Closed",
      ),
      JobModel(
        title: "Shower Drain Cleaning",
        poster: "John Martin",
        timeAgo: "1d ago",
        category: "Maintenance",
        description:
            "Drain clogged with hair and soap residue, need thorough cleaning.",
        budget: "\$100 - \$200",
        location: "Chicago, USA",
        offers: 8,
        status: "Closed",
      ),
      JobModel(
        title: "Shower Drain Cleaning",
        poster: "John Martin",
        timeAgo: "1d ago",
        category: "Maintenance",
        description:
            "Drain clogged with hair and soap residue, need thorough cleaning.",
        budget: "\$100 - \$200",
        location: "Chicago, USA",
        offers: 8,
        status: "Closed",
      ),
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: jobs.length,
        itemBuilder: (context, index) => JobCard(job: jobs[index]),
      ),
    );
  }
}

class JobCard extends StatelessWidget {
  final JobModel job;

  const JobCard({super.key, required this.job});

  Color get statusColor {
    switch (job.status.toLowerCase()) {
      case "open":
        return Color(0xff686382); // light lime green
      case "closed":
        return Color(0xff686382);
      default:
        return AllColor.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Container(
      margin: EdgeInsets.only(bottom: 14.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AllColor.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AllColor.borderColor.withOpacity(0.4)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.03),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// --- Header Section ---
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 24.r,
                backgroundImage: const NetworkImage(
                  "https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=200&q=80",
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      job.title,
                      style: theme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AllColor.black,
                        fontSize: 16.sp,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      job.poster,
                      style: theme.titleMedium?.copyWith(
                        color: AllColor.warmDarkGrey,
                        fontSize: 13.sp,
                      ),
                    ),
                    SizedBox(height: 6.h),

                    /// Category & Time
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 2.5.h,
                          ),
                          decoration: BoxDecoration(
                            color: AllColor.white,
                            borderRadius: BorderRadius.circular(20.r),
                            border: Border.all(color: Color(0xff686382)),
                          ),
                          child: Text(
                            job.category,
                            style: theme.headlineSmall?.copyWith(
                              fontSize: 11.sp,
                              color: AllColor.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Icon(
                          Icons.access_time,
                          size: 14.sp,
                          color: AllColor.warmDarkGrey,
                        ),
                        SizedBox(width: 3.w),
                        Text(
                          job.timeAgo,
                          style: theme.headlineSmall?.copyWith(
                            fontSize: 12.sp,
                            color: AllColor.warmDarkGrey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              /// Status badge
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AllColor.primary,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  job.status,
                  style: theme.headlineSmall?.copyWith(
                    color: statusColor,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 10.h),

          /// Description
          Text(
            job.description,
            style: theme.bodyMedium?.copyWith(
              fontSize: 13.sp,
              color: AllColor.black.withOpacity(0.7),
              height: 1.4,
            ),
          ),

          SizedBox(height: 10.h),
          Divider(color: const Color(0xffE3E3E3), height: 1),

          SizedBox(height: 10.h),

          /// Info Row + Apply Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _infoBox("Budget", job.budget, theme),
                  SizedBox(width: 16.w),
                  _infoBox("Location", job.location, theme),
                  SizedBox(width: 16.w),
                  _infoBox("Offers", "${job.offers}", theme),
                ],
              ),
              SizedBox(
                height: 32.h,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AllColor.brand2_light,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.r),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                  ),
                  child: Text(
                    "Apply",
                    style: theme.headlineSmall?.copyWith(
                      fontSize: 13.sp,
                      color: AllColor.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoBox(String label, String value, TextTheme theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.headlineSmall?.copyWith(
            fontSize: 12.sp,
            color: AllColor.warmDarkGrey,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: theme.titleSmall?.copyWith(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: AllColor.black,
          ),
        ),
      ],
    );
  }
}

class _ServiceProviderCard extends StatelessWidget {
  _ServiceProviderCard({
    required this.name,
    required this.role,
    required this.rating,
    required this.reviews,
    required this.image,
  });

  final String name;
  final String role;
  final double rating;
  final int reviews;
  final String image;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Container(
      width: 170.w,
      decoration: BoxDecoration(
        color: AllColor.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AllColor.borderColor.withOpacity(0.4)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔹 Image
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
            child: Image.network(
              image,
              height: 130.h,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          /// 🔹 Info
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: theme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                    color: Colors.black,
                  ),
                ),
                Text(
                  role,
                  style: theme.bodySmall?.copyWith(
                    color: Colors.grey[700],
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 8.h),

                /// 🔹 Rating row
                Row(
                  children: [
                    Icon(
                      Icons.star_rounded,
                      color: AllColor.brand2_light,
                      size: 18,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      '$rating ',
                      style: theme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 10.sp,
                      ),
                    ),
                    Text(
                      '($reviews)',
                      style: theme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                        fontSize: 10.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HowItWorksSection extends StatelessWidget {
  HowItWorksSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final steps = [
      {'icon': Icons.search_rounded, 'title': 'Post a job'},
      {'icon': Icons.group_outlined, 'title': 'Get Offers'},
      {'icon': Icons.touch_app_outlined, 'title': 'Choose a workpeer'},
      {'icon': Icons.attach_money, 'title': 'Make Payment'},
      {'icon': Icons.star_border_rounded, 'title': 'Review Job'},
      {'icon': Icons.check_circle_outline_rounded, 'title': 'Accept job'},
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 14.w),
        decoration: BoxDecoration(
          color: const Color(0xFFF6F6F6),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AllColor.borderColor.withOpacity(0.3)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 🔹 Title
            Text(
              'How it works',
              style: theme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: AllColor.black,
                fontSize: 22.sp,
              ),
            ),

            SizedBox(height: 10.h),

            // 🔹 Grid
            LayoutBuilder(
              builder: (context, raints) {
                return GridView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: steps.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10.h,
                    crossAxisSpacing: 10.w,
                    childAspectRatio: (raints.maxWidth / 3) / 100.h,
                  ),
                  itemBuilder: (context, index) {
                    final item = steps[index];
                    return _StepCard(
                      icon: item['icon'] as IconData,
                      title: item['title'] as String,
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// 🔹 Single Card Widget
class _StepCard extends StatelessWidget {
  final IconData icon;
  final String title;

  _StepCard({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 6.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AllColor.borderColor.withOpacity(0.3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 26.sp, color: AllColor.black),
          SizedBox(height: 6.h),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> showChooseJobTypeBottomBar(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
    ),
    builder: (_) => ChooseJobTypeBottomBar(),
  );
}

class ChooseJobTypeBottomBar extends StatefulWidget {
  ChooseJobTypeBottomBar({super.key});

  @override
  State<ChooseJobTypeBottomBar> createState() => _ChooseJobTypeBottomBarState();
}

class _ChooseJobTypeBottomBarState extends State<ChooseJobTypeBottomBar> {
  String selectedType = "Single Job";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Choose job type",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18.sp,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Expanded(
                child: _PillButton(
                  label: "Single Job",
                  isSelected: selectedType == "Single Job",
                  onTap: () {
                    setState(() => selectedType = "Single Job");
                    context.push(PostJobScreen.routeName);
                  },
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: _PillButton(
                  label: "Project",
                  isSelected: selectedType == "Project",
                  onTap: () {
                    setState(() => selectedType = "Project");
                    context.push(ProjectSetupScreen.routeName);
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h + MediaQuery.paddingOf(context).bottom),
        ],
      ),
    );
  }
}

class _PillButton extends StatelessWidget {
  _PillButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        height: 45.h,
        decoration: BoxDecoration(
          color: isSelected ? AllColor.primary : Colors.white,
          borderRadius: BorderRadius.circular(40.r),
          border: Border.all(color: Colors.black, width: 1),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
