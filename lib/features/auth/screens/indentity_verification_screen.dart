import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/core/widget/global_bottom.dart';
import 'package:workpleis/features/auth/screens/address_and_password.dart';
import 'package:workpleis/features/auth/widgets/custom_choose_file.dart';

class IndentityVerificationScreen extends StatelessWidget {
  const IndentityVerificationScreen({super.key});

  static final routeName = "/identityVerification";

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Center(
            child: Column(
              children: [
                Spacer(),
                Text(
                  "Verify Your Identity",
                  style: theme.headlineLarge
                ),
                SizedBox(height: 8.h),
                Text(
                  "Upload a clear photo of the front and back of \n your government-issued ID to complete verification",
                  textAlign: TextAlign.center,
                  style:theme.titleMedium!.copyWith(fontSize:14.sp ),
                ),
                SizedBox(height: 30.h),
                const CustomChooseFile(),
                SizedBox(height: 20.h),
                const CustomChooseFile(title: "Back Side"),
                SizedBox(height: 25.h),
                GlobalButton(
                  text: "Submit",
                  onPressed: () {
                    context.push(AddressAndPassword.routeName);
                  },
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



/// Simple overlay for dotted border look
class DottedBorderOverlay extends StatelessWidget {
  const DottedBorderOverlay({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return CustomPaint(painter: _DashedBorderPainter(), child: child);
        },
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  final Paint _paint;

  _DashedBorderPainter()
    : _paint = Paint()
        ..color = const Color(0xFFD1CCE1)
        ..strokeWidth = 1
        ..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    const dashWidth = 5.0;
    const dashSpace = 4.0;
    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          const Radius.circular(12),
        ),
      );

    final pathMetrics = path.computeMetrics();
    for (final metric in pathMetrics) {
      double distance = 0;
      while (distance < metric.length) {
        final next = distance + dashWidth;
        canvas.drawPath(metric.extractPath(distance, next), _paint);
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
