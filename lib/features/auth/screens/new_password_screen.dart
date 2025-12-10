import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/features/auth/screens/account_successful.dart';
import 'package:workpleis/features/auth/screens/login_screen.dart';
import 'package:workpleis/features/auth/logic/password_valitedor.dart'; // <- passwordValidator
import '../../../core/constants/color_control/all_color.dart';
import '../../../core/widget/global_get_started_button.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});
  static const routeName = "/newPasswordScreen";

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
  TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 4.h),

                /// Back button
                InkWell(
                  onTap: () => context.pop(),
                  borderRadius: BorderRadius.circular(14.r),
                  child: Container(
                    height: 40.w,
                    width: 40.w,
                    decoration: BoxDecoration(
                      color: AllColor.grey70,
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.arrow_back,
                        size: 24.sp,
                        color: const Color(0xff111111),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 24.h),

                /// Title
                Text(
                  'Create new password',
                  style: TextStyle(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w500,
                    color: AllColor.black,
                    fontFamily: 'sf_pro',
                  ),
                ),
                SizedBox(height: 8.h),

                /// Subtitle
                Text(
                  "Your new password must be different from previously used passwords.",
                  style: TextStyle(
                    fontSize: 18.sp,
                    height: 1.5,
                    color: AllColor.black,
                    fontFamily: 'sf_pro',
                    fontWeight: FontWeight.w400,
                  ),
                ),

                SizedBox(height: 24.h),

                // ── Password
                Text(
                  "Password",
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: const Color(0xff171717),
                    fontFamily: "sf_pro",
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8.h),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  validator: passwordValidator,
                  style: TextStyle(
                    color: AllColor.black,
                    fontFamily: "sf_pro",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: _inputDecoration(
                    hint: 'Enter your password',
                    onToggle: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                    obscure: _obscurePassword,
                  ),
                ),

                SizedBox(height: 16.h),

                Text(
                  "Password is strong",
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AllColor.bluecolor,
                    fontFamily: "sf_pro",
                    fontWeight: FontWeight.w500,
                  ),
                ),

                SizedBox(height: 24.h),

                // ── Re-Password
                Text(
                  "Re-Password",
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: const Color(0xff171717),
                    fontFamily: "sf_pro",
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8.h),
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: _obscureConfirm,
                  validator: (value) {
                    // age base password rules check
                    final baseError = passwordValidator(value);
                    if (baseError != null) return baseError;

                    // pore match check
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                  style: TextStyle(
                    color: AllColor.black,
                    fontFamily: "sf_pro",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: _inputDecoration(
                    hint: 'Re-enter your password',
                    onToggle: () =>
                        setState(() => _obscureConfirm = !_obscureConfirm),
                    obscure: _obscureConfirm,
                  ),
                ),
                SizedBox(height: 80.h,),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(22.w, 0, 22.w, 24.h),
        child: SizedBox(
          width: double.infinity,
          height: 56.h,
          child: CustomButton(
            text: "Submit",
            onTap: () {
              //if (!(_formKey.currentState?.validate() ?? false)) return;
              context.push(AccountSuccessful.routeName);
            },
          ),
        ),
      ),

    );
  }

  InputDecoration _inputDecoration({
    required String hint,
    required VoidCallback onToggle,
    required bool obscure,
  }) {
    return InputDecoration(
      hintText: hint,
      suffixIcon: IconButton(
        onPressed: onToggle,
        icon: Icon(obscure ? Icons.visibility_off : Icons.visibility),
      ),
      hintStyle: TextStyle(
        color: Colors.black.withOpacity(0.3),
        fontSize: 16.sp,
      ),
      filled: true,
      fillColor: const Color(0xffF7F7F7),
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
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
    );
  }

}
