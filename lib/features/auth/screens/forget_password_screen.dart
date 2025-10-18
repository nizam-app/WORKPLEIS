import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/core/widget/global_bottom.dart';
import 'package:workpleis/features/auth/screens/email_verification.dart';

import 'forget_verification_code_screen.dart';
class ForgetPasswordScreen  extends StatelessWidget {
  const ForgetPasswordScreen ({super.key});
  static final routeName = "/forgetPasswordScreen" ;

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
            Text("Forgot Password",
                style:theme.headlineLarge ),
            SizedBox(height: 8.h),
            Text("Enter your email account to \n reset password",textAlign: TextAlign.center,
                style: theme.titleMedium),
            SizedBox(height: 30.h),

            // 🔹 Full Name
            Padding(
              padding:  EdgeInsets.only(left: 10.w),
              child: Align(
                alignment: Alignment.centerLeft,

                child: Text("Email",
                    style: TextStyle(
                        fontSize: 13.sp, fontWeight: FontWeight.w500, color: AllColor.borderColor)),
              ),
            ),
            SizedBox(height: 6.h),
            TextFormField(
              controller: _emailController,
              validator: (v) =>
              v == null || v.isEmpty || v.contains("com") ? "Enter your Email" : null,
              decoration: const InputDecoration(
                hintText: "type your email",
              ),
            ),
            SizedBox(height: 25.h),
            GlobalButton(text: "Continue", onPressed: () {context.push(ForgetVerificationCodeScreen.routeName);})
            ,
            Spacer(),
          ],
        ),
      )),

    );
  }
}