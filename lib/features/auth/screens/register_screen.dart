import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/features/auth/logic/email_valitedor.dart';
import 'package:workpleis/features/auth/logic/password_valitedor.dart';
import 'package:workpleis/features/auth/screens/phone_number_verification.dart';
import '../../../core/widget/global_get_started_button.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const routeName = '/registerScreen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  bool _obscurePass = true;
  bool _agreeTerms = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // ✅ pure white background
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Logo
                SizedBox(height: 8.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Image.asset(
                    "assets/images/goloballogo.png",
                    height: 31.h,
                  ),
                ),

                SizedBox(height: 32.h),

                // ── Title
                Text(
                  'Create account',
                  style: TextStyle(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w500,
                    color: AllColor.black,
                    fontFamily: 'sf_pro',
                  ),
                ),
                SizedBox(height: 8.h),

                // ── Already have account? Log In
                Row(
                  children: [
                    Text(
                      "Already have an account? ",
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AllColor.black,
                        fontFamily: "sf_pro",
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => context.push(LoginScreen.routeName),
                      child: Text(
                        "Log In",
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: AllColor.black,
                          fontFamily: "sf_pro",
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                          decorationColor: AllColor.black,
                          decorationThickness: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 28.h),

                // First name
                Text(
                  "First name",
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: const Color(0xff171717),
                    fontFamily: "sf_pro",
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8.h),
                TextFormField(
                  controller: _firstNameController,
                  style: _fieldTextStyle,
                  validator: (v) =>
                  v == null || v.isEmpty ? "Enter your first name" : null,
                  decoration: _inputDecoration(hint: 'Enter your first name'),
                ),

                SizedBox(height: 16.h),

                // Last name
                Text(
                  "Last name",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: const Color(0xff171717),
                    fontFamily: "sf_pro",
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8.h),
                TextFormField(
                  controller: _lastNameController,
                  style: _fieldTextStyle,
                  validator: (v) =>
                  v == null || v.isEmpty ? "Enter your last name" : null,
                  decoration: _inputDecoration(hint: 'Enter your last name'),
                ),

                SizedBox(height: 16.h),

                // Email
                Text(
                  "Email*",
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: const Color(0xff171717),
                    fontFamily: "sf_pro",
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8.h),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: _fieldTextStyle,
                  validator: emailValidator,
                  decoration: _inputDecoration(hint: 'Enter email'),
                ),

                SizedBox(height: 16.h),

                // Password
                Text(
                  "Create a password*",
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: const Color(0xff171717),
                    fontFamily: "sf_pro",
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8.h),
                TextFormField(
                  controller: _passController,
                  obscureText: _obscurePass,
                  style: _fieldTextStyle,
                  validator: passwordValidator,
                  decoration: _inputDecoration(
                    hint: 'Enter your password',
                    suffix: IconButton(
                      onPressed: () =>
                          setState(() => _obscurePass = !_obscurePass),
                      icon: Icon(
                        _obscurePass
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 24.h),

                // Terms checkbox
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: SizedBox(
                        height: 18.h,
                        width: 18.w,
                        child: Checkbox(
                          value: _agreeTerms,
                          onChanged: (val) {
                            setState(() => _agreeTerms = val ?? false);
                          },
                          activeColor: Colors.black.withOpacity(0.6),
                          checkColor: AllColor.white,
                          side:  BorderSide(
                            color: Colors.black.withOpacity(0.6),
                            width: 1.5,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                          text:
                          "By creating an account, I agree to Salesman ",
                          style: TextStyle(
                            fontSize: 16.sp,
                            height: 1.4,
                            color: const Color(0xff888888),
                            fontFamily: 'sf_pro',
                            fontWeight: FontWeight.w400,
                          ),
                          children: [
                            TextSpan(
                              text: "Terms of Service",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.underline,
                                fontSize: 16.sp,
                                  color: AllColor.black
                              ),
                            ),
                             TextSpan(text: " and ",
                               style:TextStyle(
                                   fontSize: 16.sp,
                                   height: 1.4,
                                   color: const Color(0xff888888),
                                   fontFamily: 'sf_pro',
                                   fontWeight: FontWeight.w400,
                             ),)  ,
                            TextSpan(
                              text: "Privacy Policy",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.underline,
                                fontSize: 16.sp,
                                color: AllColor.black
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 40.h),

                SizedBox(
                  width: double.infinity,
                  height: 56.h,
                  child: CustomButton(
                    text: "Create Account",
                    onTap: _onSubmit,
                  ),
                ),

                SizedBox(height: 16.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextStyle get _fieldTextStyle => TextStyle(
    color: AllColor.black,
    fontFamily: "sf_pro",
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
  );

  InputDecoration _inputDecoration({required String hint, Widget? suffix}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(
        color: Colors.black.withOpacity(0.3),
        fontSize: 16.sp,
        fontFamily: 'sf_pro',
      ),
      filled: true,
      fillColor: const Color(0xffF7F7F7),
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      suffixIcon: suffix,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: AllColor.grey50,
          width: 1.2,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: AllColor.grey50,
          width: 1.2,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: AllColor.grey50,
          width: 1.2,
        ),
      ),
    );
  }

  void _onSubmit() {
   // if (!(_formKey.currentState?.validate() ?? false)) return;

    // if (!_agreeTerms) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(
    //       content:
    //       Text("Please agree to Terms of Service and Privacy Policy."),
    //     ),
    //   );
    //   return;
    // }

    // TODO: ekhane register API call korbe
    context.push(PhoneNumberVerification.routeName);
  }
}
