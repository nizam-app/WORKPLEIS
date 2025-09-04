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

    if (response.statusCode == 200){
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("token", data["data"]["token"] ?? "");
      await prefs.setString("email", email);
      Logger().d(data['message']);

      return {"success": true, "message": data['message']};
    } else {
      return {"success": false, "message": data["message"] ?? "Login failed"};
    }
  }
}
