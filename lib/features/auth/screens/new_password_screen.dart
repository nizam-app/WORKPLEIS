import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/widget/global_aleart_box.dart';
import 'package:workpleis/core/widget/global_bottom.dart';
import 'package:workpleis/features/auth/screens/login_screen.dart';
import 'package:workpleis/features/auth/widgets/custom_label_text.dart';
import '../../../core/constants/color_control/all_color.dart';

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({super.key});
  static const routeName = "/newPasswordScreen";

  @override
  Widget build(BuildContext context) {
    final TextEditingController _passwordController = TextEditingController();
    final TextEditingController _confirmPasswordController =
    TextEditingController();

    final ValueNotifier<bool> _passwordVisible = ValueNotifier(false);
    final ValueNotifier<bool> _confirmPasswordVisible = ValueNotifier(false);

    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 60.h),
                  Text(
                    "Reset your password",
                    style: TextStyle(
                      fontFamily: "headFont",
                      fontWeight: FontWeight.w800,
                      fontSize: 24.sp,
                      color: AllColor.black,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    "The password must be different than before",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontFamily: "OpenText",
                      fontWeight: FontWeight.w400,
                      color: AllColor.levelText,
                    ),
                  ),
                  SizedBox(height: 30.h),

                  // 🔹 New Password Field
                  const CustomLabelText(title: "New Password"),
                  SizedBox(height: 6.h),
                  ValueListenableBuilder<bool>(
                    valueListenable: _passwordVisible,
                    builder: (context, isVisible, _) {
                      return TextFormField(
                        controller: _passwordController,
                        obscureText: !isVisible,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: AllColor.black,
                          fontFamily: "OpenText",
                        ),
                        validator: (v) =>
                        v == null || v.isEmpty ? "Enter your new password" : null,
                        decoration: InputDecoration(
                          hintText: "Enter your password",
                          hintStyle: TextStyle(
                            color: AllColor.levelText,
                            fontFamily: "OpenText",
                            fontSize: 16.sp,
                          ),
                          errorStyle: TextStyle( // ✅ only validation text styled
                            color: Colors.red,
                            fontFamily: "OpenText",
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              isVisible ? Icons.visibility : Icons.visibility_off,
                              color: AllColor.levelText,
                            ),
                            onPressed: () =>
                            _passwordVisible.value = !_passwordVisible.value,
                          ),
                        ),
                      );
                    },
                  ),

                  SizedBox(height: 25.h),

                  // 🔹 Confirm Password Field
                  const CustomLabelText(title: "Confirm Password"),
                  SizedBox(height: 6.h),
                  ValueListenableBuilder<bool>(
                    valueListenable: _confirmPasswordVisible,
                    builder: (context, isVisible, _) {
                      return TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: !isVisible,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: AllColor.black,
                          fontFamily: "OpenText",
                        ),
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return "Enter your confirm password";
                          } else if (v != _passwordController.text) {
                            return "Passwords do not match";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Re-enter your password",
                          hintStyle: TextStyle(
                            color: AllColor.levelText,
                            fontFamily: "OpenText",
                            fontSize: 16.sp,
                          ),
                          errorStyle: TextStyle( // ✅ styled validation text only
                            color: Colors.red,
                            fontFamily: "OpenText",
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              isVisible ? Icons.visibility : Icons.visibility_off,
                              color: AllColor.levelText,
                            ),
                            onPressed: () => _confirmPasswordVisible.value =
                            !_confirmPasswordVisible.value,
                          ),
                        ),
                      );
                    },
                  ),

                  SizedBox(height: 40.h),

                  GlobalButton(
                    text: "Continue",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        globalShowAlertDialog(
                          context: context,
                          oneTap: () {
                            context.push(LoginScreen.routeName);
                          },
                          message:
                          "Your password has been changed successfully",
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:go_router/go_router.dart';
// import 'package:workpleis/core/widget/global_aleart_box.dart';
// import 'package:workpleis/core/widget/global_bottom.dart';
// import 'package:workpleis/features/auth/screens/login_screen.dart';
// import 'package:workpleis/features/auth/widgets/custom_label_text.dart';
// import 'package:workpleis/features/onboarding/screen/onboarding_screen_01.dart';
//
// import '../../../core/constants/color_control/all_color.dart';
// class NewPasswordScreen extends StatelessWidget {
//   const NewPasswordScreen({super.key});
//   static final routeName = "/newPasswordScreen";
//
//   @override
//   Widget build(BuildContext context) {
//     TextEditingController _passwordController = TextEditingController();
//     TextEditingController _confirmPasswordController = TextEditingController();
//     TextTheme theme = Theme.of(context).textTheme;
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Spacer(),
//                 Text(
//                   "Reset your password",
//                   style:TextStyle(fontFamily:"headFont", fontWeight: FontWeight.w800, fontSize: 20.sp,color: AllColor.black),
//                 ),
//                 SizedBox(height: 8.h),
//                 Text(
//                   "The password must be \n different then before",
//                   textAlign: TextAlign.center,
//                   style:TextStyle(fontSize: 14.sp,  fontFamily:"OpenText", fontWeight: FontWeight.w400, color: AllColor.levelText),
//                 ),
//                 SizedBox(height: 30.h),
//                 // 🔹 Full Name
//                 CustomLabelText(title: "New Password"),
//                 SizedBox(height: 6.h),
//                 TextFormField(
//                   style: TextStyle(
//                       fontSize: 14.sp,
//                       fontWeight: FontWeight.w400,
//                       color: AllColor.black,
//                       fontFamily: "OpenText"
//                   ),
//
//                   controller: _passwordController,
//                   validator: (v) =>
//                   v == null || v.isEmpty ? "Enter your New Password" : null,
//                   decoration: const InputDecoration(
//                     hintText: "Enter Your Password",
//                   ),
//                 ),
//                 SizedBox(height: 25.h),
//                 CustomLabelText(title: "Confirm Password"),
//                 TextFormField(
//                   style: TextStyle(
//                       fontSize: 14.sp,
//                       fontWeight: FontWeight.w400,
//                       color: AllColor.black,
//                       fontFamily: "OpenText"
//                   ),
//
//                   controller: _confirmPasswordController,
//                   validator: (v) =>
//                   v == null || v.isEmpty ? "Enter your Confirm Password" : null,
//                   decoration: const InputDecoration(
//                     hintText: "Enter Your Confirm Password",
//                   ),
//                 ),
//                 SizedBox(height: 25.h),
//                 GlobalButton(
//                   text: "Continue ",
//                   onPressed: () {
//                    globalShowAlertDialog(context: context, oneTap: (){context.push(LoginScreen.routeName);
//                      },message: "Your password has been changed successfully");
//                   },
//                 ),
//                 Spacer(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }