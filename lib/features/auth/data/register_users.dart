import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:workpleis/core/widget/global_snack_bar.dart';

import '../../../core/constants/api_control/auth_api.dart';
import '../screens/login_screen.dart';

Future<void> registerUsers({
  required BuildContext context,
  String? name,
  required String email,
  required String password,
  required String confirmPassword,
  required String role, // 🔹 role যোগ হলো
}) async {
  final url = Uri.parse(AuthAPIController.register);

  try {
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "name": name,
        "email": email,
        "password": password,
        "password_confirmation": confirmPassword,
        "role": role, // 🔹 backend এ পাঠানো হলো
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
     GlobalSnackBar.show(context, title: "Success", message: "User created successfully");
      context.push(LoginScreen.routeName);
    } else {
     GlobalSnackBar.show(context, title: "Error", message: "Something went wrong", type: CustomSnackType.error);
    }
  } catch (e) {
    GlobalSnackBar.show(context, title: "Error", message: "Something went wrong", type: CustomSnackType.error);
  }
}
