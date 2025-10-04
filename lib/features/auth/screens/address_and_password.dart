import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/core/widget/global_aleart_box.dart';
import 'package:workpleis/core/widget/global_bottom.dart';
import 'package:workpleis/features/auth/screens/email_verification.dart';

class AddressAndPassword extends StatelessWidget {
  const AddressAndPassword({super.key});

  static final routeName = "/addressAndPassword";

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    TextEditingController _addressController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    TextEditingController _confirmPasswordController = TextEditingController();
    return Scaffold(
      body: SafeArea(child:  Padding(
        padding:  EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
        child: Column(
          children: [
            Spacer(),
            Text("Set Up Address & Password",
                style:theme.headlineLarge ),
            SizedBox(height: 8.h),
            Text("Complete these steps to finish setting up \n your account.",textAlign: TextAlign.center,
                style: theme.titleMedium),
            SizedBox(height: 30.h),

            // 🔹 Full Name
          CustomlabelText(title: "Address",),
            SizedBox(height: 6.h),
            TextFormField(
              controller: _addressController,
              validator: (v) =>
              v == null || v.isEmpty? "Enter your Address" : null,
              decoration: const InputDecoration(
                hintText: "Enter Your Address",
              ),
            ),
            SizedBox(height: 25.h),
            CustomlabelText(title: "Password",),
            TextFormField(
              controller: _passwordController,
              validator: (v) =>
              v == null || v.isEmpty ? "Enter your Password" : null,
              decoration: const InputDecoration(
                hintText: "Enter Your Password",
              ),
            ),
            SizedBox(height: 25.h),
            CustomlabelText(title: "Confirm Password",),
            TextFormField(
              controller: _confirmPasswordController,
              validator: (v) =>
              v == null || v.isEmpty ? "Enter your Confirm Password" : null,
              decoration: const InputDecoration(
                hintText: "Confirm Your Password",
              ),
            ),
            SizedBox(height: 25.h),
            GlobalButton(text: "Submit", onPressed: () {
              showCustomAlertDialog(context);
            })
            ,
            Spacer(),
          ],
        ),
      )),
    );
  }
}

class CustomlabelText extends StatelessWidget {
  const CustomlabelText({
    super.key, required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(left: 10.w,bottom: 5.h),
      child: Align(
        alignment: Alignment.centerLeft,
    
        child: Text(title,
            style: TextStyle(
                fontSize: 13.sp, fontWeight: FontWeight.w600, color: AllColor.borderColor)),
      ),
    );
  }
}
