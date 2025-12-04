import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/color_control/all_color.dart';
import '../../onboarding/screen/onboarding_screen_01.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String routeName = '/splashScreen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // 3 seconds por RoleSelectionScreen e navigate
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
     context.push(OnboardingScreen01.routeName);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AllColor.primary,
      body: Padding(
        padding: EdgeInsets.all(3.r),
        child: Center(
          child: Column(
            children: [
              const Spacer(),
              Image.asset(
                'assets/images/splashlogo.png',
                height: 90.h,
                fit: BoxFit.cover,
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
