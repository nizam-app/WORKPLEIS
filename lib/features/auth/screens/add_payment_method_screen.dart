
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/core/widget/global_aleart_box.dart';
import 'package:workpleis/core/widget/global_app_bar.dart';
import 'package:workpleis/core/widget/global_get_started_button.dart';
import 'package:workpleis/features/auth/widgets/custom_label_text.dart';
import 'package:workpleis/features/home/screen/service_home_screen.dart';
import 'package:workpleis/features/home/screen/client_home_screen.dart';

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
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 50.h),
                      /// Account Name
                      CustomPaymentText(title: "Account Name"),
                      TextFormField(
                        style: TextStyle(
                          color: AllColor.black,
                          fontFamily: "OpenText",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Type your Account Name',
                        ),
                      ),
                      SizedBox(height: 25.h),

                      /// Routing Number
                      CustomPaymentText(title: "Routing Number"),
                      TextFormField(
                        style: TextStyle(
                          color: AllColor.black,
                          fontFamily: "OpenText",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Type your Routing Number',
                        ),
                      ),
                      SizedBox(height: 25.h),

                      /// Account Number
                      CustomPaymentText(title: "Account Number"),
                      TextFormField(
                        style: TextStyle(
                          color: AllColor.black,
                          fontFamily: "OpenText",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Type your Account Number',
                        ),
                      ),
                      SizedBox(height: 40.h),
                    ],
                  ),
                ),
              ),

              /// Add Button
              GlobalGetStartedButton(
                onTap: () {
                  globalShowAlertDialog(
                    context: context,
                    oneTap: () {
                      loginDone(context);
                    },
                  );
                },
                color: AllColor.bgcolor,
                buttonName: "Add",
                textColor: AllColor.borderColor,
              ),

              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> loginDone(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final role = prefs.getString("role");

    if (role == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User role not found")),
      );
      return;
    }

    if (role == "client") {
      context.push(HomeScreen.routeName);
    } else if (role == "provider") {
      context.push(ServiceHomeScreen.routeName);
    } else {
      context.push(HomeScreen.routeName);
    }
  }
}

