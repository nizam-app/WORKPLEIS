import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:video_player/video_player.dart';
// your own imports
import 'package:workpleis/features/auth/logic/get_started_video_reverpod.dart';
import 'package:workpleis/features/auth/logic/signup_screen_check.dart';
import 'package:workpleis/features/auth/screens/enter_your_email.dart';
import 'package:workpleis/features/auth/screens/login_screen.dart';

class GetStartedScreen extends ConsumerWidget {
  const GetStartedScreen({super.key, this.title});
  static const String routeName = '/get_started_screen';
  final String? title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1) prefs → role load
    final roleLoad = ref.watch(loadRoleProvider);

    // 2) video done => navigate (listen must be inside build)
    ref.listen<bool>(videoSequenceCompletedProvider, (prev, next) {
      if (next == true) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if ((title ?? '') == "login") {
            context.push(LoginScreen.routeName);
          } else {
            context.push(EnterYourEmail.routeName);
          }
        });
      }
    });

    return roleLoad.when(
      loading: () => const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator(color: Colors.white)),
      ),
      error: (_, __) => const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: Text('Failed to load role', style: TextStyle(color: Colors.white))),
      ),
      data: (_) {
        // 3) controller from notifier (auto plays based on role)
        final controller = ref.watch(videoCtlP);
        final loading = controller == null || !controller.value.isInitialized;

        return Scaffold(
          backgroundColor: Colors.black,
          body: loading
              ? const Center(child: CircularProgressIndicator(color: Colors.white))
              : Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()..scale(0.90, 1.0),
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: controller.value.size.width,
                      height: controller.value.size.height,
                      child: VideoPlayer(controller),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}