import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/core/widget/global_aleart_box.dart';
import 'package:workpleis/core/widget/global_bottom.dart';
import 'package:workpleis/features/auth/screens/email_verification.dart';
import 'package:workpleis/features/auth/screens/login_screen.dart';
import 'package:workpleis/features/auth/widgets/custom_label_text.dart';
import 'package:workpleis/features/onboarding/screen/onboarding_screen_01.dart';

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
                style:TextStyle(fontFamily:"headFont", fontWeight: FontWeight.w800, fontSize: 20.sp,color: AllColor.black) ),
            SizedBox(height: 8.h),
            Text("Complete these steps to finish setting up \n your account.",textAlign: TextAlign.center,
                style:TextStyle(fontSize: 14.sp,  fontFamily:"OpenText", fontWeight: FontWeight.w400, color: AllColor.levelText)),
            SizedBox(height: 30.h),

            // 🔹 Full Name
          CustomLabelText(title: "Address",),
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
            CustomLabelText(title: "Password",),
            TextFormField(
              controller: _passwordController,
              validator: (v) =>
              v == null || v.isEmpty ? "Enter your Password" : null,
              decoration: const InputDecoration(
                hintText: "Enter Your Password",
              ),
            ),
            SizedBox(height: 25.h),
            CustomLabelText(title: "Confirm Password",),
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
              globalShowAlertDialog(context: context, oneTap: () {context.push(LoginScreen.routeName);});
            })
            ,
            Spacer(),
          ],
        ),
      )),
    );
  }
}