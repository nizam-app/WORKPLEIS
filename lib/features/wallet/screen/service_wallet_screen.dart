import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';

import '../../../core/widget/global_app_bar.dart';
import '../widget/custom_available_balance_card.dart';

class ProviderWalletScreen extends StatefulWidget {
  const ProviderWalletScreen({super.key});
  static const routeName = "/serviceWalletScreen";


  @override
  State<ProviderWalletScreen> createState() => _ProviderWalletScreenState();
}

class _ProviderWalletScreenState extends State<ProviderWalletScreen> {
  int selectedTab = 0; // 0 = All, 1 = Withdrawals

  final List<Map<String, dynamic>> transactions = [
    {
      "title": "Payment from Client John",
      "desc": "Mobile App Design Task",
      "amount": 500,
      "isIncome": true,
      "time": "3 hours ago",
    },
    {
      "title": "Refund to Client Mike Chen",
      "desc": "Project Cancellation",
      "amount": -300,
      "isIncome": false,
      "time": "5 hours ago",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredList = selectedTab == 0
        ? transactions
        : transactions.where((e) => !e['isIncome']).toList();

    return Scaffold(

      appBar: GlobalAppbar(text: "Profile"),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [
            CustomAavailableBalanceCard(buttonText: 'Withdraw',),
            const SizedBox(height: 20),

            // ✅ Stats Row
            Row(
              children: const [
                _StatCard(
                  title: "Total Withdrawals",
                  value: "\$3,450",
                  icon: Icons.wallet_outlined,
                ),
                Spacer(),
                _StatCard(
                  title: "Pending Earnings",
                  value: "\$850",
                  icon: Icons.timer_outlined,
                  isSecondary: true,
                ),
              ],
            ),

         Row(
           children: [
             _StatCard(
                  title: "Total Earnings",
                  value: "\$5,450",
                  icon: Icons.monetization_on_outlined,
                ),
             Spacer(),
             SizedBox(

             )
           ],
         ),
             SizedBox(height: 25.h),

            // ✅ Tabs
            Container(
              height: 45,
              decoration: BoxDecoration(
                color: AllColor.white,
                borderRadius: BorderRadius.circular(999.r),
                border: Border.all(color: AllColor.brand2_light),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => selectedTab = 0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: selectedTab == 0
                              ? AllColor.brand2_light
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(199.r),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "All",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: selectedTab == 0
                                ? AllColor.white
                                : AllColor.black87,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => selectedTab = 1),
                      child: Container(
                        decoration: BoxDecoration(
                          color: selectedTab == 1
                              ? AllColor.brand2_light
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "Withdrawals",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: selectedTab == 1
                                ? AllColor.white
                                : AllColor.black87,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
             SizedBox(height: 20.h),

            // ✅ Transaction List
            if (filteredList.isEmpty)
               Padding(
                padding: EdgeInsets.only(top: 40.h),
                child: Text(
                  "No Transactions Found",
                  style: TextStyle(color: AllColor.black45),
                ),
              )
            else
              Column(
                children: filteredList
                    .map((t) => _TransactionTile(data: t))
                    .toList(),
              ),
          ],
        ),
      ),
    );
  }
}

// ===============================
// COMPONENTS
// ===============================

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final bool isSecondary;
  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    this.isSecondary = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170.w,
      margin:  EdgeInsets.only(bottom: 12.h),
      padding:  EdgeInsets.symmetric(vertical: 16.h,horizontal: 5.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isSecondary ? AllColor.black87 : AllColor.black87,
        ),
      ),
      child: Column(
        children: [
          Icon(icon,
              color: isSecondary ? AllColor.black45 : AllColor.black87, size: 24),
           SizedBox(height: 8.h),
          Text(
            title,
            style:  TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: AllColor.black87,
            ),
          ),
           SizedBox(height: 4.h),
          Text(
            value,
            style:  TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
              color: AllColor.black,
            ),
          ),
        ],
      ),
    );
  }
}

class _TransactionTile extends StatelessWidget {
  final Map<String, dynamic> data;
  const _TransactionTile({required this.data});

  @override
  Widget build(BuildContext context) {
    final isIncome = data['isIncome'] as bool;
    final color = isIncome ? Colors.green : Colors.red;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                isIncome
                    ? Icons.arrow_downward_rounded
                    : Icons.arrow_upward_rounded,
                color: color,
                size: 20.sp,
              ),
               SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  data['title'],
                  style:  TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
              Text(
                (isIncome ? "+" : "-") +
                    "\$${data['amount'].abs().toStringAsFixed(2)}",
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ],
          ),
           SizedBox(height: 6.h),
          Text(
            data['desc'],
            style:  TextStyle(fontSize: 12.sp, color: AllColor.black54),
          ),
           SizedBox(height: 6.h),
          Text(
            data['time'],
            style:  TextStyle(fontSize: 11.sp, color: AllColor.black87),
          ),
        ],
      ),
    );
  }
}
