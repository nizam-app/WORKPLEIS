// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:go_router/go_router.dart';
// import 'package:workpleis/core/constants/color_control/all_color.dart';
// import 'package:workpleis/core/widget/global_bottom.dart';
// import 'package:workpleis/features/auth/screens/email_verification.dart';
//
// import 'new_password_screen.dart';
// class ForgetVerificationCodeScreen  extends StatelessWidget {
//   const ForgetVerificationCodeScreen ({super.key});
//   static final routeName = "/forgetVerificationCodeScreen" ;
//
//   @override
//   Widget build(BuildContext context) {
//     TextEditingController _emailController = TextEditingController();
//     TextTheme theme = Theme.of(context).textTheme;
//     return Scaffold(
//       body: SafeArea(child: Padding(
//         padding:  EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
//         child: Column(
//           children: [
//             Spacer(),
//             Text("Enter verification Code",
//                 style:TextStyle(fontFamily:"headFont", fontWeight: FontWeight.w800, fontSize: 24.sp,color: AllColor.black) ),
//             SizedBox(height: 8.h),
//             Text("We have sent a code to",textAlign: TextAlign.center,
//                 style: TextStyle(fontSize: 16.sp,  fontFamily:"OpenText", fontWeight: FontWeight.w400, color: AllColor.levelText)),
//             // Text("We have sent a code to",textAlign: TextAlign.center,
//             //     style: TextStyle(fontSize: 14.sp,  fontFamily:"OpenText", fontWeight: FontWeight.w400, color: AllColor.levelText)),
//             SizedBox(height: 30.h),
//
//             // 🔹 Full Name
//             Padding(
//               padding:  EdgeInsets.only(left: 2.w),
//               child: Align(
//                 alignment: Alignment.centerLeft,
//
//                 child: Text("OTP",
//                     style: TextStyle(
//                         fontSize: 18.sp, fontWeight: FontWeight.w800, color: AllColor.borderColor, fontFamily:"OpenText")
//                 ),
//               ),
//             ),
//             SizedBox(height: 6.h),
//             TextFormField(
//               style: TextStyle(
//                   fontSize: 16.sp,
//                   fontWeight: FontWeight.w400,
//                   color: AllColor.black,
//                   fontFamily: "OpenText"
//               ),
//
//               controller: _emailController,
//               validator: (v) =>
//               v == null || v.isEmpty || v.contains("com") ? "Enter your OTP" : null,
//               decoration: const InputDecoration(
//                 hintText: "Enter your OTP",
//               ),
//             ),
//             SizedBox(height: 25.h),
//             GlobalButton(text: "Verify Now", onPressed: () {context.push(NewPasswordScreen.routeName);})
//             ,
//             Spacer(),
//           ],
//         ),
//       )),
//
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/core/widget/global_get_started_button.dart';
import 'package:workpleis/features/auth/screens/new_password_screen.dart';

class ForgetVerificationCodeScreen extends ConsumerStatefulWidget {
  const ForgetVerificationCodeScreen({super.key});

  static const String routeName = '/forgetVerificationCodeScreen';

  @override
  ConsumerState<ForgetVerificationCodeScreen> createState() =>
      _ForgetVerificationCodeScreenState();
}

class _ForgetVerificationCodeScreenState
    extends ConsumerState<ForgetVerificationCodeScreen> {
  final _formKey = GlobalKey<FormState>();

  final List<TextEditingController> _controllers =
  List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 16.h),
          physics: const BouncingScrollPhysics(),
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
                  '6- digit code',
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
                  "To confirm your phone number, please enter the\n"
                      "OTP we sent +016 ********13",
                  style: TextStyle(
                    fontSize: 18.sp,
                    height: 1.5,
                    color: AllColor.black,
                    fontFamily: 'sf_pro',
                    fontWeight: FontWeight.w400,
                  ),
                ),

                SizedBox(height: 32.h),

                /// OTP boxes + dash
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildOtpBox(0),
                    SizedBox(width: 6.w),
                    _buildOtpBox(1),
                    SizedBox(width: 6.w),
                    _buildOtpBox(2),
                    SizedBox(width: 4.w),
                    _buildDash(),
                    SizedBox(width: 4.w),

                    _buildOtpBox(3),
                    SizedBox(width: 6.w),
                    _buildOtpBox(4),
                    SizedBox(width: 6.w),
                    _buildOtpBox(5),
                  ],
                ),

                SizedBox(height: 80.h),
              ],
            ),
          ),
        ),
      ),

      /// Bottom button
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(22.w, 0, 22.w, 24.h),
        child: SizedBox(
          width: double.infinity,
          height: 56.h,
          child: CustomButton(
            text: "Continue",
            icon: Icons.arrow_forward,
            onTap: () {
              final code = _controllers.map((c) => c.text).join();
              context.push(NewPasswordScreen.routeName);
              // print(code);
            },
          ),
        ),
      ),
    );
  }

  /// Single OTP box
  Widget _buildOtpBox(int index) {
    return SizedBox(
      width: 54.w,
      height: 54.h,
      child: TextFormField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        style: TextStyle(
          fontSize: 18.sp,
          color: const Color(0xff111111),
          fontFamily: 'sf_pro',
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: const Color(0xffF7F7F7),
          contentPadding: EdgeInsets.zero,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: const BorderSide(color: Color(0xffE5E5EA)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: BorderSide(color: AllColor.grey50, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: BorderSide(color: AllColor.grey50, width: 1.2),
          ),
        ),
        onChanged: (value) {
          if (value.length == 1 && index < 5) {
            _focusNodes[index + 1].requestFocus();
          }
          if (value.isEmpty && index > 0) {
            _focusNodes[index - 1].requestFocus();
          }
        },
      ),
    );
  }

  /// Middle dash bar
  Widget _buildDash() {
    return Container(
      width: 24.w,
      height: 3.h,
      decoration: BoxDecoration(
        color: AllColor.black,
        borderRadius: BorderRadius.circular(999.r),
      ),
    );
  }
}
