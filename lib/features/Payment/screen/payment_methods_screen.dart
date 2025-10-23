import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/core/widget/global_app_bar.dart';

class PaymentMethodsScreen extends StatelessWidget {
  const PaymentMethodsScreen({super.key});

  static const routeName = "/paymentMethods";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppbar(text: "Payment Methods"),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Manage your payment methods for secure transactions",
              style: TextStyle(fontSize: 14.sp, color: Colors.grey),
            ),
            SizedBox(height: 20.h),

            // 🔹 Add Payment Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AllColor.borderColor,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20.r)),
                    ),
                    builder: (_) => const AddPaymentMethodSheet(),
                  );
                },
                child: Text("Add Payment Method",
                    style: TextStyle(fontSize: 16.sp, color: Colors.white)),
              ),
            ),
            SizedBox(height: 20.h),

            // 🔹 Example Saved Card
            Container(
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: AllColor.grey200,
              ),
              child: Row(
                children: [
                  Icon(Icons.credit_card, size: 28.sp),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Text("**** **** **** 1234",
                        style: TextStyle(fontSize: 16.sp)),
                  ),
                  Container(
                    padding:
                    EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text("Default",
                        style: TextStyle(fontSize: 12.sp, color: Colors.white)),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 🔹 BottomSheet for Adding Payment
class AddPaymentMethodSheet extends StatelessWidget {
  const AddPaymentMethodSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final cardController = TextEditingController();
    final dateController = TextEditingController();
    final cvcController = TextEditingController();
    final nameController = TextEditingController();

    return Padding(
      padding: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20.h,
        top: 20.h,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Add Payment Method",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
            SizedBox(height: 20.h),

            // Card Number
            TextFormField(
              controller: cardController,
              decoration: const InputDecoration(
                labelText: "Card Number",
                hintText: "1223344556778544",
                hintStyle:  TextStyle(color: Colors.grey),
                labelStyle: const TextStyle(color: Colors.grey),
              ),
              keyboardType: TextInputType.number,

            ),
            SizedBox(height: 12.h),

            // Expiry + CVC
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: dateController,
                    decoration: const InputDecoration(
                      labelText: "MM/YY",
                      hintText: "12/24",
                      hintStyle:  TextStyle(color: Colors.grey),
                      labelStyle: const TextStyle(color: Colors.grey),
                    ),
                    keyboardType: TextInputType.datetime,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: TextFormField(
                    controller: cvcController,
                    decoration: const InputDecoration(
                      labelText: "CVC",
                      hintText: "123",
                      hintStyle:  TextStyle(color: Colors.grey),
                      labelStyle:  TextStyle(color: Colors.grey),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            // Cardholder Name
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Cardholder Name",
                hintText: "John Doe",
                hintStyle:  TextStyle(color: Colors.grey),
                labelStyle:  TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(height: 20.h),

            // Add Payment Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AllColor.borderColor,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Add Payment Method",
                    style: TextStyle(fontSize: 16.sp, color: Colors.white)),
              ),
            ),

            SizedBox(height: 10.h),

            // Cancel Button
            Center(
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Cancel",
                    style:
                    TextStyle(fontSize: 14.sp, color: AllColor.black)),
              ),
            )
          ],
        ),
      ),
    );
  }
}