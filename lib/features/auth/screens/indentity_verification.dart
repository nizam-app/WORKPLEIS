import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/core/widget/global_bottom.dart';
import 'package:workpleis/features/auth/screens/address_and_password.dart';

class IndentityVerification extends StatelessWidget {
  const IndentityVerification({super.key});

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
                  "Upload a clear photo of the front and back of your \n government-issued ID to complete verification",
                  textAlign: TextAlign.center,
                  style:theme.titleMedium,
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

class CustomChooseFile extends StatelessWidget {
  const CustomChooseFile({super.key, this.title = 'Front Side', this.onTap});

  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// ---- Title ----
        Padding(
          padding: EdgeInsets.only(bottom: 8.h),
          child: Text(
            title,
            style: TextStyle(
              color: AllColor.borderColor, // soft purple-gray
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              fontFamily: "bodyFont",
            ),
          ),
        ),

        /// ---- Upload Box ----
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            height: 140.h,
            decoration: BoxDecoration(
              color: const Color(0xFFF7F6FB), // soft lavender background
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: const Color(0xFFD1CCE1), // dotted look
                width: 1,
                style: BorderStyle.solid,
              ),
            ),
            child: DottedBorderOverlay(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.upload_outlined,
                    size: 28.sp,
                    color: const Color(0xFF8A7CA8),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    'Choose files or drag and drop',
                    style: TextStyle(
                      color: AllColor.borderColor.withOpacity(0.6),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily: "bodyFont",
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Only jpg or png file type accepted',
                    style: TextStyle(
                      color: AllColor.borderColor.withOpacity(0.6),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      fontFamily: "bodyFont",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
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
