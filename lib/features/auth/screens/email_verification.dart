import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/core/widget/global_bottom.dart';

import 'enter_your_phone_number.dart';

class EmailVerification extends StatelessWidget {
  const EmailVerification({super.key});

  static final routeName = "/emailVerification";

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextTheme theme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            children: [
              Spacer(),
              Text(
                "Verify Your Email",
                style:TextStyle(fontFamily:"headFont", fontWeight: FontWeight.w800, fontSize: 24.sp,color: AllColor.black),
              ),
              SizedBox(height: 8.h),
              Text(
                "Enter the 6-digit code we sent to your email \n to confirm your account.",
                textAlign: TextAlign.center,
                style:TextStyle(fontSize: 16.sp,  fontFamily:"OpenText", fontWeight: FontWeight.w400, color: AllColor.levelText),
              ),
              SizedBox(height: 30.h),

              // 🔹 Full Name
              Padding(
                padding: EdgeInsets.only(left: 2.w),
                child: Align(
                  alignment: Alignment.centerLeft,

                  child: Text(
                    "Verification Code",
                    style: TextStyle(
                        fontSize: 18.sp, fontWeight: FontWeight.w800, color: AllColor.borderColor, fontFamily:"OpenText")
                  ),
                ),
              ),
              SizedBox(height: 6.h),
              TextFormField(
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: AllColor.black,
                  fontFamily: "OpenText",
                ),
                controller: _emailController,
                validator: (v) =>
                    v == null || v.isEmpty ? "Enter your OTP" : null,
                decoration: const InputDecoration(
                  hintText: "Enter Your Verification Code",
                ),
              ),
              SizedBox(height: 25.h),
              GlobalButton(
                text: "Verify Email",
                onPressed: () {
                  context.push(EnterYourPhoneNumber.routeName);
                },
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}