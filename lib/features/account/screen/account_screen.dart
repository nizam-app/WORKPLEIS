import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/core/widget/global_app_bar.dart';

import '../../home/widget/custom_job_posts.dart';
class AccountOverviewScreen extends StatelessWidget {
  const AccountOverviewScreen({super.key});
  static const routeName = "/accountOverviewScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppbar(text: "Account"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const ProfileHeaderSection(),
            SizedBox(height: 20.h),
            ProfileTabsSection(),

            // const AccountStatsSection(),
             SizedBox(height: 20.h),
            //const ExtraStatsSection(),
            // SizedBox(height: 20.h),
            // const ToggleModeSection(),
            // SizedBox(height: 20.h),
             //const SkillsSection(),
           //  SizedBox(height: 20.h),
             //CustomApplicationsBar(),
            // SizedBox(height: 20.h),
            // JobListScreen(),
            // SizedBox(height: 20.h),
            // RecentTasksSection(),
            // SizedBox(height: 20.h),
            // SignOutSection(),
            // SizedBox(height: 20.h),


          ],
        ),
      ),
    );
  }
}

/* ================= PROFILE HEADER ================= */
class ProfileHeaderSection extends StatefulWidget {
  const ProfileHeaderSection({super.key});

  @override
  State<ProfileHeaderSection> createState() => _ProfileHeaderSectionState();
}

class _ProfileHeaderSectionState extends State<ProfileHeaderSection> {
  double _rating = 4.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 28.r,
          backgroundImage: const AssetImage("assets/images/profile.png"),
          backgroundColor: AllColor.grey200,
        ),
        10.h.verticalSpace,
        Text("Jhon Doe",
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w300, color: AllColor.black)),
        6.h.verticalSpace,
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
          decoration: BoxDecoration(color: AllColor.allcolor, borderRadius: BorderRadius.circular(6.r)),
          child: Text("Client",
              style: TextStyle(fontSize: 16.sp, color: AllColor.grey, fontWeight: FontWeight.w500)),
        ),
        10.h.verticalSpace,

        // ⭐ Rating (interactive)
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RatingBar.builder(
              initialRating: _rating,
              minRating: 1,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 20.sp,
              itemPadding: EdgeInsets.zero,
              unratedColor: AllColor.parpale.withOpacity(.25),
              itemBuilder: (_, __) => Icon(Icons.star, color: AllColor.parpale),
              onRatingUpdate: (v) => setState(() => _rating = v),
            ),
            6.w.horizontalSpace,
            Text(_rating.toStringAsFixed(1),
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: AllColor.black)),
            4.w.horizontalSpace,
            Text("(127 reviews)", style: TextStyle(color: Colors.grey, fontSize: 14.sp)),
          ],
        ),

        10.h.verticalSpace,

        // Description
        Text(
          "Startup founder and product manager with 8+ years in tech. "
              "Building innovative SaaS solutions and always looking for talented "
              "designers and developers to bring ideas to life.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14.sp, color: Colors.black87, height: 1.35),
        ),

        20.h.verticalSpace,

        // Four Info Cards
        Wrap(
          spacing: 12.w,
          runSpacing: 12.h,
          alignment: WrapAlignment.center,
          children: [
            _infoBox(Icons.work, "28", "Job Completed"),
            _infoBox(Icons.pending_actions, "10", "Job Pending"),
            _infoBox(Icons.star, "4.8", "Rating"),
            _infoBox(Icons.attach_money, "\$1000", "Total Spent"),
          ],
        ),
      ],
    );
  }

  Widget _infoBox(IconData icon, String value, String label) {
    return Container(
      width: 140.w,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        border: Border.all(color: AllColor.borderColor),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
            Icon(icon, color: AllColor.borderColor, size: 20.sp),
            6.w.horizontalSpace,
            Text(value, style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: AllColor.black)),
          ]),
          6.h.verticalSpace,
          Text(label, style: TextStyle(fontSize: 12.sp, color: Colors.grey)),
        ],
      ),
    );
  }
}





/*=============== Profile Tabs Screen ================*/

/* replace ProfileTabsScreen with this */
class ProfileTabsSection extends StatefulWidget {
  const ProfileTabsSection({super.key, this.height});
  final double? height; // optional fixed height
  @override State<ProfileTabsSection> createState() => _TabsState();
}

class _TabsState extends State<ProfileTabsSection> {
  int tab = 0; // 0=About, 1=Projects, 2=Reviews

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // scroll এর ভেতরে finite height দরকার
      height: widget.height ?? 420.h,
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _Segmented(
              labels: const ['About','Projects','Reviews'],
              index: tab,
              onChanged: (i)=>setState(()=>tab=i),
            ),
            12.h.verticalSpace,
            Expanded(
              child: IndexedStack(
                index: tab,
                children: const [
                  _AboutSection(),
                  _ProjectsSection(),
                  _ReviewsSection(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* Segmented control */
class _Segmented extends StatelessWidget {
  const _Segmented({required this.labels, required this.index, required this.onChanged});
  final List<String> labels; final int index; final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext c) => Container(
    padding: EdgeInsets.all(4.r),
    decoration: BoxDecoration(
      color: AllColor.black.withOpacity(.06),
      borderRadius: BorderRadius.circular(16.r),
    ),
    child: Row(children: List.generate(labels.length, (i){
      final sel = i==index;
      return Expanded(
        child: GestureDetector(
          onTap: ()=>onChanged(i),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 140),
            padding: EdgeInsets.symmetric(vertical: 10.h),
            decoration: BoxDecoration(
              color: sel? AllColor.brand2_light: Colors.transparent,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Center(child: Text(labels[i],
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp, color: AllColor.black))),
          ),
        ),
      );
    })),
  );
}

/* ABOUT (ListView bounded by Expanded, so no infinite height) */
class _AboutSection extends StatelessWidget {
  const _AboutSection();
  @override
  Widget build(BuildContext c)=> ListView(
    children: [
      _AboutItem(icon: Icons.location_on_outlined, title: 'Location', value: 'San Francisco, CA'),
      _AboutItem(icon: Icons.language, title: 'Languages', value: 'English, Spanish, French'),
      _AboutItem(icon: Icons.event, title: 'Member Since', value: 'March 2022'),
    ],
  );
}
class _AboutItem extends StatelessWidget {
  const _AboutItem({required this.icon, required this.title, required this.value});
  final IconData icon; final String title; final String value;
  @override
  Widget build(BuildContext c)=> Padding(
    padding: EdgeInsets.only(bottom: 14.h),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Icon(icon, size: 20.sp, color: AllColor.black),
      10.w.horizontalSpace,
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500)),
        4.h.verticalSpace,
        Text(value, style: TextStyle(fontSize: 12.sp, color: Colors.black54)),
      ])),
    ]),
  );
}

/* PROJECTS */
class _ProjectsSection extends StatelessWidget {
  const _ProjectsSection();
  @override
  Widget build(BuildContext c)=> ListView(
    children: const [
      _ProjectCard(),
    ],
  );
}
class _ProjectCard extends StatelessWidget {
  const _ProjectCard();
  @override
  Widget build(BuildContext c)=> Container(
    padding: EdgeInsets.all(14.w),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.r),
      border: Border.all(color: AllColor.black.withOpacity(.08)),
      boxShadow: [BoxShadow(color: Colors.black.withOpacity(.05), blurRadius: 12.r, offset: Offset(0,6.h))],
    ),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children:[
        Expanded(child: Text('Deliver something for me',
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500))),
        Text('\$50', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500)),
      ]),
      10.h.verticalSpace,
      _RowIconText(icon: Icons.person_outline, text: 'Topasham Me 04'),
      6.h.verticalSpace,
      _RowIconText(icon: Icons.today_outlined, text: 'Today'),
      6.h.verticalSpace,
      _RowIconText(icon: Icons.access_time, text: 'Any Time'),
    ]),
  );
}
class _RowIconText extends StatelessWidget {
  const _RowIconText({required this.icon, required this.text});
  final IconData icon; final String text;
  @override
  Widget build(BuildContext c)=> Row(children:[
    Icon(icon, size: 18.sp, color: Colors.black54),
    8.w.horizontalSpace,
    Text(text, style: TextStyle(fontSize: 12.sp, color: Colors.black87)),
  ]);
}

/* REVIEWS */
class _ReviewsSection extends StatelessWidget {
  const _ReviewsSection();
  @override
  Widget build(BuildContext c)=> ListView(
    children: [
      _RatingsSummary(rating: 4.0, counts: const [89,25,50,30,10]),
      12.h.verticalSpace,
      const _ReviewItem(
        name: 'Mike Chen',
        time: '2 Week ago',
        text:
        'Sarah delivered exceptional work on our mobile app redesign. Her attention to detail and user experience expertise really showed.',
        rating: 4.0,
      ),
    ],
  );
}

class _RatingsSummary extends StatelessWidget {
  const _RatingsSummary({required this.rating, required this.counts});
  final double rating; final List<int> counts; // 5→1
  @override
  Widget build(BuildContext c)=> Container(
    padding: EdgeInsets.all(14.w),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.r),
      border: Border.all(color: AllColor.black.withOpacity(.08)),
      boxShadow: [BoxShadow(color: Colors.black.withOpacity(.05), blurRadius: 12.r, offset: Offset(0,6.h))],
    ),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Column(children:[
        Text(rating.toStringAsFixed(1), style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w800)),
        6.h.verticalSpace,
        RatingBarIndicator(
          rating: rating, itemCount: 5, itemSize: 16.sp,
          unratedColor: AllColor.parpale.withOpacity(.25),
          itemBuilder: (_, __)=> Icon(Icons.star, color: AllColor.parpale),
        ),
        6.h.verticalSpace,
        Text('127 reviews', style: TextStyle(fontSize: 12.sp, color: Colors.black54)),
      ]),
      16.w.horizontalSpace,
      Expanded(child: Column(children: List.generate(5, (i){
        final star = 5 - i; final v = counts[i].toDouble();
        final total = counts.fold<int>(0, (a,b)=>a+b);
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 4.h),
          child: Row(children:[
            Text('$star', style: TextStyle(fontSize: 12.sp)),
            6.w.horizontalSpace,
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(999.r),
                child: LinearProgressIndicator(
                  minHeight: 10.h,
                  value: total==0 ? 0 : (v/total).clamp(0,1),
                  backgroundColor: AllColor.black.withOpacity(.08),
                  valueColor: AlwaysStoppedAnimation(AllColor.parpale),
                ),
              ),
            ),
            8.w.horizontalSpace,
            Text('${counts[i]}', style: TextStyle(fontSize: 12.sp)),
          ]),
        );
      }))),
    ]),
  );
}

class _ReviewItem extends StatelessWidget {
  const _ReviewItem({required this.name, required this.time, required this.text, required this.rating});
  final String name, time, text; final double rating;
  @override
  Widget build(BuildContext c)=> Container(
    padding: EdgeInsets.all(14.w),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.r),
      border: Border.all(color: AllColor.black.withOpacity(.08)),
      boxShadow: [BoxShadow(color: Colors.black.withOpacity(.05), blurRadius: 12.r, offset: Offset(0,6.h))],
    ),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children:[
        const CircleAvatar(radius: 16, backgroundImage: AssetImage('assets/images/profile.png')),
        8.w.horizontalSpace,
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children:[
          Text(name, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp)),
          RatingBarIndicator(
            rating: rating, itemCount: 5, itemSize: 12.sp,
            unratedColor: AllColor.parpale.withOpacity(.25),
            itemBuilder: (_, __)=> Icon(Icons.star, color: AllColor.parpale),
          ),
        ])),
        Text(time, style: TextStyle(fontSize: 12.sp, color: Colors.black54)),
      ]),
      8.h.verticalSpace,
      Text(text, style: TextStyle(fontSize: 14.sp, height: 1.35)),
    ]),
  );
}


/* ================= ACCOUNT STATS ================= */
// class AccountStatsSection extends StatelessWidget {
//   const AccountStatsSection({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final stats = [
//       {"title": " 28", "subtitle": "Task Completed"},
//       {"title": "⭐ 4.8", "subtitle": "Rating"},
//       {"title": "\$2390", "subtitle": "Total Earned"},
//       {"title": "100%", "subtitle": "Success Rate"},
//     ];
//
//     return GridView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2, childAspectRatio: 2.3),
//       itemCount: stats.length,
//       itemBuilder: (context, index) {
//         return Container(
//           margin: EdgeInsets.all(6.w),
//           padding: EdgeInsets.all(12.w),
//           decoration: BoxDecoration(
//             color: AllColor.appBar,
//             borderRadius: BorderRadius.circular(8.r),
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(stats[index]["title"]!,
//                   style: TextStyle(
//                       fontSize: 16.sp,
//                       fontWeight: FontWeight.bold,
//                       color: AllColor.borderColor)),
//               Text(stats[index]["subtitle"]!,
//                   style: TextStyle(fontSize: 12.sp, color: AllColor.white)),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

/* ================= EXTRA STATS ================= */
// class ExtraStatsSection extends StatelessWidget {
//   const ExtraStatsSection({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Wrap(
//           alignment: WrapAlignment.center,
//           spacing: 20.w,
//           children: [
//             _extraItem(Icons.group, "Repeat Clients"),
//             _extraItem(Icons.access_time, "Avg Response"),
//           ],
//         ),
//         SizedBox(height: 14.h),
//         Text(
//           "Member since March 2023",
//           style: TextStyle(
//             fontSize: 12.sp,
//             color: AllColor.grey,
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _extraItem(IconData icon, String text) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
//       decoration: BoxDecoration(
//         color: AllColor.borderColor,
//         borderRadius: BorderRadius.circular(10.r),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(icon, size: 20.sp, color: AllColor.black),
//           SizedBox(width: 8.w),
//           Text(
//             text,
//             style: TextStyle(
//               fontSize: 12.sp,
//               fontWeight: FontWeight.w500,
//               color: AllColor.black,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//
// /* ================= TOGGLE MODE ================= */
// class ToggleModeSection extends StatelessWidget {
//   const ToggleModeSection({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // Title
//         Text(
//           "Testing Mode",
//           style: TextStyle(
//             fontSize: 13.sp,
//             fontWeight: FontWeight.w600,
//             color: AllColor.black,
//           ),
//         ),
//         SizedBox(height: 8.h),
//
//         // Switch Row
//         Row(
//           children: [
//             Transform.scale(
//               scale: 0.9, // একটু ছোট switch
//               child: Switch(
//                 value: false,
//                 activeColor: AllColor.white,
//                 activeTrackColor: AllColor.black,
//                 inactiveThumbColor: AllColor.white,
//                 inactiveTrackColor: AllColor.grey300,
//                 onChanged: (v) {},
//               ),
//             ),
//             SizedBox(width: 10.w),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Switch to Poster View",
//                   style: TextStyle(
//                     fontSize: 12.sp,
//                     fontWeight: FontWeight.w500,
//                     color: AllColor.black,
//                   ),
//                 ),
//                 SizedBox(height: 2.h),
//                 Text(
//                   "Currently viewing as Tasker",
//                   style: TextStyle(
//                     fontSize: 11.sp,
//                     color: AllColor.grey,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
//
//
// /* ================= SKILLS ================= */
// class SkillsSection extends StatelessWidget {
//   const SkillsSection({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final skills = [
//       "Home Cleaning",
//       "Furniture Assembly",
//       "Move & Delivery",
//       "Gardening",
//       "Handyman Services"
//     ];
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text("Skills & Services",
//             style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600)),
//         SizedBox(height: 10.h),
//         Wrap(
//           spacing: 10.w,
//           runSpacing: 10.h,
//           children: [
//             ...skills.map((s) => Container(
//               padding:
//               EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
//               decoration: BoxDecoration(
//                 color: AllColor.black,
//                 borderRadius: BorderRadius.circular(20.r),
//               ),
//               child: Text(s,
//                   style: TextStyle(
//                       fontSize: 11.sp, color: AllColor.white)),
//             )),
//             Container(
//               padding:
//               EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
//               decoration: BoxDecoration(
//                 border: Border.all(color: AllColor.borderColor),
//                 borderRadius: BorderRadius.circular(20.r),
//               ),
//               child: Text("+ Add Skill",
//                   style: TextStyle(
//                       fontSize: 11.sp, color: AllColor.borderColor)),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
//
//
// /* ================= APPLICATIONS ================= */
//
//
// class ApplicationCard extends StatelessWidget {
//   final String category;
//   final String title;
//   final String budget;
//   final String posted;
//   final String deadline;
//
//   const ApplicationCard(
//       {super.key,
//         required this.category,
//         required this.title,
//         required this.budget,
//         required this.posted,
//         required this.deadline});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 10.h),
//       padding: EdgeInsets.all(12.w),
//       decoration: BoxDecoration(
//         border: Border.all(color: AllColor.borderColor),
//         borderRadius: BorderRadius.circular(8.r),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
//             decoration: BoxDecoration(
//               color: AllColor.borderColor.withOpacity(0.2),
//               borderRadius: BorderRadius.circular(6.r),
//             ),
//             child: Text(category,
//                 style: TextStyle(fontSize: 10.sp, color: AllColor.black)),
//           ),
//           SizedBox(height: 6.h),
//           Text(title,
//               style: TextStyle(
//                   fontSize: 13.sp,
//                   fontWeight: FontWeight.bold,
//                   color: AllColor.black)),
//           SizedBox(height: 4.h),
//           Text("$budget • $posted • $deadline",
//               style: TextStyle(fontSize: 11.sp, color: AllColor.black87)),
//         ],
//       ),
//     );
//   }
// }
//
// /* ================= RECENT TASKS ================= */
// class RecentTasksSection extends StatelessWidget {
//   const RecentTasksSection({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final tasks = [
//       {"title": "E-commerce Website Development", "status": "Completed"},
//       {"title": "Mobile App UI Design", "status": "In Process"},
//     ];
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text("Recent Tasks",
//             style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600)),
//         SizedBox(height: 10.h),
//         ...tasks.map((t) => Container(
//           margin: EdgeInsets.only(bottom: 8.h),
//           padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
//           decoration: BoxDecoration(
//             border: Border.all(color: AllColor.grey300),
//             borderRadius: BorderRadius.circular(8.r),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(
//                 child: Text(t["title"]!,
//                     style:
//                     TextStyle(fontSize: 12.sp, color: AllColor.black)),
//               ),
//               Container(
//                 padding:
//                 EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
//                 decoration: BoxDecoration(
//                   color: t["status"] == "Completed"
//                       ? AllColor.borderColor.withOpacity(0.2)
//                       : AllColor.orange.withOpacity(0.2),
//                   borderRadius: BorderRadius.circular(6.r),
//                 ),
//                 child: Text(t["status"]!,
//                     style: TextStyle(fontSize: 11.sp, color: AllColor.black)),
//               )
//             ],
//           ),
//         ))
//       ],
//     );
//   }
// }
//
// /* ================= SIGN OUT ================= */
// class SignOutSection extends StatelessWidget {
//   const SignOutSection({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       style: ElevatedButton.styleFrom(
//         backgroundColor: AllColor.red,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8.r),
//         ),
//         padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 30.w),
//       ),
//       onPressed: () {},
//       child: Text("Sign out",
//           style: TextStyle(color: AllColor.white, fontSize: 13.sp)),
//     );
//   }
// }
//
//
// class CustomApplicationsBar extends StatefulWidget {
//   const CustomApplicationsBar({super.key});
//
//   @override
//   State<CustomApplicationsBar> createState() => _CustomApplicationsBarState();
// }
//
// class _CustomApplicationsBarState extends State<CustomApplicationsBar> {
//   String selectedTab = "Pending";
//   final tabs = ["Pending", "Accepted", "In Progress", "Interviewing"];
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // Header Row
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               "My Applications",
//               style: TextStyle(
//                 fontSize: 14.sp,
//                 fontWeight: FontWeight.w600,
//                 color: AllColor.black,
//               ),
//             ),
//             Text(
//               "8 total",
//               style: TextStyle(
//                 fontSize: 12.sp,
//                 color: AllColor.grey,
//               ),
//             ),
//           ],
//         ),
//         SizedBox(height: 10.h),
//
//         // Horizontal Scroll Tabs
//         SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: Row(
//             children: tabs.map((tab) {
//               final isSelected = selectedTab == tab;
//               return GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     selectedTab = tab;
//                   });
//                 },
//                 child: Container(
//                   margin: EdgeInsets.only(right: 8.w),
//                   padding:
//                   EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
//                   decoration: BoxDecoration(
//                     color: isSelected
//                         ? AllColor.borderColor
//                         : AllColor.white,
//                     border: Border.all(
//                       color: isSelected
//                           ? AllColor.borderColor
//                           : AllColor.grey300,
//                     ),
//                     borderRadius: BorderRadius.circular(20.r),
//                   ),
//                   child: Text(
//                     tab,
//                     style: TextStyle(
//                       fontSize: 12.sp,
//                       fontWeight: FontWeight.w500,
//                       color: AllColor.black,
//                     ),
//                   ),
//                 ),
//               );
//             }).toList(),
//           ),
//         ),
//       ],
//     );
//   }
// }