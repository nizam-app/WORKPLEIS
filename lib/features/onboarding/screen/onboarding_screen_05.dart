import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/core/widget/global_get_started_button.dart';
import 'package:workpleis/features/role_screen/screen/seclect_role_screen.dart';

class OnboardingScreen05 extends StatefulWidget {
  const OnboardingScreen05({super.key});
  static const String routeName = '/onboarding_screen_05';

  @override
  State<OnboardingScreen05> createState() => _OnboardingScreen05State();
}

class _OnboardingScreen05State extends State<OnboardingScreen05> {
  final _controller = PageController();
  int _index = 0;
  Timer? _autoTimer;

  final _slides = const <_SlideData>[
    _SlideData(
      imageAsset: 'assets/images/slider0.png',
      titleTop: 'TEAM UP FOR',
      titleAccent: 'SUCCESS',
      description:
      'Get ready to unleash your potential and \n witness the power of teamwork',
    ),
    _SlideData(
      imageAsset: 'assets/images/slider01.png',
      titleTop: 'USER FRIENDLY',
      titleAccent: 'AT ITS CORE',
      description:
      'Our Interface empowers you with intuitive \n control and effortless interactions',
    ),
    _SlideData(
      imageAsset: 'assets/images/slider1.png',
      titleTop: 'EASY TASK',
      titleAccent: 'CREATION',
      description:
      'Quickly add tasks, add due date,\n add description with ease',
    ),
  ];

  @override
  void initState() {
    super.initState();

    /// auto slider
    _autoTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (!_controller.hasClients) return;
      final next = (_index + 1) % _slides.length;
      _controller.animateToPage(
        next,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    for (final s in _slides) {
      precacheImage(AssetImage(s.imageAsset), context);
    }
  }

  @override
  void dispose() {
    _autoTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AllColor.black,
      body: Stack(
        children: [
          /// background slider (image + text slide হবে)
          PageView.builder(
            controller: _controller,
            physics: const BouncingScrollPhysics(),
            itemCount: _slides.length,
            onPageChanged: (i) => setState(() => _index = i),
            itemBuilder: (_, i) => _OnboardingSlide(
              data: _slides[i],
              index: _index,
              total: _slides.length,
            ),
          ),

          /// dot pager – image er ওপরে fixed থাকবে
          Positioned(
            left: 0,
            right: 0,
            // image bottom = 320.h; tar theke 40.h ওপরে
            bottom: 330.h,
            child: _Pager(index: _index, total: _slides.length),
          ),

          /// bottom white card (তোমার custom buttons)
          Align(
            alignment: Alignment.bottomCenter,
            child: _BottomAuthCard(
              onLogin: () {
                context.push(SeclectRoleScreen.routeName);
                debugPrint('Login tapped');
              },
              onSignUp: () {
                debugPrint('Sign Up tapped');
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
///  SLIDE
/// ---------------------------------------------------------------------------
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
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        /// full-screen image (bottom e 320.h gap)
        Positioned.fill(
          bottom: 320.h,
          child: Image.asset(
            data.imageAsset,
            fit: BoxFit.contain,
          ),
        ),

        /// dark gradient overlay
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AllColor.black.withOpacity(.10),
                  AllColor.black.withOpacity(.75),
                  AllColor.black.withOpacity(.96),
                ],
              ),
            ),
          ),
        ),

        /// logo + title + description (dots আলাদা Positioned এ fixed)
        Positioned(
          left: 0,
          right: 0,
          bottom: size.height * 0.34,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // small rounded square logo
                Container(
                  height: 40.r,
                  width: 40.r,
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Center(
                    child: Image.asset(
                      'assets/images/on_logo.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 12.h),

                // big title
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '${data.titleTop}\n',
                        style: TextStyle(
                          fontSize: 42.sp,
                          letterSpacing: 1.1,
                          fontWeight: FontWeight.w700,
                          color: AllColor.white,
                          fontFamily: 'sf_Pro',
                        ),
                      ),
                      TextSpan(
                        text: data.titleAccent,
                        style: TextStyle(
                          fontSize: 42.sp,
                          letterSpacing: 1.1,
                          fontWeight: FontWeight.w700,
                          color: AllColor.primary,
                          fontFamily: 'sf_Pro',
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10.h),

                // description
                Text(
                  data.description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: AllColor.white.withOpacity(0.9),
                    fontFamily: 'sf_Pro',
                    fontWeight: FontWeight.w400,
                    height: 1.35,
                  ),
                ),
                // নিচে একটু ফাঁকা রাখলাম যাতে dots এর সাথে overlap না লাগে
                SizedBox(height: 40.h),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// ---------------------------------------------------------------------------
///  BOTTOM CARD
/// ---------------------------------------------------------------------------
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
      width: double.infinity,
      padding: EdgeInsets.only(
        top: 30.h,
        left: 24.w,
        right: 24.w,
        bottom: 30.h,
      ),
      decoration: BoxDecoration(
        color: AllColor.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(30.r),
        ),
        boxShadow: [
          BoxShadow(
            color: AllColor.black.withOpacity(.20),
            blurRadius: 30.r,
            offset: Offset(0, -10.h),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GlobalGetStartedButton(
              onTap: onLogin,
              textColor: AllColor.white,
              color: AllColor.black,
              buttonName: "Log In",
            ),
            SizedBox(height: 16.h),
            GlobalGetStartedButton(
              onTap: onSignUp,
              textColor: AllColor.black,
              buttonName: "Sign Up",
            ),
            SizedBox(height: 30.h),
            const _LegalText(),
          ],
        ),
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
///  LEGAL TEXT
/// ---------------------------------------------------------------------------
class _LegalText extends StatelessWidget {
  const _LegalText();

  @override
  Widget build(BuildContext context) {
    final baseStyle = TextStyle(
      fontSize: 16.sp,
      color: AllColor.black.withOpacity(0.6),
      fontFamily: 'sf_Pro',
      fontWeight: FontWeight.w400,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'By continuing, you agree workpleis',
          textAlign: TextAlign.center,
          style: baseStyle,
        ),
        SizedBox(height: 4.h),
        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 4.w,
          children: [
            _link('Privacy Policy', () => debugPrint('Privacy tapped')),
            Text('and', style: baseStyle),
            _link('Terms of Use', () => debugPrint('Terms tapped')),
          ],
        ),
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
          decorationColor: AllColor.black,
        ),
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
///  DOT PAGER
/// ---------------------------------------------------------------------------
class _Pager extends StatelessWidget {
  const _Pager({required this.index, required this.total});

  final int index;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(total, (i) {
        final bool active = i == index;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: EdgeInsets.symmetric(horizontal: 3.w),
          height: 6.h,
          width: active ? 18.w : 6.w,
          decoration: BoxDecoration(
            color:
            active ? AllColor.white : AllColor.white.withOpacity(0.35),
            borderRadius: BorderRadius.circular(20.r),
          ),
        );
      }),
    );
  }
}

/// ---------------------------------------------------------------------------
///  MODEL
/// ---------------------------------------------------------------------------
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



// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:go_router/go_router.dart';
// import 'package:workpleis/core/constants/color_control/all_color.dart';
// import 'package:workpleis/core/widget/global_get_started_button.dart';
// import 'package:workpleis/features/role_screen/screen/seclect_role_screen.dart';
//
// class OnboardingScreen05 extends StatefulWidget {
//   const OnboardingScreen05({super.key});
//   static const String routeName = '/onboarding_screen_05';
//
//   @override
//   State<OnboardingScreen05> createState() => _OnboardingScreen05State();
// }
//
// class _OnboardingScreen05State extends State<OnboardingScreen05> {
//   final _controller = PageController();
//   int _index = 0;
//   Timer? _autoTimer;
//
//   final _slides = const <_SlideData>[
//     _SlideData(
//       imageAsset: 'assets/images/slider0.png',
//       titleTop: 'TEAM UP FOR',
//       titleAccent: 'SUCCESS',
//       description:
//       'Get ready to unleash your potential and \n witness the power of teamwork',
//     ),
//     _SlideData(
//       imageAsset: 'assets/images/slider01.png',
//       titleTop: 'USER FRIENDLY',
//       titleAccent: 'AT ITS CORE',
//       description:
//       'Our Interface empowers you with intuitive \n control and effortless interactions',
//     ),
//     _SlideData(
//       imageAsset: 'assets/images/slider1.png',
//       titleTop: 'EASY TASK',
//       titleAccent: 'CREATION',
//       description:
//       'Quickly add tasks, add due date,\n add description with ease',
//     ),
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//
//     /// auto slider
//     _autoTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
//       if (!_controller.hasClients) return;
//       final next = (_index + 1) % _slides.length;
//       _controller.animateToPage(
//         next,
//         duration: const Duration(milliseconds: 500),
//         curve: Curves.easeInOut,
//       );
//     });
//   }
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     for (final s in _slides) {
//       precacheImage(AssetImage(s.imageAsset), context);
//     }
//   }
//
//   @override
//   void dispose() {
//     _autoTimer?.cancel();
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AllColor.black,
//       body: Stack(
//         children: [
//           /// background slider
//           PageView.builder(
//             controller: _controller,
//             physics: const BouncingScrollPhysics(),
//             itemCount: _slides.length,
//             onPageChanged: (i) => setState(() => _index = i),
//             itemBuilder: (_, i) => _OnboardingSlide(
//               data: _slides[i],
//               index: _index,
//               total: _slides.length,
//             ),
//           ),
//
//           /// bottom white card
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: _BottomAuthCard(
//               onLogin: () {
//                 context.push(SeclectRoleScreen.routeName);
//                 debugPrint('Login tapped');
//               },
//               onSignUp: () {
//                 debugPrint('Sign Up tapped');
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// /// ---------------------------------------------------------------------------
// ///  SLIDE
// /// ---------------------------------------------------------------------------
// class _OnboardingSlide extends StatelessWidget {
//   const _OnboardingSlide({
//     required this.data,
//     required this.index,
//     required this.total,
//   });
//
//   final _SlideData data;
//   final int index;
//   final int total;
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Stack(
//       children: [
//         /// full-screen image
//         Positioned.fill(
//           bottom: 320.h,
//           child: Image.asset(
//             data.imageAsset,
//             fit: BoxFit.contain,
//           ),
//         ),
//
//         /// dark gradient overlay
//         Positioned.fill(
//           child: DecoratedBox(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [
//                   AllColor.black.withOpacity(.10),
//                   AllColor.black.withOpacity(.75),
//                   AllColor.black.withOpacity(.96),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         /// logo + title + description + dots (exactly above white card)
//         Positioned(
//           left: 0,
//           right: 0,
//
//           bottom: size.height * 0.34,
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20.w),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 // small rounded square logo
//                 Container(
//                   height: 40.r,
//                   width: 40.r,
//                   decoration: BoxDecoration(
//                     color: Colors.white10,
//                     borderRadius: BorderRadius.circular(10.r),
//                   ),
//                   clipBehavior: Clip.antiAlias,
//                   child: Center(
//                     child: Image.asset(
//                       'assets/images/on_logo.png',
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 12.h),
//                 // big title
//                 Text.rich(
//                   TextSpan(
//                     children: [
//                       TextSpan(
//                         text: '${data.titleTop}\n',
//                         style: TextStyle(
//                           fontSize: 42.sp,
//                           letterSpacing: 1.1,
//                           fontWeight: FontWeight.w700,
//                           color: AllColor.white,
//                           fontFamily: 'sf_Pro',
//                         ),
//                       ),
//                       TextSpan(
//                         text: data.titleAccent,
//                         style: TextStyle(
//                           fontSize: 42.sp,
//                           letterSpacing: 1.1,
//                           fontWeight: FontWeight.w700,
//                           color: AllColor.primary,
//                           fontFamily: 'sf_Pro',
//                         ),
//                       ),
//                     ],
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 SizedBox(height: 10.h),
//                 // description
//                 Text(
//                   data.description,
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 18.sp,
//                     color: AllColor.white.withOpacity(0.9),
//                     fontFamily: 'sf_Pro',
//                     fontWeight: FontWeight.w400,
//                     height: 1.35,
//                   ),
//                 ),
//                 SizedBox(height: 14.h),
//                 // pager dots
//                 _Pager(index: index, total: total),
//                 SizedBox(height: 14.h),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// /// ---------------------------------------------------------------------------
// ///  BOTTOM CARD
// /// ---------------------------------------------------------------------------
// class _BottomAuthCard extends StatelessWidget {
//   const _BottomAuthCard({
//     required this.onLogin,
//     required this.onSignUp,
//   });
//
//   final VoidCallback onLogin;
//   final VoidCallback onSignUp;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.only(
//         top: 30.h,
//         left: 24.w,
//         right: 24.w,
//         bottom: 30.h,
//       ),
//       decoration: BoxDecoration(
//         color: AllColor.white,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(30.r),
//           topRight: Radius.circular(30.r),
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: AllColor.black.withOpacity(.20),
//             blurRadius: 30.r,
//             offset: Offset(0, -10.h),
//           ),
//         ],
//       ),
//       child: SafeArea(
//         top: false,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             // SizedBox(height: 10.h),
//
//             // Log In button (black)
//             GlobalGetStartedButton(
//               onTap: onLogin,
//               textColor: AllColor.white,
//               color: AllColor.black,
//               buttonName: "Log In",
//             ),
//             SizedBox(height: 16.h),
//
//             // Sign Up button (outlined / default white)
//             GlobalGetStartedButton(
//               onTap: onSignUp,
//               textColor: AllColor.black,
//               buttonName: "Sign Up",
//             ),
//
//             SizedBox(height: 35.h),
//             const _LegalText(),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// /// ---------------------------------------------------------------------------
// ///  LEGAL TEXT
// /// ---------------------------------------------------------------------------
// class _LegalText extends StatelessWidget {
//   const _LegalText();
//
//   @override
//   Widget build(BuildContext context) {
//     final baseStyle = TextStyle(
//       fontSize: 16.sp,
//       color: AllColor.black.withOpacity(0.6),
//       fontFamily: 'sf_Pro',
//       fontWeight: FontWeight.w400,
//     );
//
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         // line 1
//         Text(
//           'By continuing, you agree workpleis',
//           textAlign: TextAlign.center,
//           style: baseStyle,
//         ),
//         SizedBox(height: 4.h),
//
//         // line 2 -> Privacy Policy and Terms of Use (same line)
//         Wrap(
//           alignment: WrapAlignment.center,
//           crossAxisAlignment: WrapCrossAlignment.center,
//           spacing: 4.w,
//           children: [
//             _link('Privacy Policy', () => debugPrint('Privacy tapped')),
//             Text(
//               'and',
//               style: baseStyle,
//             ),
//             _link('Terms of Use', () => debugPrint('Terms tapped')),
//           ],
//         ),
//       ],
//     );
//   }
//
//   Widget _link(String label, VoidCallback onTap) {
//     return InkWell(
//       onTap: onTap,
//       child: Text(
//         label,
//         style: TextStyle(
//           fontSize: 16.sp,
//           color: AllColor.black,
//           fontFamily: 'sf_Pro',
//           fontWeight: FontWeight.w400,
//           decoration: TextDecoration.underline,
//           decorationColor: AllColor.black,
//         ),
//       ),
//     );
//   }
// }
//
//
// /// ---------------------------------------------------------------------------
// ///  DOT PAGER
// /// ---------------------------------------------------------------------------
// class _Pager extends StatelessWidget {
//   const _Pager({required this.index, required this.total});
//
//   final int index;
//   final int total;
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: List.generate(total, (i) {
//         final bool active = i == index;
//         return AnimatedContainer(
//           duration: const Duration(milliseconds: 250),
//           margin: EdgeInsets.symmetric(horizontal: 3.w),
//           height: 6.h,
//           width: active ? 18.w : 6.w,
//           decoration: BoxDecoration(
//             color: active
//                 ? AllColor.white
//                 : AllColor.white.withOpacity(0.35),
//             borderRadius: BorderRadius.circular(20.r),
//           ),
//         );
//       }),
//     );
//   }
// }
//
// /// ---------------------------------------------------------------------------
// ///  MODEL
// /// ---------------------------------------------------------------------------
// class _SlideData {
//   final String imageAsset;
//   final String titleTop;
//   final String titleAccent;
//   final String description;
//
//   const _SlideData({
//     required this.imageAsset,
//     required this.titleTop,
//     required this.titleAccent,
//     required this.description,
//   });
// }
