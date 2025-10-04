import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/core/widget/global_snack_bar.dart';
import 'package:workpleis/features/auth/logic/email_valitedor.dart';
import 'package:workpleis/core/constants/image_control/image_path.dart';
import 'package:workpleis/features/auth/logic/password_valitedor.dart';
import 'package:workpleis/features/auth/screens/enter_your_email.dart';
import 'package:workpleis/features/auth/screens/register_screen.dart';
import 'package:workpleis/features/home/screen/home_screen.dart';

import '../../nav_bar/screen/bottom_nav_bar.dart';
import '../logic/login_reverpod.dart';
import '../widgets/custom_google_button.dart';
import '../widgets/outline_border.dart';
import '../../../core/screen/base_gradient_scaffold.dart';


class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});
  static const routeName = '/loginScreen';

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseGradientScaffold(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 16.h),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  upper_text(),
        
                  // ── Email
                  _fieldLabel('Email'),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: emailValidator,
                    decoration: const InputDecoration(hintText: 'Enter your Email').copyWith(
                      enabledBorder: CustomOutlineBorder.border(),
                      focusedBorder: CustomOutlineBorder.border(),
                  )),
                  SizedBox(height: 16.h),
        
                  // ── Password
                  _fieldLabel('Password'),
                  TextFormField(
                    controller: _passController,
                    obscureText: _obscure,
                    validator: passwordValidator,
                    decoration: InputDecoration(
                      hintText: 'Enter your Password',
                      suffixIcon: IconButton(
                        onPressed: () => setState(() => _obscure = !_obscure),
                        icon: Icon(
                          _obscure ? Icons.visibility_off : Icons.visibility,
                        ),
                      ),
                    ).copyWith(
                      enabledBorder: CustomOutlineBorder.border(),
                      focusedBorder: CustomOutlineBorder.border(),
                  )),
        
                  // ── Forgot password
                  SizedBox(height: 8.h),



                // ── Forgot password
                SizedBox(height: 18.h),

                // ── Divider with text
                Row(
                  children: [
                    Expanded(child: Container(height: 1, color: AllColor.grey.withOpacity(.2))),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),

                      child: Text(
                        'Forgot password?',
                        style: TextStyle(fontSize: 12.sp, color: AllColor.grey),
                      ),
                    ),]
                  ),
                  SizedBox(height: 6.h),

                  // ── Sign In button
                SizedBox(
                  width: double.infinity,
                  height: 46.h,
                  child: ElevatedButton(
                    onPressed: ref.watch(loginLoadingProvider) ? null : _submit, // disable হলে null
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AllColor.black,
                      foregroundColor: AllColor.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      elevation: 0,
                    ),
                    child: ref.watch(loginLoadingProvider)
                        ? SizedBox(
                      width: 20.w,
                      height: 20.h,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                        : Text('Sign In', style: TextStyle(fontSize: 14.sp)),
                  ),
                ),

                  // ── Google button
                  CustomGmailButton(onTop: () { context.push(RegisterScreen.routeName);}, taxt: 'Sign up',),


        
                  // ── Sign up link
        
                ],
              ),
            ),
          ),
        ),
      )
    ;
  }

  Column upper_text() {
    return Column(
      children: [
        SizedBox(height: 20.h),
        Image.asset(ImagePath.pngLogo, height: 110.h),
        SizedBox(height: 18.h),
        Text(
          'Welcome back',
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
            color: AllColor.black,
            letterSpacing: -0.2,
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          'Sign in to your account',
          style: TextStyle(fontSize: 16.sp, color: AllColor.grey.withOpacity(0.9)),
        ),
        SizedBox(height: 28.h),
      ],
    );
  }

  Widget _fieldLabel(String text) => Align(
    alignment: Alignment.centerLeft,
    child: Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: AllColor.black,
        ),
      ),
    ),
  );

  // lib/features/auth/login_screen.dart

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    ref.read(loginLoadingProvider.notifier).state = true;

    final loginService = ref.read(loginProvider);
    final result = await loginService.login(
      _emailController.text.trim(),
      _passController.text.trim(),
    );

    ref.read(loginLoadingProvider.notifier).state = false;

    if (result["success"]) {
      GlobalSnackBar.show(context,
          title: "Success", message: result["message"], type: CustomSnackType.success);

      context.go(HomeScreen.routeName); // ✅ Next page এ যাবে
    } else {
      GlobalSnackBar.show(context,
          title: "Error", message: result["message"], type: CustomSnackType.error);
    }
  }



}
