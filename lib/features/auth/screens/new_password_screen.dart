import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/core/widget/global_bottom.dart';
import '../../../core/constants/image_control/image_path.dart';
import 'email_verification.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});
  static final routeName = "/newPasswordScreen";

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.r),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 20.h),
                Image.asset(ImagePath.logoText, height: 40.h),
                SizedBox(height: 16.h),

                Text(
                  "New Password",
                  style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4.h),
                Text(
                  "Please Enter your New Password",
                  style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                ),
                SizedBox(height: 30.h),

                // Password
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Password",
                      style: TextStyle(
                          fontSize: 13.sp, fontWeight: FontWeight.w600)),
                ),
                SizedBox(height: 6.h),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return "Enter your password";
                    } else if (v.length < 6) {
                      return "Password must be at least 6 characters";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: "Enter Password",
                  ),
                ),
                SizedBox(height: 10.h),

                // Confirm Password
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Confirm Password",
                      style: TextStyle(
                          fontSize: 13.sp, fontWeight: FontWeight.w600)),
                ),
                SizedBox(height: 6.h),
                TextFormField(
                  controller: _confirmController,
                  obscureText: true,
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return "Confirm your password";
                    } else if (v != _passwordController.text) {
                      return "Passwords do not match";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: "Re-enter Password",
                  ),
                ),

                SizedBox(height: 25.h),

                GlobalButton(
                  text: "Send OTP",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.push(EmailVerification.routeName);
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
