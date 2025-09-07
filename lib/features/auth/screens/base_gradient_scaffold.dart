import 'package:flutter/material.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';

class BaseGradientScaffold extends StatelessWidget {
  final Widget child;

  const BaseGradientScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AllColor.lime,
              AllColor.darkLime,
            ],
          ),
        ),
        child: child,
      ),
    );
  }
}
