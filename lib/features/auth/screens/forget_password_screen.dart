// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:go_router/go_router.dart';
// import 'package:workpleis/core/constants/color_control/all_color.dart';
// import 'package:workpleis/core/widget/global_bottom.dart';
// import 'package:workpleis/features/auth/screens/email_verification.dart';
//
// import 'forget_verification_code_screen.dart';
// class ForgetPasswordScreen  extends StatelessWidget {
//   const ForgetPasswordScreen ({super.key});
//   static final routeName = "/forgetPasswordScreen" ;
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
//             Text("Forgot Password",
//                 style:TextStyle(fontFamily:"headFont", fontWeight: FontWeight.w800, fontSize: 24.sp,color: AllColor.black)),
//             SizedBox(height: 8.h),
//             Text("Enter your email account to \n reset password",textAlign: TextAlign.center,
//                 style: TextStyle(fontSize: 16.sp,  fontFamily:"OpenText", fontWeight: FontWeight.w400, color: AllColor.levelText)),
//             SizedBox(height: 30.h),
//
//             // 🔹 Full Name
//             Padding(
//               padding:  EdgeInsets.only(left: 2.w),
//               child: Align(
//                 alignment: Alignment.centerLeft,
//
//                 child: Text("Email",
//                     style:TextStyle(
//                         fontSize: 18.sp, fontWeight: FontWeight.w800, color: AllColor.borderColor, fontFamily:"OpenText"
//                     ),),
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
//               v == null || v.isEmpty || v.contains("com") ? "Enter your Email" : null,
//               decoration: const InputDecoration(
//                 hintText: "type your email",
//
//               ),
//             ),
//             SizedBox(height: 25.h),
//             GlobalButton(text: "Continue", onPressed: () {context.push(ForgetVerificationCodeScreen.routeName);})
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
import 'package:workpleis/features/auth/screens/forget_verification_code_screen.dart';

class ForgetPasswordScreen extends ConsumerStatefulWidget {
  const ForgetPasswordScreen({super.key});

  static const String routeName = '/forget-password';

  @override
  ConsumerState<ForgetPasswordScreen> createState() =>
      _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends ConsumerState<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _userNameController = TextEditingController();
  final _phoneController = TextEditingController(text: '191206-3452');

  @override
  void dispose() {
    _userNameController.dispose();
    _phoneController.dispose();
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

                InkWell(
                  onTap: () => context.pop(),
                  borderRadius: BorderRadius.circular(14.r),
                  child: Container(
                    height: 40.w,
                    width: 40.w,
                    decoration: BoxDecoration(
                      color:AllColor.grey70,
                      borderRadius: BorderRadius.circular(14.r)
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
                  'Forgot Password',
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
                  "Don’t worry! we will send an OTP to your registered email address.",
                  style: TextStyle(
                    fontSize: 18.sp,
                    height: 1.5,
                    color: AllColor.black,
                    fontFamily: 'sf_pro',
                    fontWeight: FontWeight.w400,
                  ),
                ),

                SizedBox(height: 32.h),

                /// User name label
                Text(
                  'User Name',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: const Color(0xff171717),
                    fontFamily: 'sf_pro',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8.h),

                /// User name field
                TextFormField(
                  controller: _userNameController,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.black.withOpacity(0.3),
                    fontFamily: 'sf_pro',
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: _inputDecoration(
                    hint: 'username',
                  ),
                ),

                SizedBox(height: 24.h),

                /// Number label
                Text(
                  'Number',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: const Color(0xff151515),
                    fontFamily: 'sf_pro',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8.h),

                /// Phone row: country + number
                Row(
                  children: [
                    /// Country code box
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 12.h,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: const Color(0xffE5E5EA),
                        ),
                        color: const Color(0xffF7F7F7),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // If you have BD flag asset, uncomment and replace:
                          // Image.asset(
                          //   ImagePath.flagBangladesh,
                          //   height: 16.h,
                          // ),
                          Container(
                            width: 18.w,
                            height: 12.h,
                            decoration: BoxDecoration(
                              color: const Color(0xff006A4E),
                              borderRadius: BorderRadius.circular(2.r),
                            ),
                            child: Center(
                              child: Container(
                                width: 8.w,
                                height: 8.w,
                                decoration: const BoxDecoration(
                                  color: Color(0xffF42A41),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            '+880',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: const Color(0xff111111),
                              fontFamily: 'sf_pro',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(width: 10.w),

                    /// Number field
                    Expanded(
                      child: TextFormField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: const Color(0xff111111),
                          fontFamily: 'sf_pro',
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: _inputDecoration(
                          hint: '191206-3452',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 80.h),

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
             child: CustomButton(text: "Continue", onTap: (){
               context.push(ForgetVerificationCodeScreen.routeName);
             }, icon: Icons.arrow_forward,)),

),
    );

  }

  InputDecoration _inputDecoration({required String hint}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(
        fontSize: 16.sp,
        color: Colors.black.withOpacity(0.3),
        fontFamily: 'sf_pro',
        fontWeight: FontWeight.w400,
      ),
      filled: true,
      fillColor: const Color(0xffF7F7F7),
      contentPadding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 14.h,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: const BorderSide(color: AllColor.grey50, width: 1),
      ),

    );
  }

}
