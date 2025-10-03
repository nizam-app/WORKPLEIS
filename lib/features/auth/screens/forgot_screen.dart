import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/widget/global_bottom.dart';
import 'package:workpleis/features/auth/screens/otp_screen.dart';

import '../../../core/constants/image_control/image_path.dart';
class ForgotScreen  extends StatelessWidget {
  const ForgotScreen ({super.key});
  static final routeName = "/forgotScreen" ;

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    return Scaffold(
      body: SafeArea(child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
        child: Column(
          children: [
            Spacer(),
            Text("Enter Your Email",
                style: TextStyle(
                    fontSize: 24.sp, fontWeight: FontWeight.bold)),
            SizedBox(height: 4.h),
            Text("We’ll send you a one time code to \n "
                "verify your email.",
                style: TextStyle(fontSize: 16.sp, color: Colors.grey)),
            SizedBox(height: 30.h),

            // 🔹 Full Name
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Email",
                  style: TextStyle(
                      fontSize: 13.sp, fontWeight: FontWeight.w600)),
            ),
            SizedBox(height: 6.h),
            TextFormField(
              controller: _emailController,
              validator: (v) =>
              v == null || v.isEmpty || v.contains("com") ? "Enter your Email" : null,
              decoration: const InputDecoration(
                hintText: "Your Email",
              ),
            ),
            SizedBox(height: 25.h),
            GlobalButton(text: "Send OTP", onPressed: () {context.push(OtpScreen.routeName);})
            ,
            Spacer(),
          ],
        ),
      )),
      
    );
  }
}
