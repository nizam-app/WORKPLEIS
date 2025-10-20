import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/core/widget/global_app_bar.dart';

class ServiceJobDetails extends StatefulWidget {
  const ServiceJobDetails({super.key});
  static const routeName = '/serviceJobDetails';

  @override
  State<ServiceJobDetails> createState() => _ServiceJobDetailsState();
}

class _ServiceJobDetailsState extends State<ServiceJobDetails> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppbar(text: "Job Details"),
      body: Column(
        children: [
          Container(
            color: AllColor.white,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Make an offer now',
                  style: TextStyle(fontSize: 20.sp, color: AllColor.black),
                ),
                SizedBox(height: 5.h),
                Text(
                  '10 Job Seekers have offered this job already',
                  style: TextStyle(fontSize: 14.sp, color: AllColor.black87),
                ),
                SizedBox(height: 10.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AllColor.brand2_light,
                      foregroundColor: AllColor.white,
                      padding: EdgeInsets.symmetric(vertical: 12.w),
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        builder: (context) {
                          return Padding(
                            padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom,
                              top: 20,
                              left: 20,
                              right: 20,
                            ),
                            child: const _ApplyForm(), // ✅ shows the form inside modal
                          );
                        },
                      );
                    },
                    child: const Text('Make Offer'),
                  ),
                ),

              ],
            ),
          ),
          Expanded(
            child: Card(
              child: ListView(
                padding: EdgeInsets.all(16),
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
                      Text('Posted 2h ago'),
                      SizedBox(width: 12.w),
                      Icon(Icons.group, color: AllColor.black, size: 16.sp),
                      SizedBox(width: 4.w),
                      Text('42 applied'),
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
                  SizedBox(height: 6.h),
                  Text(
                    'Looking for experienced cleaner for weekly deep cleaning of modern 3-bedroom house near Bondi Beach. Includes kitchen deep clean, bathroom sanitizing, living areas, and window cleaning. Must bring own eco-friendly supplies and equipment.',
                    style: TextStyle(fontSize: 13.sp),
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.grey,
                        child: Icon(Icons.person, color: Colors.white),
                      ),
                      SizedBox(width: 10.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('John Due',
                              style: TextStyle(
                                  fontSize: 14.sp, fontWeight: FontWeight.w600)),
                          Row(
                            children: [
                              Icon(Icons.star, size: 14.sp, color: Colors.orange),
                              SizedBox(width: 4.w),
                              Text('4.9', style: TextStyle(fontSize: 12.sp)),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),

                  /// 🔁 Custom Toggle Buttons
                  Container(
                    height: 45.h,
                    decoration: BoxDecoration(
                      color: AllColor.white,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: AllColor.brand2_light, width: 1.w),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => selectedIndex = 0),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              decoration: BoxDecoration(
                                color: selectedIndex == 0
                                    ? AllColor.brand2_light
                                    : AllColor.white,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                'Offers',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.sp,
                                  color: selectedIndex == 0
                                      ? Colors.white
                                      : AllColor.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => selectedIndex = 1),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              decoration: BoxDecoration(
                                color: selectedIndex == 1
                                    ? AllColor.brand2_light
                                    : AllColor.white,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                'Questions',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.sp,
                                  color: selectedIndex == 1
                                      ? Colors.white
                                      : AllColor.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20.h),

                  /// 🔁 Conditional Content
                  selectedIndex == 0 ? offerListView() : questionListView(),
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            jobDetailRow('Category', 'Home Service'),
            jobDetailRow('Job Type', 'Onsite'),
            jobDetailRow('Time', 'Flexible'),
            jobDetailRow('Location', 'Bondi Beach'),
          ],
        ),
      ),
    );
  }

  Widget jobDetailRow(String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13.sp),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(value, style: TextStyle(fontSize: 13.sp)),
          ),
        ],
      ),
    );
  }

  Widget offerListView() {
    return Column(
      children: [
        offerCard('\$3,500', '3-5 days'),
        SizedBox(height: 10.h),
        offerCard('\$3,000', '10 days'),
      ],
    );
  }

  Widget offerCard(String price, String duration) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 22.r,
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, color: Colors.black),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('John Due',
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 14.sp)),
                  Row(
                    children: [
                      Icon(Icons.star, size: 16.sp, color: Colors.orange),
                      SizedBox(width: 4.w),
                      Text('4.9', style: TextStyle(fontSize: 12.sp)),
                      const Spacer(),
                      Text(price,
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Seeking experienced full-stack developer to build modern e-commerce platform with React/Node.js.',
                    style: TextStyle(fontSize: 12.sp),
                  ),
                  SizedBox(height: 4.h),
                  Text('Est: $duration',
                      style: TextStyle(fontSize: 12, color: AllColor.grey)),
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
      margin: EdgeInsets.symmetric(vertical: 6.h),
      child: Container(
        padding: EdgeInsets.all(10),
        constraints: BoxConstraints(maxWidth: 250.w),
        decoration: BoxDecoration(
          color: isMe ? const Color(0xFF5B4DBC) : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          message,
          style: TextStyle(
              color: isMe ? Colors.white : Colors.black87, fontSize: 13.sp),
        ),
      ),
    );
  }

  Widget chatInputField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                contentPadding:
                EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                hintText: 'Ask a question',
                hintStyle: TextStyle(fontSize: 13.sp),
                filled: true,
                fillColor: Colors.white,
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
          SizedBox(width: 8.w),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.send, color: Color(0xFF5B4DBC)),
          )
        ],
      ),
    );
  }
}



class _ApplyForm extends StatelessWidget {
  const _ApplyForm({super.key});

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Color(0xFFCCCCCC), width: 1.2),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _label("Price"),
         SizedBox(height: 6.h),
        TextField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: "\$60",
            border: border,
            enabledBorder: border,
            focusedBorder: border.copyWith(
              borderSide: const BorderSide(color: Color(0xFF5B4DBC), width: 1.4),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          ),
        ),
         SizedBox(height: 16.h),
        _label("Note for client"),
         SizedBox(height: 6.h),
        TextField(
          maxLines: 3,
          decoration: InputDecoration(
            hintText: "Explain here, why you are the right person.",
            border: border,
            enabledBorder: border,
            focusedBorder: border.copyWith(
              borderSide: const BorderSide(color: Color(0xFF5B4DBC), width: 1.4),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          ),
        ),
         SizedBox(height: 16.h),

        _label("Estimated Completion"),
         SizedBox(height: 6.h),
        TextField(
          decoration: InputDecoration(
            hintText: "e.g. 1 days, 5 days, 1 week",
            border: border,
            enabledBorder: border,
            focusedBorder: border.copyWith(
              borderSide: const BorderSide(color: Color(0xFF5B4DBC), width: 1.4),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          ),
        ),
         SizedBox(height: 20.h),

        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AllColor.brand2_light, // neon green
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {


            },
            child: const Text("Apply", style: TextStyle(fontWeight: FontWeight.w600)),
          ),
        ),
         SizedBox(height: 20.h),
      ],
    );
  }

  Widget _label(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(text,
          style:  TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Color(0xFF5B4DBC),
          )),
    );
  }
}
