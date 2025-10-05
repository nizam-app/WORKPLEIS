import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/core/widget/global_aleart_box.dart';
import 'package:workpleis/core/widget/global_app_bar.dart';
import 'package:workpleis/core/widget/global_get_started_button.dart';
import 'package:workpleis/features/auth/widgets/custom_label_text.dart';

class AddPaymentMethodScreen extends StatelessWidget {
  const AddPaymentMethodScreen({super.key});

  static const routeName = '/AddPaymentMethodScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppbar(text: "Add Payment Method"),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.w),
          child: Column(
            children: [
              SizedBox(height: 60.h),
              CustomLabelText(title: "Account Name"),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'type your Account Name',
                ),
              ),
              SizedBox(height: 25.h),
              CustomLabelText(title: "Routing number"),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'type your Routing number',
                ),
              ),
              SizedBox(height: 25.h),
              CustomLabelText(title: "Account number"),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'type your Account number',
                ),
              ),
              Spacer(),
              GlobalGetStartedButton(
                onTap: () {
                  globalShowAlertDialog(context: context, oneTap: () {});
                },
                color: AllColor.primary,
                buttonName: "Add",
              ),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }
}
