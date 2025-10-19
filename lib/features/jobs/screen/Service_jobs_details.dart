import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/core/widget/global_app_bar.dart';

class ServiceJobDetails extends StatefulWidget {
  const ServiceJobDetails({super.key});
  static const routeName = '/serviceJobDetails';

  @override
  State<ServiceJobDetails> createState() => _ServiceJobDetailsState();
}

class _ServiceJobDetailsState extends State<ServiceJobDetails>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppbar(text: "Job Details"),
      body: Column(
        children: [
          Container(
            color: AllColor.white,
            padding:  EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Make an offer now',
                  style: TextStyle(
                      fontSize: 20.sp, color: AllColor.black),
                ),
                 SizedBox(height: 5.h),
                Text(
                  '10 Job Seekers have offered this job already',
                  style: TextStyle(
                      fontSize: 14.sp, color: AllColor.black87),
                ),
                 SizedBox(height: 10.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AllColor.brand2_light,
                      foregroundColor: AllColor.white,
                      padding:  EdgeInsets.symmetric(vertical: 12.w),
                    ),
                    onPressed: () {},
                    child: const Text('Make Offer'),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Card(
              child: ListView(
                padding:  EdgeInsets.all(16),
                children: [
                  Text(
                    'Deep house cleaning service needed',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Row(
                    children: [
                       Icon(Icons.access_time, size: 16.sp),
                       SizedBox(width: 4.h),
                      Text('Posted 2h ago', style: TextStyle()),
                       SizedBox(width: 12.w),
                       Icon(Icons.group, size: 16.sp),
                       SizedBox(width: 4.w),
                      Text('42 applied', style: TextStyle()),
                    ],
                  ),
                   SizedBox(height: 16.h),
                  jobDetailCard(),
                   SizedBox(height: 16.h),
                  Text(
                    'About This Job',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                   SizedBox(height: 6),
                  Text(
                    'Looking for experienced cleaner for weekly deep cleaning of modern 3-bedroom house near Bondi Beach. Includes kitchen deep clean, bathroom sanitizing, living areas, and window cleaning. Must bring own eco-friendly supplies and equipment.',
                    style: TextStyle(fontSize: 13),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.grey,
                        child: Icon(Icons.person, color: Colors.white),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('John Due',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600)),
                          Row(
                            children: [
                              const Icon(Icons.star,
                                  size: 14, color: Colors.orange),
                              const SizedBox(width: 4),
                              Text('4.9', style: TextStyle(fontSize: 12))
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TabBar(
                      controller: _tabController,
                      indicatorColor: const Color(0xFF5B4DBC),
                      labelColor: const Color(0xFF5B4DBC),
                      unselectedLabelColor: Colors.black54,
                      tabs: const [
                        Tab(text: 'Offers'),
                        Tab(text: 'Questions'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 300,
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        offerListView(),
                        questionListView(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget jobDetailCard() {
    return Card(
      color: AllColor.white,
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10, )),
      child: Padding(
        padding:  EdgeInsets.all(12),
        child: Column(
          children: [
            jobDetailRow('Category', 'Home Service'),
            jobDetailRow('Job Type', 'Onsite'),
            jobDetailRow('Time', 'Flexible'),
            jobDetailRow('Location', 'asdfdlsadsf'),
          ],
        ),
      ),
    );
  }

  Widget jobDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
              flex: 3,
              child: Text(
                title,
                style: TextStyle(fontWeight: FontWeight.w500),
              )),
          Expanded(
            flex: 5,
            child: Text(value, style: TextStyle()),
          )
        ],
      ),
    );
  }

  Widget offerListView() {
    return Column(
      children: [
        offerCard('\$3,500', '3-5 days'),
        const SizedBox(height: 10),
        offerCard('\$3,000', '10 days'),
      ],
    );
  }

  Widget offerCard(String price, String duration) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CircleAvatar(
              radius: 22,
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, color: Colors.black),
            ),
             SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('John Due',
                      style:TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 14.sp)),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 14, color: Colors.orange),
                      const SizedBox(width: 4),
                      Text('4.9', style: TextStyle(fontSize: 12)),
                      const Spacer(),
                      Text(price,
                          style: TextStyle(
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                   SizedBox(height: 4.h),
                  Text(
                    'Seeking experienced full-stack developer to build modern e-commerce platform with React/Node.js.',
                    style: TextStyle(fontSize: 12.sp),
                  ),
                  const SizedBox(height: 4),
                  Text('Est: $duration',
                      style: TextStyle(
                          fontSize: 12, color: Colors.grey.shade600)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget questionListView() {
    return Column(
      children: [
        chatBubble('Hello, how can I apply for this task?', false),
        chatBubble('Can you please share the process?', false),
        chatInputField(),
      ],
    );
  }

  Widget chatBubble(String message, bool isMe) {
    return Container(
      width: double.infinity,
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Container(
        padding: const EdgeInsets.all(10),
        constraints: const BoxConstraints(maxWidth: 250),
        decoration: BoxDecoration(
          color: isMe ? const Color(0xFF5B4DBC) : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          message,
          style: TextStyle(
              color: isMe ? Colors.white : Colors.black87, fontSize: 13),
        ),
      ),
    );
  }

  Widget chatInputField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                hintText: 'Ask a question',
                hintStyle: TextStyle(fontSize: 13),
                filled: true,
                fillColor: Colors.white,
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: () {

            },
            icon: const Icon(Icons.send, color: Color(0xFF5B4DBC)),
          )
        ],
      ),
    );
  }
}
