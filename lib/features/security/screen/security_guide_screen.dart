import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/core/widget/global_app_bar.dart';
import 'package:workpleis/features/message/screen/chat_screen.dart';

class SecurityGuideScreen extends StatefulWidget {
  const SecurityGuideScreen({super.key});
  static const routeName = '/securityGuideScreen';

  @override
  State<SecurityGuideScreen> createState() => _SecurityGuideScreenState();
}

class _SecurityGuideScreenState extends State<SecurityGuideScreen> {
  int selectedTab = 0; // 0 = FAQ, 1 = Contact, 2 = Guide


  final guides = [
    {
      "icon": Icons.verified_user,
      "title": "Quick Start Guide",
      "subtitle": "3 sections"
    },
    {
      "icon": Icons.person_add_alt,
      "title": "Client",
      "subtitle": "3 sections"
    },
    {
      "icon": Icons.shield_outlined,
      "title": "Safety Guidelines",
      "subtitle": "3 sections"
    },
  ];

  String selectedCategory = "Safety Concern";

  @override
  Widget build(BuildContext context) {
    final theme = Theme
        .of(context)
        .textTheme;

    return Scaffold(
      backgroundColor: AllColor.white,
      appBar: GlobalAppbar(text: "Help & Support"),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _topCard(),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _tabItem("FAQ", 0),
                _tabItem("Contact", 1),
                _tabItem("Guide", 2),
              ],
            ),
            SizedBox(height: 16.h),

            if (selectedTab == 0) _faqTab(),
            if (selectedTab == 1) _contactTab(),
            if (selectedTab == 2) _guideTab(),
          ],
        ),
      ),
    );
  }

  /* 🔹 Top Section Card */
  Widget _topCard() {
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: AllColor.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AllColor.grey300, width: 1.w),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: AllColor.primary,
            radius: 22.r,

            child: Icon(Icons.verified_user, color: AllColor.black, size: 28.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Help & Support",
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w800,
                        color: AllColor.black,
                        fontFamily: "headFont"
                    ),),
                SizedBox(height: 4.h),
                Text("Find answers, get help, and learn how to use Workpleis.",
                    style:
                    TextStyle(fontSize: 12.sp, color: AllColor.black87, fontFamily: "OpenText", fontWeight: FontWeight.w400)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /* 🔹 Tabs */
  Widget _tabItem(String text, int index) {
    final isSelected = selectedTab == index;
    return GestureDetector(
      onTap: () => setState(() => selectedTab = index),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? AllColor.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
              color: isSelected ? AllColor.primary : AllColor.grey300),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: isSelected ? AllColor.black : AllColor.black, fontFamily: "OpenText"
          ),
        ),
      ),
    );
  }


  final ValueNotifier<int?> expandedFaqIndex = ValueNotifier<int?>(null);

// 🟨 Example JSON Data
  final List<Map<String, dynamic>> faqs = [
    {
      "icon": Icons.verified_user,
      "title": "Getting Started",
      "description":
      "Here you’ll find helpful information related to Getting Started. Tap below to explore detailed FAQs and guidance on this topic.",
    },
    {
      "icon": Icons.payment_rounded,
      "title": "Jobs & Payments",
      "description":
      "Here you’ll find helpful information related to Jobs & Payments. Tap below to explore detailed FAQs and guidance on this topic.",
    },
    {
      "icon": Icons.safety_check,
      "title": "Safety & Trust",
      "description":
      "Here you’ll find helpful information related to Safety & Trust. Tap below to explore detailed FAQs and guidance on this topic.",
    },
    {
      "icon": Icons.person_add_alt,
      "title": "Account & Profile",
      "description":
      "Here you’ll find helpful information related to Account & Profile. Tap below to explore detailed FAQs and guidance on this topic.",
    },
  ];


  Widget _faqTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _searchField(),
        SizedBox(height: 20.h),

        // 🟢 Listen for expansion toggle
        ValueListenableBuilder<int?>(
          valueListenable: expandedFaqIndex,
          builder: (context, expandedIndex, _) {
            return Column(
              children: [
                ...faqs.asMap().entries.map((entry) {
                  int index = entry.key;
                  var f = entry.value;
                  bool isExpanded = expandedIndex == index;

                  return GestureDetector(
                    onTap: () {
                      expandedFaqIndex.value = isExpanded ? null : index;
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeInOut,
                      margin: EdgeInsets.only(bottom: 12.h),
                      padding: EdgeInsets.all(14.w),
                      decoration: BoxDecoration(
                        color: AllColor.white,
                        borderRadius: BorderRadius.circular(10.r),
                        border:
                        Border.all(color: AllColor.grey, width: 1.w),
                        boxShadow: [
                          if (isExpanded)
                            BoxShadow(
                              color: AllColor.grey,
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // Header Row
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: AllColor.primary,
                                    radius: 18.r,
                                    child: Icon(
                                      f["icon"] as IconData,
                                      color: AllColor.black,
                                      size: 20.sp,
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  Text(
                                    f["title"] as String,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w800,
                                      color: AllColor.black,
                                      fontFamily: "headFont",
                                    ),
                                  ),
                                ],
                              ),
                              Icon(
                                isExpanded
                                    ? Icons.keyboard_arrow_up_rounded
                                    : Icons.keyboard_arrow_down_sharp,
                                color: AllColor.black,
                                size: 20.sp,
                              ),
                            ],
                          ),

                          // Expanded Content
                          if (isExpanded) ...[
                            SizedBox(height: 10.h),
                            Divider(
                                color: AllColor.grey, thickness: 0.5),
                            SizedBox(height: 8.h),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                f["description"] ?? "",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: AllColor.black,
                                  fontFamily: "OpenText",
                                  fontWeight: FontWeight.w400,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                }),
              ],
            );
          },
        ),
      ],
    );
  }

  /* 🔹 Contact Tab (Updated Full Design) */
  Widget _contactTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            "Send us a message",
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w800,
              color: AllColor.black,
              fontFamily: "headFont"
            ),
          ),
        ),
        SizedBox(height: 20.h),

        // Category
        Text("Category",
            style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w800,
                color: AllColor.black,
              fontFamily: "headFont"

            )),
        SizedBox(height: 6.h),
        GestureDetector(
          onTap: () => _showCategoryDialog(),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
            decoration: BoxDecoration(
              border: Border.all(color: AllColor.grey300, width: 1.2),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedCategory,
                  style: TextStyle(fontSize: 14.sp, color: AllColor.black,
                      fontWeight: FontWeight.w400, fontFamily: "OpenText"),
                ),
                Icon(Icons.keyboard_arrow_down_rounded,
                    color: AllColor.grey, size: 20.sp),
              ],
            ),
          ),
        ),
        SizedBox(height: 16.h),

        // Subject
        Text("Subject",
            style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w800,
                color: AllColor.black,
            fontFamily: "headFont"
            )
        ),
        SizedBox(height: 6.h),
        TextField(

          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: AllColor.black,
            fontFamily: "OpenText",
          ),
          decoration: InputDecoration(
            hintText: "Brief description of your issue",
            hintStyle: TextStyle(fontSize: 14.sp, color: AllColor.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: AllColor.grey300),
            ),
          ),
        ),
        SizedBox(height: 16.h),

        // Message
        Text("Message",
            style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w800,
                color: AllColor.black,
                fontFamily: "headFont"
            )),
        SizedBox(height: 6.h),
        TextField(
          style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AllColor.black,
              fontFamily: "OpenText"

          ),
          maxLines: 5,
          decoration: InputDecoration(
            hintText: "Please provide as much detail as possible...",
            hintStyle: TextStyle(fontSize: 14.sp, color: AllColor.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: AllColor.grey300),
            ),
          ),
        ),
        SizedBox(height: 24.h),

        // Send Message Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            icon: const Icon(Icons.send_rounded, color: Colors.black),
            label: Text(
              "Send Message",
              style: TextStyle(
                  color: AllColor.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
              fontFamily: "OpenText"
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AllColor.primary,
              padding: EdgeInsets.symmetric(vertical: 14.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            onPressed: () {
              context.push(ChatScreen.routeName);
            },
          ),
        ),
      ],
    );
  }

  /* 🔹 Guide Tab */

  //
  // Widget _guideTab() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       _searchField(),
  //       SizedBox(height: 20.h),
  //       ...guides.map(
  //             (g) => Container(
  //           margin: EdgeInsets.only(bottom: 12.h),
  //           padding: EdgeInsets.all(14.w),
  //           decoration: BoxDecoration(
  //             color: AllColor.white,
  //             borderRadius: BorderRadius.circular(10.r),
  //             border: Border.all(color: AllColor.grey, width: 1.w),
  //           ),
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               Row(
  //                 children: [
  //                   CircleAvatar(
  //                     backgroundColor: AllColor.primary,
  //                     radius: 18.r,
  //                     child: Icon(
  //                       g["icon"] as IconData,
  //                       color: AllColor.black,
  //                       size: 20.sp,
  //                     ),
  //                   ),
  //                   SizedBox(width: 10.w),
  //                   Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Text(
  //                         g["title"] as String,
  //                         style: TextStyle(
  //                           fontSize: 16.sp,
  //                           fontWeight: FontWeight.w400,
  //                           color: AllColor.black,
  //                           fontFamily: "OpenText"
  //                         ),
  //                       ),
  //                       Text(
  //                         g["subtitle"] as String,
  //                         style: TextStyle(
  //                           fontSize: 14.sp,
  //                           color: AllColor.black,
  //                           fontWeight: FontWeight.w400,
  //                           fontFamily: "OpenText"
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //               const Icon(Icons.keyboard_arrow_down,
  //                   color: AllColor.black),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }


  int? expandedIndex; // Add this at top of class (state)

  /* 🔹 Guide Tab */
  Widget _guideTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _searchField(),
        SizedBox(height: 20.h),
        ...guides.asMap().entries.map((entry) {
          int index = entry.key;
          var g = entry.value;
          bool isExpanded = expandedIndex == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                expandedIndex = isExpanded ? null : index;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              margin: EdgeInsets.only(bottom: 12.h),
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                color: AllColor.white,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: AllColor.grey, width: 1.w),
                boxShadow: [
                  if (isExpanded)
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                ],
              ),
              child: Column(
                children: [
                  // top row (same as before)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: AllColor.primary,
                            radius: 18.r,
                            child: Icon(
                              g["icon"] as IconData,
                              color: AllColor.black,
                              size: 20.sp,
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                g["title"] as String,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w800,
                                  color: AllColor.black,
                                  fontFamily: "headFont",
                                ),
                              ),
                              // Text(
                              //   g["subtitle"] as String,
                              //   style: TextStyle(
                              //     fontSize: 14.sp,
                              //     color: AllColor.black,
                              //     fontWeight: FontWeight.w400,
                              //     fontFamily: "OpenText",
                              //   ),
                              // ),
                            ],
                          ),
                        ],
                      ),
                      Icon(
                        isExpanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: AllColor.black,
                      ),
                    ],
                  ),

                  // expanded area
                  if (isExpanded) ...[
                    SizedBox(height: 10.h),
                    Divider(color: AllColor.grey, thickness: 0.5),
                    SizedBox(height: 8.h),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "This section contains important guidance for ${g["title"]}. Tap here to learn more or open detailed instructions.",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AllColor.black,
                          fontFamily: "OpenText",
                          fontWeight: FontWeight.w400,
                          height: 1.4,
                        ),
                      ),
                    ),

                  ],
                ],
              ),
            ),
          );
        }),
      ],
    );
  }


  /* 🔹 Search Field Common */
  Widget _searchField() {
    return TextField(
      style: TextStyle(fontSize: 13.sp, color: AllColor.black),
      decoration: InputDecoration(
        isDense: true,
        prefixIcon: Icon(Icons.search, color: AllColor.grey),
        hintText: "Search frequently asked questions..",
        hintStyle: TextStyle(fontSize: 12.sp, color: AllColor.grey),
        border: InputBorder.none, // No underline or box
        contentPadding: EdgeInsets.symmetric(vertical: 10.h),
      ),
    );
  }



  // Widget _searchField() {
  //   return
  //    //  Container(
  //    // // padding: EdgeInsets.symmetric(horizontal: 12.w),
  //    //  decoration: BoxDecoration(
  //    //    border: Border.all(color: AllColor.grey300),
  //    //    borderRadius: BorderRadius.circular(8.r),
  //    //  ),
  //    //  child:
  //
  //         // SizedBox(width: 8.w),
  //         TextField(
  //
  //           decoration: InputDecoration(
  //
  //             prefix: Icon(Icons.search ,color: AllColor.grey,),
  //             border: InputBorder.none,
  //             hintText: "Search frequently asked questions..",
  //             hintStyle: TextStyle(fontSize: 12.sp, color: AllColor.grey),
  //           ),
  //
  //
  //   );
  // }

  /* 🔹 Category Bottom Sheet */
  void _showCategoryDialog() {
    final categories = [
      "Safety Concern",
      "Technical Issue",
      "Payments & Billing",
      "Account Help",
      "Other"
    ];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          title: Text(
            "Select Category",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w800,
              color: AllColor.black,
              fontFamily: "headFont"
            ),
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final cat = categories[index];
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    cat,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AllColor.black,
                      fontFamily: "OpenText",
                      fontWeight: FontWeight.w400
                    ),
                  ),
                  trailing: selectedCategory == cat
                      ? Icon(Icons.check, color: AllColor.brand2_light)
                      : null,
                  onTap: () {
                    setState(() => selectedCategory = cat);
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}








// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:workpleis/core/constants/color_control/all_color.dart';
// import 'package:workpleis/core/widget/global_app_bar.dart';
//
// class SecurityGuideScreen extends StatefulWidget {
//   const SecurityGuideScreen({super.key});
//   static const routeName = '/securityGuideScreen';
//
//   @override
//   State<SecurityGuideScreen> createState() => _SecurityGuideScreenState();
// }
//
// class _SecurityGuideScreenState extends State<SecurityGuideScreen> {
//   int selectedTab = 2; // 0=FAQ, 1=Contact, 2=Guide
//
//   final guides = [
//     {"icon": Icons.menu_book, "title": "Quick Start Guide", "subtitle": "3 sections"},
//     {"icon": Icons.people_alt_outlined, "title": "For Posters", "subtitle": "3 sections"},
//     {"icon": Icons.person_outline, "title": "For Taskers", "subtitle": "3 sections"},
//     {"icon": Icons.shield_outlined, "title": "Safety Guidelines", "subtitle": "3 sections"},
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: GlobalAppbar(text: "Help & Support"),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16.w),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             /* ================= TOP CARD ================= */
//             Container(
//               padding: EdgeInsets.all(16.w),
//               decoration: BoxDecoration(
//                 color: AllColor.white,
//                 borderRadius: BorderRadius.circular(12.r),
//                 border:Border.all(color: AllColor.grey300, width: 1.w),
//               ),
//               child: Row(
//                 children: [
//                   CircleAvatar(
//                     backgroundColor: AllColor.borderColor,
//                     radius: 20.r,
//                     child: Icon(Icons.verified_user,
//                         color: AllColor.white, size: 30.sp),
//                   ),
//                   SizedBox(width: 12.w),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text("Help & Support",
//                             style: TextStyle(
//                                 fontSize: 14.sp,
//                                 fontWeight: FontWeight.w500,
//                                 color: AllColor.black)),
//                         SizedBox(height: 4.h),
//                         Text("Find answers, get help, and learn how to use workpleis",
//                             style: TextStyle(
//                                 fontSize: 12.sp, color: AllColor.black)),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             SizedBox(height: 20.h),
//
//
//
//
//             /* ================= TABS ================= */
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 _tabItem("FAQ", 0),
//                 _tabItem("Contact", 1),
//                 _tabItem("Guide", 2),
//               ],
//             ),
//
//             SizedBox(height: 16.h),
//
//             /* ================= SEARCH ================= */
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 12.w),
//               decoration: BoxDecoration(
//                 border: Border.all(color: AllColor.grey300),
//                 borderRadius: BorderRadius.circular(8.r),
//               ),
//               child: Row(
//                 children: [
//                   Icon(Icons.search, color: AllColor.grey, size: 20.sp),
//                   SizedBox(width: 8.w),
//                   Expanded(
//                     child: TextField(
//                       decoration: InputDecoration(
//                         border: InputBorder.none,
//                         hintText: "Search frequently asked questions..",
//                         hintStyle: TextStyle(
//                             fontSize: 12.sp, color: AllColor.grey),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             SizedBox(height: 20.h),
//
//             /* ================= GUIDE LIST ================= */
//             ...guides.map((g) => Container(
//               margin: EdgeInsets.only(bottom: 12.h),
//               padding: EdgeInsets.all(14.w),
//               decoration: BoxDecoration(
//                 color: AllColor.white,
//                 borderRadius: BorderRadius.circular(12.r),
//                 border: Border.all(color: AllColor.borderColor, width: 1.w),
//               ),
//               child: Row(
//                 children: [
//                   CircleAvatar(
//                     backgroundColor: AllColor.borderColor,
//                     radius: 20.r,
//                     child: Icon(g["icon"] as IconData,
//                         color: AllColor.white, size: 26.sp),
//                   ),
//                   SizedBox(width: 12.w),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(g["title"] as String,
//                             style: TextStyle(
//                                 fontSize: 16.sp,
//                                 fontWeight: FontWeight.w500,
//                                 color: AllColor.black)),
//                         SizedBox(height: 4.h),
//                         Text(g["subtitle"] as String,
//                             style: TextStyle(
//                                 fontSize: 12.sp, color: AllColor.black87)),
//                       ],
//                     ),
//                   ),
//                   Icon(Icons.arrow_forward_ios,
//                       color: AllColor.black87, size: 16.sp),
//                 ],
//               ),
//             )),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _tabItem(String text, int index) {
//     final isSelected = selectedTab == index;
//     return GestureDetector(
//       onTap: () => setState(() => selectedTab = index),
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
//         decoration: BoxDecoration(
//           color: isSelected ? AllColor.brand2_light : Colors.transparent,
//           borderRadius: BorderRadius.circular(8.r),
//           border: Border.all(
//               color: isSelected ? AllColor.brand2_light : AllColor.grey300),
//         ),
//         child: Text(text,
//             style: TextStyle(
//                 fontSize: 13.sp,
//                 fontWeight: FontWeight.w500,
//                 color: isSelected ? AllColor.white : AllColor.black)),
//       ),
//     );
//   }
// }