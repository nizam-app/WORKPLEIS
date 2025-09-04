import 'global_api.dart';

class AuthAPIController {
 static String _base_api = "$api/api";
  static String register = "${_base_api}/v1/user/register";
  static String login = "${_base_api}/v1/auth/login";
}
