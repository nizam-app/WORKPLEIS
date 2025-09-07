import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/core/widget/global_bottom.dart';
import 'package:workpleis/features/auth/screens/new_password_screen.dart';

import '../../../core/constants/image_control/image_path.dart';
class OtpScreen  extends StatelessWidget {
  const OtpScreen ({super.key});
  static final routeName = "/otpScreen" ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
      SafeArea(child:
      Padding(
        padding:  EdgeInsets.all(20.r),
        child: Column(
          children: [
            SizedBox(height: 20.h),
            Image.asset(ImagePath.logoText, height: 40.h),
            SizedBox(height: 16.h),

            Text("Conform OTP",
                style: TextStyle(
                    fontSize: 24.sp, fontWeight: FontWeight.bold)),
            SizedBox(height: 4.h),
            Text("Please Enter your OTP",
                style: TextStyle(fontSize: 16.sp, color: Colors.grey)),
            SizedBox(height: 30.h),
            OtpTextField(
              numberOfFields: 5,
              borderColor: Color(0xFF512DA8),
              //set to true to show as box or false to show as dash
              showFieldAsBox: true,
              //runs when a code is typed in
              onCodeChanged: (String code) {
                //handle validation or checks here
              },
              //runs when every textfield is filled
              onSubmit: (String verificationCode){
                showDialog(
                    context: context,
                    builder: (context){
                      return AlertDialog(
                        title: Text("Verification Code"),
                        content: Text('Code entered is $verificationCode'),
                      );
                    }
                );
              }, // end onSubmit
            ) ,
            SizedBox(height: 20.h,) ,
            GlobalButton(text: "Send OTP", onPressed: (){context.push(NewPasswordScreen.routeName);})
          ],
        ),
      )
      )
      ,);
  }}