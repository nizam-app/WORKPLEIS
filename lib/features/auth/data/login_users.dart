import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workpleis/core/constants/api_control/auth_api.dart';

class LoginService {
  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse(AuthAPIController.login);

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200 && data["status"] == "Success") {
      final prefs = await SharedPreferences.getInstance();

      // 🔹 Save token, email, role, id
      await prefs.setString("token", data["data"]["token"] ?? "");
      await prefs.setString("email", data["data"]["user"]["email"] ?? "");
      await prefs.setString("role", data["data"]["user"]["role"] ?? "");
      await prefs.setString("userId", data["data"]["user"]["_id"] ?? "");
      


      return {
        "success": true,
        "message": data['message'] ?? "Login success",
        "token": data["data"]["token"],
        "email": data["data"]["user"]["email"],
        "role": data["data"]["user"]["role"],
        "id": data["data"]["user"]["_id"],
        "user": data["data"]["user"],
      };
    } else {
      return {
        "success": false,
        "message": data["message"] ?? "Login failed",
      };
    }
  }
}