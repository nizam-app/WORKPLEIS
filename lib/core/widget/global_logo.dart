import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GlobalLogo extends StatelessWidget {
  const GlobalLogo({super.key,  this.width = 200, this.height = 200});
  final double width ;
  final double height ;


  @override
  Widget build(BuildContext context) {
    return  SvgPicture.asset(
          "assets/images/workpleis.svg",
          width: width.w,
          height: height.h,
          fit: BoxFit.contain,
        );
  }
}
