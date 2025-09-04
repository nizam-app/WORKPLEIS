import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workpleis/core/constants/image_control/image_path.dart';

import '../../../core/constants/color_control/all_color.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const routeName = '/homeScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: CustomTopBar(),
    );
  }
}

class CustomTopBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor:  AllColor.appBar, // dark background
      elevation: 0,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 🔹 Left Menu Icon
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.view_headline_rounded, color: AllColor.white),
          ),

          // 🔹 Center Logo (Workpleis Image)
          Expanded(
            child: Center(
              child: Image.asset(
                ImagePath.logoColorText, // তোমার Workpleis logo image path
                height: 30.h,
                fit: BoxFit.contain,
              ),
            ),
          ),

          // 🔹 Right Icons
          Row(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.notifications_none,
                        color: AllColor.white),
                  ),
                  Positioned(
                    right: 10,
                    top: 10,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AllColor.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                  )
                ],
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.chat_bubble_outline, color: AllColor.white),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.h);
}
