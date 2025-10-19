
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/core/widget/global_bottom.dart';
import 'package:workpleis/features/auth/screens/phone_number_verification.dart';
import 'package:workpleis/features/onboarding/logic/check_individual.dart';

import 'email_verification.dart';
class EnterYourPhoneNumber  extends ConsumerWidget {
  const EnterYourPhoneNumber ({super.key});
  static final routeName = "/enterYourPhoneNumber" ;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController _emailController = TextEditingController();
    TextTheme theme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
        child: Column(
          children: [
            Spacer(),
            Text("Enter Your Phone Number",
                style: theme.headlineLarge),
            SizedBox(height: 8.h),
            Text("We’ll send you a one time code \n to verify your number.",textAlign: TextAlign.center,
                style:theme.titleMedium),
            SizedBox(height: 30.h),

            // 🔹 Full Name
            Padding(
              padding:  EdgeInsets.only(left: 10.w),
              child: Align(
                alignment: Alignment.centerLeft,

                child: Text("Mobile Number",
                    style: TextStyle(
                        fontSize: 13.sp, fontWeight: FontWeight.w600, color: AllColor.borderColor)),
              ),
            ),
            SizedBox(height: 6.h),
            TextFormField(
              controller: _emailController,
              validator: (v) =>
              v == null || v.isEmpty ? "Enter your phone number" : null,
              decoration: const InputDecoration(
                hintText: "Enter Your Mobile Number",
              ),
            ),
            SizedBox(height: 25.h),
            GlobalButton(text: "Send", onPressed: () {
              context.push(PhoneNumberVerification.routeName);
              // ref.invalidate(checkBusinessP) ;
              
            })
            ,
            Spacer(),
          ],
        ),
      )),

    );
  }}