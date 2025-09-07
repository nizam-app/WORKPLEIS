import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/features/auth/logic/email_valitedor.dart';
import 'package:workpleis/features/auth/logic/password_valitedor.dart';
import 'package:workpleis/features/auth/logic/textfromfield_revarpod.dart';

import '../../../core/constants/image_control/image_path.dart';
import '../data/register_users.dart';
import '../logic/role_reverpod.dart';
import 'login_screen.dart';

class RegisterScreen extends ConsumerWidget {
  RegisterScreen({super.key});
  static const routeName = '/registerScreen';

  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _confirmPassController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final obscurePass = ref.watch(passwordVisibleProvider);
    final obscureConfirm = ref.watch(confirmPasswordVisibleProvider);
    final role = ref.watch(roleProvider); // 🔹 role state riverpod থেকে নিলাম

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20.h),
                Image.asset(ImagePath.logoText, height: 40.h),
                SizedBox(height: 16.h),

                Text("Create account",
                    style: TextStyle(
                        fontSize: 24.sp, fontWeight: FontWeight.bold)),
                SizedBox(height: 4.h),
                Text("Join Workpleis today",
                    style: TextStyle(fontSize: 16.sp, color: Colors.grey)),
                SizedBox(height: 30.h),

                // 🔹 Full Name
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Full Name",
                      style: TextStyle(
                          fontSize: 13.sp, fontWeight: FontWeight.w600)),
                ),
                SizedBox(height: 6.h),
                TextFormField(
                  controller: _nameController,
                  validator: (v) =>
                  v == null || v.isEmpty ? "Enter your full name" : null,
                  decoration: const InputDecoration(
                    hintText: "Your full name",
                  ),
                ),
                SizedBox(height: 16.h),

                // 🔹 Email
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Email",
                      style: TextStyle(
                          fontSize: 13.sp, fontWeight: FontWeight.w600)),
                ),
                SizedBox(height: 6.h),
                TextFormField(
                  controller: _emailController,
                  validator: emailValidator,
                  decoration: const InputDecoration(
                    hintText: "Your email",
                  ),
                ),
                SizedBox(height: 16.h),

                // 🔹 Password
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Password",
                      style: TextStyle(
                          fontSize: 13.sp, fontWeight: FontWeight.w600)),
                ),
                SizedBox(height: 6.h),
                TextFormField(
                  controller: _passController,
                  validator: passwordValidator,
                  obscureText: obscurePass,
                  decoration: InputDecoration(
                    hintText: "Enter your password",
                    suffixIcon: IconButton(
                      onPressed: () => ref
                          .read(passwordVisibleProvider.notifier)
                          .state = !obscurePass,
                      icon: Icon(obscurePass
                          ? Icons.visibility_off
                          : Icons.visibility),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),

                // 🔹 Confirm Password
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Confirm password",
                      style: TextStyle(
                          fontSize: 13.sp, fontWeight: FontWeight.w600)),
                ),
                SizedBox(height: 6.h),
                TextFormField(
                  controller: _confirmPassController,
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return "Confirm your password";
                    }
                    if (v != _passController.text) {
                      return "Passwords do not match";
                    }
                    return null;
                  },
                  obscureText: obscureConfirm,
                  decoration: InputDecoration(
                    hintText: "Confirm your password",
                    suffixIcon: IconButton(
                      onPressed: () => ref
                          .read(confirmPasswordVisibleProvider.notifier)
                          .state = !obscureConfirm,
                      icon: Icon(obscureConfirm
                          ? Icons.visibility_off
                          : Icons.visibility),
                    ),
                  ),
                ),
                SizedBox(height: 24.h),

                // 🔹 Client / Job Seeker Selectable Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          ref.read(roleProvider.notifier).state = "CLIENT";
                        },
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          side: BorderSide(
                            color: role == "CLIENT"
                                ? AllColor.logoColor
                                : Colors.grey,
                            width: 1,
                          ),
                          backgroundColor: role == "CLIENT"
                              ? AllColor.logoColor.withOpacity(0.5)
                              : Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        child: Text(
                          "I'm a Client",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color:
                                 AllColor.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          ref.read(roleProvider.notifier).state = "JOB_SEEKER";
                        },
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          side: BorderSide(
                            color: role == "JOB_SEEKER"
                                ? AllColor.logoColor
                                : Colors.grey,
                            width: 1,
                          ),
                          backgroundColor: role == "JOB_SEEKER"
                              ? AllColor.logoColor.withOpacity(0.5)
                              : Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        child: Text(
                          "I'm a Job Seeker",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color
                                : AllColor.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),

                // 🔹 Create Account Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (role == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Please select a role"),
                            ),
                          );
                          return;
                        }
                        registerUsers(
                          context: context,
                          name: _nameController.text.trim(),
                          email: _emailController.text.trim(),
                          password: _passController.text.trim(),
                          confirmPassword: _confirmPassController.text.trim(),
                          role: role, // 🔹 Riverpod থেকে role পাঠানো হলো
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    child: const Text(
                      "Create Account",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}