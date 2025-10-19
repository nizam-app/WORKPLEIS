import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';


import '../../features/nav_bar/logic/botton_nav_bar_controller.dart';

class GlobalAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String text;

  const GlobalAppbar({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xff686382) , // dark color like screenshot
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: Padding(
        padding:  EdgeInsets.only(left: 20.w),
        child: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20.sp,
            color: AllColor.white,
          ),
          onPressed: () {
           context.pop();
          },
        ),
      ),
      centerTitle: true,
      title: Text(
        text,
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
          color: AllColor.white,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.h);
}
