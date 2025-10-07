import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/widget/global_aleart_box.dart';
import 'package:workpleis/core/widget/global_bottom.dart';
import 'package:workpleis/features/auth/screens/login_screen.dart';
import 'package:workpleis/features/auth/widgets/custom_label_text.dart';
import 'package:workpleis/features/onboarding/screen/onboarding_screen_01.dart';
class BusinessPasswordScreen extends StatelessWidget {
  const BusinessPasswordScreen({super.key});
  static final routeName = "/businessPasswordScreen";

  @override
  Widget build(BuildContext context) {
    TextEditingController _passwordController = TextEditingController();
    TextEditingController _confirmPasswordController = TextEditingController();
    TextTheme theme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            children: [
              Spacer(),
              Text(
                "Set Up Password",
                style:theme.headlineLarge,
              ),
              SizedBox(height: 8.h),
              Text(
                "Complete these steps to finish setting up \n your account.",
                textAlign: TextAlign.center,
                style:theme.titleMedium,
              ),
              SizedBox(height: 30.h),

              // 🔹 Full Name
             CustomLabelText(title: "Password"),
              SizedBox(height: 6.h),
              TextFormField(
                controller: _passwordController,
                validator: (v) =>
                v == null || v.isEmpty ? "Enter your Password" : null,
                decoration: const InputDecoration(
                  hintText: "Enter Your Password",
                ),
              ),
              SizedBox(height: 25.h),
              CustomLabelText(title: "Confirm Password"),
              TextFormField(
                controller: _confirmPasswordController,
                validator: (v) =>
                v == null || v.isEmpty ? "Enter your Confirm Password" : null,
                decoration: const InputDecoration(
                  hintText: "Enter Your Confirm Password",
                ),
              ),
              SizedBox(height: 25.h),
              GlobalButton(
                text: "Submit ",
                onPressed: () {
               globalShowAlertDialog(context: context, oneTap: () {context.push(LoginScreen.routeName);});
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
