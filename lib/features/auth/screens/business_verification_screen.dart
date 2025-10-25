import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/widget/global_bottom.dart';
import 'package:workpleis/features/auth/screens/address_and_password.dart';
import 'package:workpleis/features/auth/screens/bisiness_password_screen.dart';
import 'package:workpleis/features/auth/widgets/custom_choose_file.dart';

import '../../../core/constants/color_control/all_color.dart';

class BusinessVerificationScreen extends StatelessWidget {
  const BusinessVerificationScreen({super.key});

  static final routeName = "/businessVerificationScreen";

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
                Text("Verify Your Business", style: TextStyle(fontFamily:"headFont", fontWeight: FontWeight.w800, fontSize: 20.sp,color: AllColor.black)),
                SizedBox(height: 8.h),
                Text(
                  "Upload a clear photo of any of your business \n"
                  " documents listed below.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14.sp,  fontFamily:"OpenText", fontWeight: FontWeight.w400, color: AllColor.levelText),
                ),
                SizedBox(height: 30.h),
                BusinessDocumentsList(),
                SizedBox(height: 30.h),
                const CustomChooseFile(title: "Document"),
                SizedBox(height: 25.h),
                GlobalButton(
                  text: "Submit",
                  onPressed: () {
                    context.push(BusinessPasswordScreen.routeName);
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



class BusinessDocumentsList extends StatelessWidget {
  const BusinessDocumentsList({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
      color: Colors.black,
      height: 1.5,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBulletItem(
          context,
          'Certificate of Assumed Name; Business License',
          textStyle,
        ),
        _buildBulletItem(
          context,
          'Sales/Use Tax License',
          textStyle,
        ),
        _buildBulletItem(
          context,
          'Registration of Trade Name',
          textStyle,
        ),
        _buildBulletItem(
          context,
          'EIN Documentation (IRS-Issued SS4 Confirmation Letter)',
          textStyle,
        ),
      ],
    );
  }

  Widget _buildBulletItem(
      BuildContext context, String text, TextStyle? textStyle) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text(
            '• ',
            style: TextStyle(fontSize: 18.sp),
          ),
          Expanded(
            child: Text(
              text,
              style: textStyle,
            ),
          ),
        ],
      ),
    );
  }
}
