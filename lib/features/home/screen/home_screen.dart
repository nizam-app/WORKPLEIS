import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workpleis/core/constants/image_control/image_path.dart';
import 'package:workpleis/core/widget/global_get_started_button.dart';
import 'package:workpleis/features/Payment/screen/payment_methods_screen.dart';
import 'package:workpleis/features/account/screen/account_screen.dart';
import 'package:workpleis/features/auth/screens/login_screen.dart';
import 'package:workpleis/features/home/screen/post_job_screen.dart';
import 'package:workpleis/features/message/screen/message_screen.dart';
import 'package:workpleis/features/my_task/screen/my_task_screen.dart';
import 'package:workpleis/features/notification/screen/notificaition_screen.dart';
import 'package:workpleis/features/security/screen/security_faq_screen.dart';
import 'package:workpleis/features/security/screen/security_screen.dart';
import 'package:workpleis/features/verification/screen/verification_screen.dart';
import '../../../core/constants/color_control/all_color.dart';
import '../../../core/utils/global_role_check.dart';
import '../widget/custom_category_type.dart';
import '../widget/custom_filter_chips.dart';
import '../widget/custom_job_posts.dart';
import '../widget/custom_search_box_bottom.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const routeName = '/homeScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F6F6),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HomeHeaderSection(),
            SizedBox(height: 20.h),
            buildPadding(context),
            CategoriesSection(),
            ActiveJobsSection(),
            ServiceProvidersSection(),
            HowItWorksSection()
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
                onTap: () {showChooseJobTypeBottomBar(context);},
                color: AllColor.primary,
                buttonName: "Next",
                borderRadius: 25,
                height: 40,
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
                      color:  AllColor.brand2_light,
                      fontFamily: "headFont",
                      fontWeight: FontWeight.w900,
                      fontSize: 16.sp,


                    ),
                  ),
                  Text(
                    'Jhone Doe',
                    style: theme.titleMedium?.copyWith(
                      color:  AllColor.brand2_light,
                      fontWeight: FontWeight.w700,
                      fontFamily: "headFont",
                      fontSize: 25.sp,
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
                    onTap: () {},
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
        'icon': Icons.business_center ,
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
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Categories',
            style: theme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: Colors.black,
              fontSize: 18.sp,
            ),
          ),
          SizedBox(height: 16.h),

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
              fontSize: 12.sp,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            title,
            style: theme.bodyMedium?.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 15.sp,
            ),
          ),
        ],
      ),
    );
  }
}


class ActiveJobsSection extends StatelessWidget {
  const ActiveJobsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    // 🔹 Mock data list
    final jobs = [
      {
        'title': 'Kitchen Renovation',
        'location': 'New York, NY',
        'time': '3h ago',
        'budget': '\$300-500',
        'offers': '5',
        'status': 'In progress',
      },
      {
        'title': 'Kitchen Renovation',
        'location': 'New York, NY',
        'time': '3h ago',
        'budget': '\$300-500',
        'offers': '5',
        'status': 'In progress',
      },
      {
        'title': 'Kitchen Renovation',
        'location': 'New York, NY',
        'time': '3h ago',
        'budget': '\$300-500',
        'offers': '5',
        'status': 'In progress',
      },
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔹 Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Your Active Jobs',
                style: theme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 18.sp,
                  color: Colors.black,
                ),
              ),
              Text(
                'See All >',
                style: theme.bodyMedium?.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),

          /// 🔹 Jobs list
          Column(
            children: jobs
                .map(
                  (job) => Padding(
                padding: EdgeInsets.only(bottom: 14.h),
                child: _JobCard(
                  title: job['title']!,
                  location: job['location']!,
                  time: job['time']!,
                  budget: job['budget']!,
                  offers: job['offers']!,
                  status: job['status']!,
                ),
              ),
            )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _JobCard extends StatelessWidget {
  const _JobCard({
    required this.title,
    required this.location,
    required this.time,
    required this.budget,
    required this.offers,
    required this.status,
  });

  final String title;
  final String location;
  final String time;
  final String budget;
  final String offers;
  final String status;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AllColor.borderColor.withOpacity(0.4),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔹 Top Row (Title + Status)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: theme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 20.sp,
                ),
              ),
              Container(
                padding:
                EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFCCFF33),
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 6.h),

          /// 🔹 Location + Time
          Row(
            children: [
              const Icon(Icons.location_on_outlined,
                  color: Colors.grey, size: 16),
              SizedBox(width: 4.w),
              Text(
                location,
                style: theme.titleMedium?.copyWith(
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(width: 8.w),
              const Icon(Icons.access_time_rounded,
                  color: Colors.grey, size: 16),
              SizedBox(width: 4.w),
              Text(
                time,
                style: theme.titleMedium?.copyWith(
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          /// 🔹 Budget + Offers + View button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Budget + Offers
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Budget',
                        style: theme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                          fontSize: 12.sp,
                        ),
                      ),
                      Text(
                        budget,
                        style: theme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 40.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Offers',
                        style: theme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                          fontSize: 12.sp,
                        ),
                      ),
                      Text(
                        offers,
                        style: theme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              // View button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:  AllColor.brand2_light, // purple
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  padding:
                  EdgeInsets.symmetric(horizontal: 20.w, vertical: 2.h),
                  elevation: 0,
                ),
                onPressed: () {},
                child: Text(
                  'View',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ServiceProvidersSection extends StatelessWidget {
  const ServiceProvidersSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    // 🔹 Sample providers data
    final providers = [
      {
        'name': 'John Smith',
        'role': 'Contractor',
        'rating': 4.9,
        'reviews': 212,
        'image': 'https://images.unsplash.com/photo-1580894908361-967195033215?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80',
      },
      {
        'name': 'Alina Williams',
        'role': 'Plumber',
        'rating': 4.8,
        'reviews': 156,
        'image': 'https://images.unsplash.com/photo-1521737711867-e3b97375f902?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=687&q=80',
      },
      {
        'name': 'David Miller',
        'role': 'Electrician',
        'rating': 4.7,
        'reviews': 98,
        'image': 'https://images.unsplash.com/photo-1557862921-37829c790f19?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1171&q=80',
      },
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔹 Section Title
          Text(
            'Top Service Providers',
            style: theme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 18.sp,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 16.h),

          /// 🔹 Providers horizontal list
          SizedBox(
            height: 225.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: providers.length,
              separatorBuilder: (_, __) => SizedBox(width: 14.w),
              itemBuilder: (context, index) {
                final provider = providers[index];
                return _ServiceProviderCard(
                  name: provider['name'] as String,
                  role: provider['role'] as String,
                  rating: provider['rating'] as double,
                  reviews: provider['reviews'] as int,
                  image: provider['image'] as String,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ServiceProviderCard extends StatelessWidget {
  const _ServiceProviderCard({
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
        border: Border.all(
          color: AllColor.borderColor.withOpacity(0.4),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
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
                    fontWeight: FontWeight.w600,
                    fontSize: 17.sp,
                    color: Colors.black,
                  ),
                ),
                Text(
                  role,
                  style: theme.bodySmall?.copyWith(
                    color: Colors.grey[700],
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8.h),

                /// 🔹 Rating row
                Row(
                  children: [
                     Icon(Icons.star_rounded,
                        color: AllColor.brand2_light, size: 18),
                    SizedBox(width: 4.w),
                    Text(
                      '$rating ',
                      style: theme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 13.sp,
                      ),
                    ),
                    Text(
                      '($reviews)',
                      style: theme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                        fontSize: 12.sp,
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
  const HowItWorksSection({super.key});

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
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 12.w),
        decoration: BoxDecoration(
          color: Color(0xFFF6F6F6),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: AllColor.borderColor.withOpacity(0.4),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Text(
              'How it works',
              style: theme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: Colors.black,
                fontSize: 25.sp,
              ),
            ),
            /// 🔹 2x3 Grid
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: steps.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8.h,
                crossAxisSpacing: 8.w,
                childAspectRatio: 1.1,
              ),
              itemBuilder: (context, index) {
                final item = steps[index];
                return _StepCard(
                  icon: item['icon'] as IconData,
                  title: item['title'] as String,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _StepCard extends StatelessWidget {
  const _StepCard({required this.icon, required this.title});

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.black.withOpacity(0.08)),
      ),
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 30.sp, color: Colors.black87),
          SizedBox(height: 8.h),
          Text(
            title,
            textAlign: TextAlign.center,
            style: theme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 13.sp,
              color: Colors.black,
              height: 1.3,
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
    builder: (_) => const ChooseJobTypeBottomBar(),
  );
}

class ChooseJobTypeBottomBar extends StatefulWidget {
  const ChooseJobTypeBottomBar({super.key});

  @override
  State<ChooseJobTypeBottomBar> createState() =>
      _ChooseJobTypeBottomBarState();
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
              fontWeight: FontWeight.w700,
              fontSize: 16.sp,
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
                    Navigator.pop(context, selectedType);
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
  const _PillButton({
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
        duration: const Duration(milliseconds: 200),
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
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
