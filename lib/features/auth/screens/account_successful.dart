import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/features/auth/screens/login_screen.dart';

import '../../../core/widget/global_get_started_button.dart';

class AccountSuccessful extends StatelessWidget {
  const AccountSuccessful({super.key});

  static const String routeName = '/accountSuccess';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.w),
          child: Column(
            children: [
              const Spacer(flex: 2),

              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/sucessfull.png', // <-- change path
                    height: 160.h,
                    fit: BoxFit.contain,
                  ),

                  SizedBox(height: 24.h),

                  Text(
                    'Account Successful',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w500,
                      color: AllColor.black,
                      fontFamily: 'sf_pro',
                    ),
                  ),

                  SizedBox(height: 8.h),

                  Text(
                    "The new Password must be update in that user's\n"
                        "date in te WORKPLEIS",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.sp,
                      height: 1.5,
                      color: const Color(0xff6B6B6B),
                      fontFamily: 'sf_pro',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const Spacer(flex: 3),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),

      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(22.w, 0, 22.w, 24.h),
        child: SizedBox(
          width: double.infinity,
          height: 56.h,
          child: CustomButton(
            text: "Done",
            onTap: () {
            context.push(LoginScreen.routeName);
            },
          ),
        ),
      ),

    );
  }
}
