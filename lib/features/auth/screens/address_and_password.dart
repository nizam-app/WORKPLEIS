import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/core/widget/global_aleart_box.dart';
import 'package:workpleis/core/widget/global_bottom.dart';
import 'package:workpleis/features/auth/screens/login_screen.dart';
import 'package:workpleis/features/auth/widgets/custom_label_text.dart';

class AddressAndPassword extends StatefulWidget {
  const AddressAndPassword({super.key});

  static final routeName = "/addressAndPassword";

  @override
  State<AddressAndPassword> createState() => _AddressAndPasswordState();
}

class _AddressAndPasswordState extends State<AddressAndPassword> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
  TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  String? _addressError;
  String? _passwordError;
  String? _confirmPasswordError;

  void _validateForm() {
    setState(() {
      _addressError = _addressController.text.isEmpty
          ? "Enter your Address"
          : _addressController.text.length < 3
          ? "Address too short"
          : null;

      _passwordError = _passwordController.text.isEmpty
          ? "Enter your Password"
          : _passwordController.text.length < 6
          ? "Password must be at least 6 characters"
          : null;

      if (_confirmPasswordController.text.isEmpty) {
        _confirmPasswordError = "Enter your Confirm Password";
      } else if (_confirmPasswordController.text !=
          _passwordController.text) {
        _confirmPasswordError = "Password not Same ";
      } else {
        _confirmPasswordError = null;
      }
    });

    if (_addressError == null &&
        _passwordError == null &&
        _confirmPasswordError == null) {
      globalShowAlertDialog(
        context: context,
        oneTap: () {
          context.push(LoginScreen.routeName);
        },
        message: "Account setup completed successfully",
      );
    }
  }

  Widget _errorText(String? error) {
    if (error == null) return const SizedBox.shrink();
    return Padding(
      padding: EdgeInsets.only(top: 5.h),
      child: Text(
        error,
        style: TextStyle(
          color: AllColor.levelText, // same as hint or label color
          fontSize: 14.sp,
          fontFamily: "OpenText",
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40.h),
                Center(
                  child: Text(
                    "Set Up Address & Password",
                    style: TextStyle(
                      fontFamily: "headFont",
                      fontWeight: FontWeight.w800,
                      fontSize: 24.sp,
                      color: AllColor.black,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                Center(
                  child: Text(
                    "Complete these steps to finish setting up \n your account.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontFamily: "OpenText",
                      fontWeight: FontWeight.w400,
                      color: AllColor.levelText,
                    ),
                  ),
                ),
                SizedBox(height: 30.h),

                // 🔹 Address
                CustomLabelText(title: "Address"),
                SizedBox(height: 6.h),
                TextFormField(
                  controller: _addressController,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: AllColor.black,
                    fontFamily: "OpenText",
                  ),
                  decoration: const InputDecoration(
                    hintText: "Enter Your Address",
                  ),
                ),
                _errorText(_addressError),
                SizedBox(height: 25.h),

                // 🔹 Password
                CustomLabelText(title: "Password"),
                TextFormField(
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: AllColor.black,
                    fontFamily: "OpenText",
                  ),
                  decoration: InputDecoration(
                    hintText: "Enter Your Password",
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: AllColor.levelText,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                ),
                _errorText(_passwordError),
                SizedBox(height: 25.h),

                // 🔹 Confirm Password
                CustomLabelText(title: "Confirm Password"),
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: !_isConfirmPasswordVisible,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: AllColor.black,
                    fontFamily: "OpenText",
                  ),
                  decoration: InputDecoration(
                    hintText: "Confirm Your Password",
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isConfirmPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: AllColor.levelText,
                      ),
                      onPressed: () {
                        setState(() {
                          _isConfirmPasswordVisible =
                          !_isConfirmPasswordVisible;
                        });
                      },
                    ),
                  ),
                ),
                _errorText(_confirmPasswordError),
                SizedBox(height: 40.h),

                // 🔹 Submit Button
                Center(
                  child: GlobalButton(
                    text: "Submit",
                    onPressed: _validateForm,
                  ),
                ),
                SizedBox(height: 20.h),
              ],
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
// import 'package:workpleis/core/constants/color_control/all_color.dart';
// import 'package:workpleis/core/widget/global_aleart_box.dart';
// import 'package:workpleis/core/widget/global_bottom.dart';
// import 'package:workpleis/features/auth/screens/email_verification.dart';
// import 'package:workpleis/features/auth/screens/login_screen.dart';
// import 'package:workpleis/features/auth/widgets/custom_label_text.dart';
// import 'package:workpleis/features/onboarding/screen/onboarding_screen_01.dart';
//
// class AddressAndPassword extends StatelessWidget {
//   const AddressAndPassword({super.key});
//
//   static final routeName = "/addressAndPassword";
//
//   @override
//   Widget build(BuildContext context) {
//     TextTheme theme = Theme.of(context).textTheme;
//     TextEditingController _addressController = TextEditingController();
//     TextEditingController _passwordController = TextEditingController();
//     TextEditingController _confirmPasswordController = TextEditingController();
//     return Scaffold(
//       body: SafeArea(child:  Padding(
//         padding:  EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Spacer(),
//               Text("Set Up Address & Password",
//                   style:TextStyle(fontFamily:"headFont", fontWeight: FontWeight.w800, fontSize: 20.sp,color: AllColor.black) ),
//               SizedBox(height: 8.h),
//               Text("Complete these steps to finish setting up \n your account.",textAlign: TextAlign.center,
//                   style:TextStyle(fontSize: 14.sp,  fontFamily:"OpenText", fontWeight: FontWeight.w400, color: AllColor.levelText)),
//               SizedBox(height: 30.h),
//
//               // 🔹 Full Name
//             CustomLabelText(title: "Address",),
//               SizedBox(height: 6.h),
//               TextFormField(
//                 style: TextStyle(
//                   fontSize: 14.sp,
//                   fontWeight: FontWeight.w400,
//                   color: AllColor.black,
//                   fontFamily: "OpenText",
//                 ),
//                 controller: _addressController,
//                 validator: (v) =>
//                 v == null || v.isEmpty? "Enter your Address" : null,
//                 decoration: const InputDecoration(
//                   hintText: "Enter Your Address",
//                 ),
//               ),
//               SizedBox(height: 25.h),
//               CustomLabelText(title: "Password",),
//               TextFormField(
//                 style: TextStyle(
//                   fontSize: 14.sp,
//                   fontWeight: FontWeight.w400,
//                   color: AllColor.black,
//                   fontFamily: "OpenText",
//                 ),
//                 controller: _passwordController,
//                 validator: (v) =>
//                 v == null || v.isEmpty ? "Enter your Password" : null,
//                 decoration: const InputDecoration(
//                   hintText: "Enter Your Password",
//                 ),
//               ),
//               SizedBox(height: 25.h),
//               CustomLabelText(title: "Confirm Password",),
//               TextFormField(
//                 style: TextStyle(
//                   fontSize: 14.sp,
//                   fontWeight: FontWeight.w400,
//                   color: AllColor.black,
//                   fontFamily: "OpenText",
//                 ),
//                 controller: _confirmPasswordController,
//                 validator: (v) =>
//                 v == null || v.isEmpty ? "Enter your Confirm Password" : null,
//                 decoration: const InputDecoration(
//                   hintText: "Confirm Your Password",
//                 ),
//               ),
//               SizedBox(height: 25.h),
//               GlobalButton(
//                   text: "Submit", onPressed: () {
//                 globalShowAlertDialog(context: context, oneTap: () {context.push(LoginScreen.routeName);});
//               })
//               ,
//               Spacer(),
//             ],
//           ),
//         ),
//       )),
//     );
//   }
// }