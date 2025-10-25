import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/features/auth/screens/enter_your_email.dart';
import 'package:workpleis/features/auth/screens/get_started_screen.dart';
import 'package:workpleis/features/onboarding/logic/check_individual.dart';
import 'package:workpleis/features/onboarding/screen/onboarding_screen_003.dart';
import 'package:workpleis/features/onboarding/widget/custom_onboarding_upper_logo.dart';
import 'package:workpleis/features/onboarding/widget/custom_pageIndicator.dart';
import 'package:workpleis/features/onboarding/widget/custom_pill_button.dart';

class OnboardingScreen04 extends StatelessWidget {
  const OnboardingScreen04({super.key});


  static const String routeName = '/onboarding_screen_04';
  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    return Scaffold(body: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.h,),
          CustomOnboardingUpperLogo(),
          SizedBox(height: 40.h,),
          Image.asset("assets/images/Onboarding04.png",
            width: double.infinity,
          height: 350.h,),
          Center(
            child: CustomPageIndicator(
              currentIndex: 1, // এখন কোন index active
            ),
          ),
          SizedBox(height: 30.h,),
          buildColumn(theme),
        ],
      ),
    ) ,
      bottomNavigationBar: Onboarding02Bottonbar()
      
    );
  }

  Column buildColumn(TextTheme theme) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Center(child: Text("Easy Task Creation",style:TextStyle(fontSize:24, fontFamily: "headFont",fontWeight: FontWeight.w800))),
        SizedBox(height: 5.h,),
        Text("Quickly add tasks, add due date, add \n"
            "description with ease",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12.sp, fontFamily: "OpenText",),)
      ],
    );
  }
}

// enum + provider
enum AuthTab { login, signup }
final authTabProvider = StateProvider<AuthTab?>((ref) => AuthTab.signup);

class Onboarding02Bottonbar extends ConsumerStatefulWidget {
  const Onboarding02Bottonbar({
    super.key,
    this.onLogin,
    this.onSignup,
  });

  final VoidCallback? onLogin;
  final VoidCallback? onSignup;

  @override
  ConsumerState<Onboarding02Bottonbar> createState() =>
      _Onboarding02BottonbarState();
}

class _Onboarding02BottonbarState
    extends ConsumerState<Onboarding02Bottonbar> {

  @override
  Widget build(BuildContext context) {
    final selected = ref.watch(authTabProvider);

    return Container(
      width: double.infinity,
      height: 180.h,
      decoration: BoxDecoration(
        color: AllColor.primary,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24.r),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false, // bottom-only safe area
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 25.h, 20.w, 14.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "A SUNTAINABLE MARKETPLACE FOR BUSINESSES",
                style:TextStyle(fontSize: 12.sp,fontWeight: FontWeight.w400, fontFamily: "OpenText"),
              ),
              SizedBox(height: 5.h),
              Text(
                "Select your type",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700, fontFamily: "OpenText"),
              ),
              SizedBox(height: 15.h),

              Row(
                children: [
                  Expanded(
                    child: CustomPillButton(
                      label: "For Individual",
                      isSelected: selected == AuthTab.login,
                      onPressed: ()async {
                        ref.read(authTabProvider.notifier).state = AuthTab.login;
                        widget.onLogin?.call();
                        await saveCheckBusiness(ref, 'individual');
                        context.push(OnboardingScreen02.routeName,);
                      },
                    ),
                  ),
                  SizedBox(width: 15.w),
                  Expanded(
                    child: CustomPillButton(
                      label: "For Business",
                      isSelected: selected == AuthTab.signup,
                      onPressed: ()async {
                        ref.read(authTabProvider.notifier).state = AuthTab.signup;
                        widget.onSignup?.call();
                        await saveCheckBusiness(ref, 'business');
                        context.push(
                          OnboardingScreen02.routeName,

                        );
                      },
                    ),
                  ),
                ],
              ),

              // ⛔️ আর কোনো extra bottom SizedBox নাই—ফাঁকা আর থাকবে না
            ],
          ),
        ),
      ),
    );
  }
}
