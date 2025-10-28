import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/core/widget/global_app_bar.dart';

import '../widget/custom_available_balance_card.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});
  static const routeName = "/walletScreen";

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  int selectedTab = 0;

  final List<Map<String, dynamic>> allTransactions = [
    {
      "title": "Payment from Client John",
      "desc": "Mobile App Design Task",
      "amount": 500,
      "isIncome": true,
    },
    {
      "title": "Refund to Client Mike Chen",
      "desc": "Project Cancellation",
      "amount": -500,
      "isIncome": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final paid = allTransactions.where((e) => e['isIncome']).toList();
    final refund = allTransactions.where((e) => !e['isIncome']).toList();
    final list = selectedTab == 0
        ? allTransactions
        : selectedTab == 1
        ? paid
        : refund;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: GlobalAppbar(text: "Wallet"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            // 🔹 Balance Card
            CustomAavailableBalanceCard(buttonText: 'Add Funds',),
            SizedBox(height: 16.h),

            // 🔹 Stats Row
            Row(
              children: [
                _statCard("Paid Jobs", "\$3,450"),
                SizedBox(width: 12.w),
                _statCard("Pending Payments", "\$850"),
              ],
            ),
            SizedBox(height: 20.h),

            // 🔹 Tabs
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(999.r),
                border: Border.all(color: Colors.black12),
              ),
              child: Row(
                children: [
                  _tabButton("All", 0),
                  _tabButton("Paid", 1),
                  _tabButton("Refunds", 2),
                ],
              ),
            ),
            SizedBox(height: 20.h),

            // 🔹 Transaction List
            if (list.isEmpty)
              Center(
                child: Text(
                  "No Transactions Found",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AllColor.black54,
                  ),
                ),
              )
            else
              Column(
                children: List.generate(
                  list.length,
                      (i) => _transactionCard(list[i]),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _statCard(String title, String amount) => Expanded(
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 15.h),
      decoration: BoxDecoration(
        color: AllColor.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AllColor.grey),
      ),
      child: Column(
        children: [
          Icon(Icons.wallet_rounded, color: AllColor.brand2_light),
          SizedBox(height: 4.h),
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12.sp,
                color: AllColor.black,
              fontFamily: "OpenText"
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            amount,
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
                color: AllColor.black,
            fontFamily: "OpenText"
            ),
          ),
        ],
      ),
    ),
  );

  Widget _tabButton(String text, int index) => Expanded(
    child: GestureDetector(
      onTap: () => setState(() => selectedTab = index),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
          color: selectedTab == index
              ? AllColor.primary
              : Colors.transparent,
          borderRadius: BorderRadius.circular(30.r),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16.sp,
            fontFamily: "OpenText",
            fontWeight: FontWeight.w400,
            color: selectedTab == index
                ? Colors.black
                : Colors.black,
          ),
        ),
      ),
    ),
  );

  Widget _transactionCard(Map<String, dynamic> data) {
    final isIncome = data['isIncome'] as bool;
    final color = isIncome ? Colors.green : Colors.red;

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
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
              SizedBox(width: 6.w),
              Expanded(
                child: Text(
                  data['title'],
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                    color: AllColor.black,
                    fontFamily: "OpenText"
                  ),
                ),
              ),
              Text(
                (isIncome ? "+" : "") +
                    "\$${data['amount'].abs().toStringAsFixed(2)}",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: color,
                  fontSize: 14.sp,
                  fontFamily:"OpenText"
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Text(
            data['desc'],
            style: TextStyle(
              color: AllColor.black,
              fontSize: 12.sp,
              fontFamily: "OpenText",
              fontWeight: FontWeight.w400
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            "3 mins ago",
            style: TextStyle(
              color: AllColor.black,
              fontSize: 12.sp,
              fontWeight: FontWeight.w200,
              fontFamily: "OpenText"
            ),
          ),
        ],
      ),
    );
  }
}

