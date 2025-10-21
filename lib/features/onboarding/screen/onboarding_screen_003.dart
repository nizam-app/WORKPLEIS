
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/features/auth/logic/signup_screen_check.dart';
import 'package:workpleis/features/auth/screens/enter_your_email.dart';
import 'package:workpleis/features/auth/screens/get_started_screen.dart';
import 'package:workpleis/features/community_guidenlines/screen/community_guidenlines_screen.dart';
import 'package:workpleis/features/community_guidenlines/screen/privacy_policy_screen.dart';
import 'package:workpleis/features/community_guidenlines/screen/terms_and_conditions_screen.dart';
import 'package:workpleis/features/onboarding/screen/onboarding_screen_001.dart';
import 'package:workpleis/features/onboarding/widget/custom_onboarding_upper_logo.dart';
import 'package:workpleis/features/onboarding/widget/custom_pageIndicator.dart';
import 'package:workpleis/features/onboarding/widget/custom_pill_button.dart';

import '../../auth/logic/get_started_video_reverpod.dart';
import '../../auth/screens/login_screen.dart';

class OnboardingScreen02 extends StatelessWidget {
  const OnboardingScreen02({super.key, this.screenName = "login"});
  final String? screenName;

  static const String routeName = '/onboarding_screen_02';

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    return Scaffold(body: SafeArea(child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10.h,),
        CustomOnboardingUpperLogo(),
        SizedBox(height: 80.h,),
        Image.asset("assets/images/Onboardin02.png",
          width: double.infinity,
        height: 300.h,),
        Center(
          child: CustomPageIndicator(
            currentIndex: 2, // এখন কোন index active
          ),
        ),
        SizedBox(height: 30.h,),
        buildColumn(theme),


      ],
    )),
      bottomNavigationBar: Onboarding02Bottonbar(screenName: screenName,),
    );
  }

  Column buildColumn(TextTheme theme) {
    return Column(
      mainAxisSize: MainAxisSize.max,
        children: [
          Center(child: Text("Team up For Success",style: theme.bodySmall!.copyWith(fontSize:24 ))),
          SizedBox(height: 5.h,),
          Text("Get ready to unleash your potential and \n"
              " witness the power of teamwork",textAlign: TextAlign.center,style: TextStyle(fontFamily: "bodyFont",),)
        ],
      );
  }
}

enum AuthTab { login, signup }
final authTabProvider = StateProvider<AuthTab?>((ref) => AuthTab.login);

class Onboarding02Bottonbar extends ConsumerStatefulWidget {
  const Onboarding02Bottonbar({
    super.key,
    this.onLogin,
    this.onSignup,
    this.onTapTerms,
    this.onTapGuidelines,
    this.onTapPrivacy,
    this.screenName,
  });

  final VoidCallback? onLogin;
  final VoidCallback? onSignup;
  final VoidCallback? onTapTerms;
  final VoidCallback? onTapGuidelines;
  final VoidCallback? onTapPrivacy;
  final String? screenName;

  @override
  ConsumerState<Onboarding02Bottonbar> createState() =>
      _Onboarding02BottonbarState();
}

class _Onboarding02BottonbarState
    extends ConsumerState<Onboarding02Bottonbar> {
  late final TapGestureRecognizer _termsTap;
  late final TapGestureRecognizer _guidelinesTap;
  late final TapGestureRecognizer _privacyTap;

  @override
  void initState() {
    super.initState();
    _termsTap = TapGestureRecognizer()
      ..onTap = () {
        context.push(TermsAndConditionsScreen.routeName);
      };

    _guidelinesTap = TapGestureRecognizer()..onTap=(){
      context.push(CommunityGuidenlinesScreen.routeName);
    };

    _privacyTap = TapGestureRecognizer()..onTap =(){
      context.push(PrivacyPolicyScreen.routeName);
    };

    //_termsTap = TapGestureRecognizer()..onTap = widget.onTapTerms;
    // _guidelinesTap = TapGestureRecognizer()..onTap = widget.onTapGuidelines;
    // _privacyTap = TapGestureRecognizer()..onTap = widget.onTapPrivacy;
  }

  @override
  void dispose() {
    _termsTap.dispose();
    _guidelinesTap.dispose();
    _privacyTap.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selected = ref.watch(authTabProvider);

    return Container(
      width: double.infinity,
      // চাইলে auto-height করতে height বাদ দিতে পারেন
      height: 180.h,
      decoration: BoxDecoration(
        color: AllColor.primary,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false, // শুধু bottom safe inset নেবে
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 25.h, 20.w, 14.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: CustomPillButton(
                      label: "Log in",
                      isSelected: selected == AuthTab.login,
                      onPressed: () {
                        ref.read(authTabProvider.notifier).state = AuthTab.login;
                        widget.onLogin?.call();
                        context.push(LoginScreen.routeName,);
                        ref.invalidate(loadRoleProvider);
                      },
                    ),
                  ),
                  SizedBox(width: 18.w),
                  Expanded(
                    child: CustomPillButton(
                      label: "Sign up",
                      isSelected: selected == AuthTab.signup,
                      onPressed: () {
                        ref.read(authTabProvider.notifier).state = AuthTab.signup;
                        widget.onSignup?.call();
                          context.push(EnterYourEmail.routeName,);
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25.h),
              Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 12.sp,
                      height: 1.35,
                      color: AllColor.black.withOpacity(0.75),
                      fontWeight: FontWeight.w400,
                    ),
                    children: [
                       TextSpan(
                        text: 'By signing up, I agree to Workpleis ',style:  Theme.of(context)
                           .textTheme
                           .bodyMedium!
                           .copyWith(fontSize: 13.sp),
                      ),
                      TextSpan(

                        text: 'Terms & Conditions',
                        style:  TextStyle(
                          color: AllColor.black,
                          fontWeight: FontWeight.w600,
                          decorationThickness: 1.1,
                          fontFamily: "bodyFond",
                          fontSize: 14.sp
                        ),
                        recognizer: _termsTap,
                      ),
                       TextSpan(text: ', & ',style: TextStyle( fontFamily: "bodyFond",
                           fontSize: 14.sp,fontWeight: FontWeight.w400)),
                      TextSpan(
                        text: 'Community Guidelines',
                        style:  TextStyle(
                          color: AllColor.black,
                          fontWeight: FontWeight.w600,
                          decorationThickness: 1.1,
                            fontFamily: "bodyFond",
                            fontSize: 14.sp
                        ),
                        recognizer: _guidelinesTap,
                      ),
                       TextSpan(text: '. ', style: TextStyle( fontFamily: "bodyFond",
                           fontSize: 14.sp)),
                      TextSpan(
                        text: 'Privacy Policy',
                        style:  TextStyle(
                          color: AllColor.black,
                          fontWeight: FontWeight.w600,
                          decorationThickness: 1.1,
                            fontFamily: "bodyFond",
                            fontSize: 14.sp
                        ),
                        recognizer: _privacyTap,
                      ),
                    ],
                  ),
                ),
              ),
              // ⛔️ আর কোনো MediaQuery.bottom extra padding/Spacer নাই
            ],
          ),
        ),
      ),
    );
  }
}
