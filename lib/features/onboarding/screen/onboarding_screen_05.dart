import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/core/widget/global_get_started_button.dart';

class OnboardingScreen05 extends StatefulWidget {
  const OnboardingScreen05({super.key});
  static const String routeName = '/onboarding_screen_05';

  @override
  State<OnboardingScreen05> createState() => _OnboardingScreen05State();
}

class _OnboardingScreen05State extends State<OnboardingScreen05> {
  final _controller = PageController();
  int _index = 0;

  final _slides = const <_SlideData>[
    _SlideData(
      imageAsset: 'assets/images/slider0.png',
      titleTop: 'TEAM UP FOR',
      titleAccent: 'SUCCESS',
      description:
      'Get ready to unlock your potential and witness the power of teamwork.',
    ),
    _SlideData(
      imageAsset: 'assets/images/slider01.png',
      titleTop: 'USER FRIENDLY',
      titleAccent: 'AT ITS CORE',
      description:
      'Our interface empowers you with intuitive control and effortless interactions.',
    ),
    _SlideData(
      imageAsset: 'assets/images/slider1.png',
      titleTop: 'EASY TASK',
      titleAccent: 'CREATION',
      description:
      'Quickly add tasks, set due dates, and add descriptions with ease.',
    ),
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    for (final s in _slides) {
      precacheImage(AssetImage(s.imageAsset), context);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Slider
          PageView.builder(
            controller: _controller,
            itemCount: _slides.length,
            onPageChanged: (i) => setState(() => _index = i),
            itemBuilder: (_, i) => _OnboardingSlide(
              data: _slides[i],
              index: _index,
              total: _slides.length,
            ),
          ),

          // Bottom card (buttons + legal) — pager removed from here
          Align(
            alignment: Alignment.bottomCenter,
            child: _BottomAuthCard(
              onLogin: () => debugPrint('Login tapped'),
              onSignUp: () => debugPrint('Sign Up tapped'),
            ),
          ),
        ],
      ),
    );
  }
}

/// ---------- SLIDE (logo + title + description + PAGER just below description) ----------
class _OnboardingSlide extends StatelessWidget {
  const _OnboardingSlide({
    required this.data,
    required this.index,
    required this.total,
  });

  final _SlideData data;
  final int index;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(data.imageAsset, fit: BoxFit.cover),
        ),
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AllColor.black.withOpacity(.15),
                  AllColor.black.withOpacity(.88),
                ],
              ),
            ),
          ),
        ),

        Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // logo
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Center(
                    child: Image.asset('assets/images/on_logo.png',
                        fit: BoxFit.cover),
                  ),
                ),
                SizedBox(height: 10.h),

                // headline
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '${data.titleTop}\n',
                        style: TextStyle(
                          fontSize: 42.sp,
                          fontWeight: FontWeight.w700,
                          color: AllColor.white,
                          fontFamily: 'sf_Pro',
                        ),
                      ),
                      TextSpan(
                        text: data.titleAccent,
                        style: TextStyle(
                          fontSize: 42.sp,
                          fontWeight: FontWeight.w700,
                          color: AllColor.primary,
                          fontFamily: 'sf_Pro',
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8.h),

                // description
                Text(
                  data.description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AllColor.white,
                    fontFamily: 'sf_Pro',
                    fontWeight: FontWeight.w400,
                  ),
                ),

                SizedBox(height: 16.h),

                // pager (moved here under description)
                _Pager(index: index, total: total),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// ---------- BOTTOM CARD (only buttons + legal; no pager here) ----------
class _BottomAuthCard extends StatelessWidget {
  const _BottomAuthCard({
    required this.onLogin,
    required this.onSignUp,
  });

  final VoidCallback onLogin;
  final VoidCallback onSignUp;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 14.sp,
        left: 12.sp,
        right: 12.sp,
        bottom: 12.sp,
      ),
      decoration: BoxDecoration(
        color: AllColor.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
        boxShadow: [
          BoxShadow(
            color: AllColor.black.withOpacity(.12),
            blurRadius: 24,
            offset: const Offset(0, -6),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 16.h),

            GlobalGetStartedButton(
              onTap: onLogin,
              textColor: AllColor.white,
              color: AllColor.black,
              buttonName: "Log in",
            ),
            SizedBox(height: 12.h),
            GlobalGetStartedButton(
              onTap: onSignUp,
              textColor: AllColor.black,
              buttonName: "Sign up",
            ),

            SizedBox(height: 10.h),
            const _LegalText(),
          ],
        ),
      ),
    );
  }
}

class _LegalText extends StatelessWidget {
  const _LegalText();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        Text(
          'By continuing, you agree to our ',
          style: TextStyle(
            fontSize: 16.sp,
            color: AllColor.black,
            fontFamily: 'sf_Pro',
            fontWeight: FontWeight.w400,
          ),
        ),
        _link('Privacy Policy', () => debugPrint('Privacy tapped')),
        Text(
          ' and ',
          style: TextStyle(
            fontSize: 16.sp,
            color: AllColor.black,
            fontFamily: 'sf_Pro',
            fontWeight: FontWeight.w400,
          ),
        ),
        _link('Terms of Use', () => debugPrint('Terms tapped')),
      ],
    );
  }

  Widget _link(String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Text(
        label,
        style: TextStyle(
          fontSize: 16.sp,
          color: AllColor.black,
          fontFamily: 'sf_Pro',
          fontWeight: FontWeight.w400,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}

class _Pager extends StatelessWidget {
  const _Pager({required this.index, required this.total});
  final int index;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(total, (i) {
        final active = i == index;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 6,
          width: active ? 28 : 10,
          decoration: BoxDecoration(
            color: active ? AllColor.primary : AllColor.white,
            borderRadius: BorderRadius.circular(30.r),
          ),
        );
      }),
    );
  }
}

class _SlideData {
  final String imageAsset;
  final String titleTop;
  final String titleAccent;
  final String description;

  const _SlideData({
    required this.imageAsset,
    required this.titleTop,
    required this.titleAccent,
    required this.description,
  });
}
