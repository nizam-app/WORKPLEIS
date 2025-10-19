import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/core/widget/global_bottom.dart';
import 'package:workpleis/features/auth/logic/signup_screen_check.dart';
import 'package:workpleis/features/auth/screens/enter_your_phone_number.dart';
import 'package:workpleis/features/auth/screens/indentity_verification_screen.dart';
import 'package:workpleis/features/onboarding/logic/check_individual.dart';

import 'business_verification_screen.dart';

class PhoneNumberVerification extends StatelessWidget {
  const PhoneNumberVerification({super.key});

  static final routeName = "/phoneNumberVerification";

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
              Text("Verify Your Phone Number", style: theme.headlineLarge),
              SizedBox(height: 8.h),
              Text(
                "Enter the 6-digit code we just sent to \n your mobile number.",
                textAlign: TextAlign.center,
                style: theme.titleMedium,
              ),
              SizedBox(height: 30.h),

              // 🔹 Full Name
              Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: Align(
                  alignment: Alignment.centerLeft,

                  child: Text(
                    "Verification Code",
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 6.h),
              TextFormField(
                controller: _emailController,
                validator: (v) =>
                    v == null || v.isEmpty ? "Enter your OTP" : null,
                decoration: const InputDecoration(
                  hintText: "Enter Your Verification Code",
                ),
              ),
              SizedBox(height: 25.h),
              Consumer(
                builder: (context, ref, child) {
                  final isActive = ref.watch(boolControllerProvider);
                  return GlobalButton(
                    text: "Verify Phone",
                      onPressed: () {
                        final role = ref.read(checkBusinessP);              // 'business' | 'individual'
                        final isActive = role == 'business';
                        if (isActive) {
                          context.push(BusinessVerificationScreen.routeName);
                        } else {
                          context.push(IndentityVerificationScreen.routeName);
                        }
                      }
                  );
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