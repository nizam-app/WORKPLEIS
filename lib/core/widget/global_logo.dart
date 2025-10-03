import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GlobalLogo extends StatelessWidget {
  const GlobalLogo({super.key,  this.width = 250, this.height = 50});
  final double width ;
  final double height ;


  @override
  Widget build(BuildContext context) {
    return  Image.asset(
          "assets/images/workpleis.png",
          width: width.w,
          height: height.h,
          fit: BoxFit.cover,
        );
  }
}
