// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:go_router/go_router.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:workpleis/core/constants/color_control/all_color.dart';
// import 'package:workpleis/core/widget/global_aleart_box.dart';
// import 'package:workpleis/core/widget/global_app_bar.dart';
// import 'package:workpleis/core/widget/global_get_started_button.dart';
// import 'package:workpleis/features/auth/widgets/custom_label_text.dart';
// import 'package:workpleis/features/home/screen/client_home_screen.dart';
// import 'package:workpleis/features/home/screen/service_home_screen.dart';
//
// class AddPaymentMethodScreen extends StatelessWidget {
//   const AddPaymentMethodScreen({super.key});
//
//   static const routeName = '/AddPaymentMethodScreen';
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: GlobalAppbar(text: "Add Payment Method"),
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 22.w),
//           child: Column(
//             children: [
//               SizedBox(height: 60.h),
//
//               CustomPaymentText(title: "Account Name"),
//               TextFormField(
//                 decoration: const InputDecoration(
//                   hintText: 'Type your Account Name',
//                 ),
//               ),
//               SizedBox(height: 25.h),
//
//               CustomPaymentText(title: "Routing number"),
//               TextFormField(
//                 decoration: const InputDecoration(
//                   hintText: 'Type your Routing number',
//                 ),
//               ),
//               SizedBox(height: 25.h),
//
//               CustomPaymentText(title: "Account number"),
//               TextFormField(
//                 decoration: const InputDecoration(
//                   hintText: 'Type your Account number',
//                 ),
//               ),
//               const Spacer(),
//
//               GlobalGetStartedButton(
//                 onTap: () async {
//                   final prefs = await SharedPreferences.getInstance();
//                   final role = prefs.getString('userRole'); // 'client' or 'service'
//
//                   /// ✅ প্রথমে alert দেখাও
//                   globalShowAlertDialog(
//                     context: context,
//                     oneTap: () async {
//                       /// 🔹 dialog বন্ধ করো
//                       Navigator.of(context).pop();
//
//                       /// 🔹 তারপর navigation করো
//                       await Future.delayed(const Duration(milliseconds: 100));
//
//                       if (role == 'client') {
//                         context.go(HomeScreen.routeName);
//                       } else if (role == 'service') {
//                         context.go(ServiceHomeScreen.routeName);
//                       } else {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(content: Text("User role not found")),
//                         );
//                       }
//                     },
//                   );
//                 },
//                 color: AllColor.primary,
//                 buttonName: "Add",
//               ),
//
//               SizedBox(height: 40.h),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/core/widget/global_aleart_box.dart';
import 'package:workpleis/core/widget/global_app_bar.dart';
import 'package:workpleis/core/widget/global_get_started_button.dart';
import 'package:workpleis/features/auth/widgets/custom_label_text.dart';
import 'package:workpleis/features/home/screen/Service_home_screen.dart';
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
              SizedBox(height: 60.h),
              CustomPaymentText(title: "Account Name"),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'type your Account Name',
                ),
              ),
              SizedBox(height: 25.h),
              CustomPaymentText(title: "Routing number"),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'type your Routing number',
                ),
              ),
              SizedBox(height: 25.h),
              CustomPaymentText(title: "Account number"),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'type your Account number',
                ),
              ),
              Spacer(),
              GlobalGetStartedButton(
                onTap: () {
                  globalShowAlertDialog(context: context, oneTap: () {loginDone(context);});
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
  void loginDone(BuildContext context) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? _checkClient = _prefs.getString("role");

    if (_checkClient == null) {
      throw Exception("Role not found");
    } else {
      if (_checkClient == "client") {
        context.push(HomeScreen.routeName);
      } else if (_checkClient == "provider") {
        context.push(ServiceHomeScreen.routeName);
      } else {
        context.push(HomeScreen.routeName);
      }
    }
  }
}
