import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/core/widget/global_get_started_button.dart';
import 'package:workpleis/core/widget/global_snack_bar.dart';
import 'package:workpleis/features/auth/screens/add_payment_method_screen.dart';
import 'package:workpleis/features/auth/logic/email_valitedor.dart';
import 'package:workpleis/core/constants/image_control/image_path.dart';
import 'package:workpleis/features/auth/logic/password_valitedor.dart';
import 'package:workpleis/features/auth/screens/enter_your_email.dart';
import 'package:workpleis/features/auth/screens/forget_password_screen.dart';
import 'package:workpleis/features/auth/screens/register_screen.dart';
import 'package:workpleis/features/auth/widgets/custom_label_text.dart';
import 'package:workpleis/features/home/screen/home_screen.dart';
import 'package:workpleis/features/onboarding/screen/onboarding_screen_001.dart';

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
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 16.h),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 130.h),
                upper_text(),

                // ── Email
                CustomLabelText(title: "Email"),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: emailValidator,
                  decoration: const InputDecoration(hintText: 'Enter your Email')),
                SizedBox(height: 16.h),
                CustomLabelText(title: "Password"),
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
                  )),
              SizedBox(height: 5.h),

              // ── Divider with text
              Row(
                children: [
                  Spacer(),
                  GestureDetector(
                    onTap: () {context.push(ForgetPasswordScreen.routeName);},
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                    
                      child: Text(
                        'Forgot password?',
                        style: TextStyle(fontSize: 12.sp, color: AllColor.borderColor),
                      ),
                    ),
                  ),]
                ),
                SizedBox(height: 30.h),

                // ── Sign In button
            GlobalGetStartedButton(onTap: (){context.push(AddPaymentMethodScreen.routeName);},color: AllColor.primary,buttonName: "Sign In",),
            CustomGmailButton(onTop: () { context.push(OnboardingScreen03.routeName);}, taxt: 'Sign up',),



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
        Text(
          "     Sign in to your \n Workpleis account",
          style: TextStyle(fontSize: 20.sp, color:Color(0xff45454C)),
        ),
        SizedBox(height: 28.h),
      ],
    );
  }



  // lib/features/auth/login_screen.dart

  Future<void> _submit() async {
    context.push(AddPaymentMethodScreen.routeName);
    // if (!(_formKey.currentState?.validate() ?? false)) return;
    //
    // ref.read(loginLoadingProvider.notifier).state = true;
    //
    // final loginService = ref.read(loginProvider);
    // final result = await loginService.login(
    //   _emailController.text.trim(),
    //   _passController.text.trim(),
    // );
    //
    // ref.read(loginLoadingProvider.notifier).state = false;
    //
    // if (result["success"]) {
    //   GlobalSnackBar.show(context,
    //       title: "Success", message: result["message"], type: CustomSnackType.success);
    //
    //   context.go(HomeScreen.routeName); // ✅ Next page এ যাবে
    // } else {
    //   GlobalSnackBar.show(context,
    //       title: "Error", message: result["message"], type: CustomSnackType.error);
    // }
  }



}