import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:video_player/video_player.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/core/widget/global_get_started_button.dart';
import 'package:workpleis/features/auth/logic/get_started_video_reverpod.dart';
import 'package:workpleis/features/auth/logic/signup_screen_check.dart';
import 'package:workpleis/features/auth/screens/enter_your_email.dart';
import 'package:workpleis/features/auth/screens/login_screen.dart';

class GetStartedScreen extends ConsumerWidget {
  const GetStartedScreen({super.key,  this.title});
  static const String routeName = '/get_started_screen';
  final String? title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(videoPlayerControllerProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      body: controller == null
          ? const Center(
        child: CircularProgressIndicator(color: Colors.white),
      )
          : controller.value.isInitialized
          ? Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Stack(
                    fit: StackFit.expand,
                    children: [
            /// ✅ Fullscreen video with scale padding effect
            Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..translate(0.0)   // keeps it centred
                ..scale(0.90, 1.0), // 👈 width shrink only
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: controller.value.size.width,
                  height: controller.value.size.height,
                  child: VideoPlayer(controller),
                ),
              ),
            ),
            /// ✅ Get Started Button
            Positioned(
              bottom: 50,
              left: 0,
              right: 0,
              child: GlobalGetStartedButton(

                onTap: () {
                  if (title =="login") {
                    context.push(LoginScreen.routeName);
                  }
                  else{

                    context.push(EnterYourEmail.routeName);
                    checkForBusiness(ref, title ?? '');

                  }

                 },
                color: AllColor.primary,
              ),
            ),
                    ],
                  ),
          )
          : const Center(
        child: CircularProgressIndicator(color: Colors.white),
      ),
    );
  }
}
