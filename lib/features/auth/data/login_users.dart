import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:workpleis/core/constants/api_control/auth_api.dart';

class LoginService {
  final String baseUrl = AuthAPIController.login;
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse(baseUrl);

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );

    if (response.statusCode == 200) {
      return {
        "success": true,
        "data": jsonDecode(response.body),
      };
    } else {
      return {
        "success": false,
        "message": response.body,
      };
    }
  }
}
