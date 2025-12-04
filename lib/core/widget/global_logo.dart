import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GlobalLogo extends StatelessWidget {
  const GlobalLogo({super.key,
    //this.width = 220,
    this.height = 85,
    this.image = "assets/images/goloballogo.png"});
  //final double width ;
  final double height ;
  final String image;


  @override
  Widget build(BuildContext context) {
    return  Image.asset(
          image,
       //   width: width.w,
          height: height.h,
          fit: BoxFit.cover,
        );
  }
}