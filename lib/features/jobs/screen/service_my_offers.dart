import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/core/widget/global_app_bar.dart';
import 'package:workpleis/features/tracking/client_offer_tracking/offer_tacking_screen.dart';

import 'Service_jobs_details.dart';

final tabProvider = StateProvider<int>((_) => 0);

class JobData {
  JobData(this.title, this.price, this.desc, this.eta, {this.status = "pending"});

  final String title;
  final int price;
  final String desc;
  final String eta;
  final String status;
}

final jobsProvider = StateNotifierProvider<_JobState, List<JobData>>((_) => _JobState());

class _JobState extends StateNotifier<List<JobData>> {
  _JobState()
      : super([
    JobData("Full-stack Developer", 3500, "Seeking experienced full-stack developer to build modern e-commerce platform with React/Node.js.", "3–5 days"),
    JobData("UI Designer", 1800, "Redesign dashboard UI with new theme and components.", "5–7 days", status: "accepted"),
    JobData("API Integration", 900, "Integrate Stripe & Firebase Authentication to existing app.", "2–4 days", status: "rejected"),
  ]);

  void updateStatus(int index, String newStatus) {
    state = [
      for (int i = 0; i < state.length; i++)
        i == index
            ? JobData(state[i].title, state[i].price, state[i].desc, state[i].eta, status: newStatus)
            : state[i]
    ];
  }
}

class JobsOffers extends ConsumerWidget {
  const JobsOffers({super.key});
  static const routeName = "/jobsOffers";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tab = ref.watch(tabProvider);
    final jobs = ref.watch(jobsProvider);

    final filtered = jobs.where((job) {
      switch (tab) {
        case 0:
          return job.status == "pending";
        case 1:
          return job.status == "accepted";
        case 2:
          return job.status == "rejected";
        default:
          return false;
      }
    }).toList();

    return Scaffold(
      appBar: const GlobalAppbar(text: "My Offers"),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            // _buildSearchBar(),
            10.verticalSpace,
        Row(
          children: [
            Expanded(
              child: _TabBar(
                tab: tab,
                onSelect: (i) => ref.read(tabProvider.notifier).state = i,
              ),
            ),
            SizedBox(width:40.w,),
            Text(
              "${filtered.length} ${["Pending", "Accepted", "Rejected"][tab]}",
              style: TextStyle(
                color: AllColor.brand2_light,
                fontWeight: FontWeight.w500,
                fontSize: 13.sp,
              ),
            ),
          ],
        ),
            12.verticalSpace,
            Expanded(
              child: filtered.isEmpty
                  ? Center(
                child: Text(
                  "No ${["Pending", "Accepted", "Rejected"][tab]} jobs",
                  style: TextStyle(color:AllColor.black, fontSize: 14.sp),
                ),
              )
                  : ListView.separated(
                itemCount: filtered.length,
                separatorBuilder: (_, __) => 12.verticalSpace,
                itemBuilder: (_, i) => _JobCard(data: filtered[i]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildSearchBar() {
  //   return TextField(
  //     decoration: InputDecoration(
  //       hintText: "What do you need done today?",
  //       prefixIcon: Icon(Icons.search, color: AllColor.grey),
  //       fillColor: AllColor.white,
  //       filled: true,
  //       border: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(12.r),
  //         borderSide: BorderSide(color: AllColor.borderColor, width: 1.2),
  //       ),
  //     ),
  //   );
  // }
}

class _TabBar extends StatelessWidget {
  const _TabBar({required this.tab, required this.onSelect});

  final int tab;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    final items = ["Pending", "Accepted", "Rejected"];
    return Container(
      padding: EdgeInsets.all(2.r),
      decoration: BoxDecoration(
        color: AllColor.white,
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(items.length, (i) {
          final selected = tab == i;
          return GestureDetector(
            onTap: () => onSelect(i),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: selected ? AllColor.brand2_light : AllColor.white,
                border: Border.all(
                  color: const Color(0xFF154E7B).withOpacity(0.2),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(25.r),
              ),
              child: Text(
                items[i],
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color:selected? AllColor.white: AllColor.black,
                  fontFamily: "bodyFont"

                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}


class _JobCard extends StatelessWidget {
  const _JobCard({required this.data});

  final JobData data;

  @override
  Widget build(BuildContext context) {
    final status = data.status;

    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AllColor.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AllColor.borderColor.withOpacity(.4)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 8, offset: const Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          10.verticalSpace,
          Text(
            data.desc,
            style: TextStyle(color: AllColor.black87, fontSize: 13.sp, height: 1.3),
          ),
          10.verticalSpace,
          Row(
            children: [
              Text(
                "Est: ${data.eta}",
                style: TextStyle(color: AllColor.black.withOpacity(.8), fontSize: 12.sp, fontWeight: FontWeight.w500),
              ),
              const Spacer(),
              if (status == "pending") _pill("")
              else if (status == "accepted") _pill("Update Job",onTop: (){context.push(OfferTackingScreen.routeName);})
              else InkWell(
                    onTap: (){
                      showRejectionMessageSheet(context);
                    },
                    child: _pill("Reason")),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 18.r,
          backgroundColor: AllColor.primary.withOpacity(0.4),
          child: const Icon(Icons.person, color: AllColor.brand2_light),
        ),
        10.horizontalSpace,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("John Due", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700, color: AllColor.black)),
              4.verticalSpace,
              Row(
                children: [
                  Icon(Icons.star, size: 14.sp, color: AllColor.brand2_light),
                  4.horizontalSpace,
                  Text("4.9", style: TextStyle(fontSize: 12.sp, color: AllColor.black, fontWeight: FontWeight.w600)),
                ],
              ),
            ],
          ),
        ),
        Text("\$${data.price}", style: TextStyle(color: AllColor.black, fontWeight: FontWeight.w700, fontSize: 14.sp)),
      ],
    );
  }

  Widget _pill(String? label, {VoidCallback? onTop}) {
    return InkWell(
      onTap:onTop,
      child: Text(
        label ??"",
        style: TextStyle(color: AllColor.brand2_light, fontWeight: FontWeight.w600, fontSize: 12.5.sp, fontFamily: "bodyFont"),
      ),
    );
  }
}


//Show RejecttionMessageSheet

void showRejectionMessageSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    // shape: RoundedRectangleBorder(
    //   borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    // ),
    builder: (context) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Rejection Message",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AllColor.black,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close, color: Colors.black, size: 20),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Message box
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFF4F4F4), // Light grey background
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(12),
              child: const Text(
                "All plumbing issues have been resolved. Replaced the faulty pipes and installed new faucets as requested. System tested and working perfectly.",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  height: 1.4,
                ),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      );
    },
  );
}
