import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/features/onboarding/screen/onboarding_screen_03.dart';
import 'package:workpleis/features/onboarding/widget/custom_onboarding_upper_logo.dart';
import 'package:workpleis/features/onboarding/widget/custom_pageIndicator.dart';
import 'package:workpleis/features/onboarding/widget/custom_pill_button.dart';

import 'onboarding_screen_04.dart' show OnboardingScreen04;

class OnboardingScreen03 extends StatelessWidget {
  const OnboardingScreen03({super.key});

  static const String routeName = '/onboarding_screen_03';

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    return Scaffold(
        body: SafeArea(
          child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
          SizedBox(height: 10.h,),
          CustomOnboardingUpperLogo(),
          SizedBox(height: 30.h,),
          Image.asset("assets/images/Onboarding03.png",
            width: double.infinity,),
          Center(
            child: CustomPageIndicator(
              currentIndex: 1, // এখন কোন index active
            ),
          ),
          SizedBox(height: 20.h,),
          buildColumn(theme),
          Spacer(),
          Onboarding02Bottonbar(
            onLogin: () {},
            onSignup: () {},

          )

                ],
              )));
  }

  Column buildColumn(TextTheme theme) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(child: Text("User Friendly at its Core",style: theme.bodySmall!.copyWith(fontSize:24 ))),
        SizedBox(height: 5.h,),
        Text("Our Interface empowers you with \n"
            " intuitive controls and effortless \n"
            " interactions",textAlign: TextAlign.center,style: TextStyle(fontFamily: "bodyFont",),)
      ],
    );
  }
}

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

enum AuthTab { login, signup }
final authTabProvider = StateProvider<AuthTab?>((ref) => null);

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
          top: Radius.circular(24.r), // 👈 সরাসরি বসানো
        ),
      ),
      padding: EdgeInsets.fromLTRB(
        20.w, // horizontalPadding
        25.h, // topPadding
        20.w,
        14.h, // bottomPadding
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("A SUNTAINABLE MARKETPLACE FOR BUSINESSES",style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize:12 )),
          SizedBox(height: 5.h,),
          Text("Select your role",style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize:20 ),),
          SizedBox(height: 15.h),

          Row(
            children: [
              Expanded(
                child: CustomPillButton(
                  label: "I'm a Client",
                  isSelected: selected == AuthTab.login,
                  onPressed: () {
                    ref.read(authTabProvider.notifier).state = AuthTab.login;
                    widget.onLogin?.call();
                    context.push(OnboardingScreen04.routeName);
                  },
                ),
              ),
              SizedBox(width: 15.w), // buttonSpacing
              Expanded(
                child: CustomPillButton(
                  label: "I'm a Service Provider",
                  isSelected: selected == AuthTab.signup,
                  onPressed: () {
                    ref.read(authTabProvider.notifier).state = AuthTab.signup;
                    widget.onSignup?.call();
                    context.push(OnboardingScreen04.routeName);
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h + MediaQuery.paddingOf(context).bottom),
        ],
      ),
    );
  }
}
