import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/core/widget/global_bottom.dart';
import 'package:workpleis/features/auth/screens/email_verification.dart';

import 'new_password_screen.dart';
class ForgetVerificationCodeScreen  extends StatelessWidget {
  const ForgetVerificationCodeScreen ({super.key});
  static final routeName = "/forgetVerificationCodeScreen" ;

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextTheme theme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
        child: Column(
          children: [
            Spacer(),
            Text("Enter verification Code",
                style:theme.headlineLarge ),
            SizedBox(height: 8.h),
            Text("We have sent a code to",textAlign: TextAlign.center,
                style: theme.titleMedium),
            Text("We have sent a code to",textAlign: TextAlign.center,
                style: theme.titleMedium!.copyWith(fontWeight: FontWeight.w700, fontSize:14.sp )),
            SizedBox(height: 30.h),

            // 🔹 Full Name
            Padding(
              padding:  EdgeInsets.only(left: 10.w),
              child: Align(
                alignment: Alignment.centerLeft,

                child: Text("OTP",
                    style: TextStyle(
                        fontSize: 13.sp, fontWeight: FontWeight.w600, color: AllColor.borderColor)),
              ),
            ),
            SizedBox(height: 6.h),
            TextFormField(
              controller: _emailController,
              validator: (v) =>
              v == null || v.isEmpty || v.contains("com") ? "Enter your OTP" : null,
              decoration: const InputDecoration(
                hintText: "Enter your OTP",
              ),
            ),
            SizedBox(height: 25.h),
            GlobalButton(text: "Verify Now", onPressed: () {context.push(NewPasswordScreen.routeName);})
            ,
            Spacer(),
          ],
        ),
      )),

    );
  }
}