import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// User model-like structure store korte ekta map use korলাম
class UserPrefsNotifier extends AsyncNotifier<Map<String, String?>> {
  @override
  Future<Map<String, String?>> build() async {
    final prefs = await SharedPreferences.getInstance();

    return {
      "token": prefs.getString("token"),
      "email": prefs.getString("email"),
      "userId": prefs.getString("userId"),
      "role": prefs.getString("role"),
    };
  }

  /// Save User Info (login/register er pore call korো)
  Future<void> saveUser({
    required String token,
    required String email,
    required String userId,
    required String role,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", token);
    await prefs.setString("email", email);
    await prefs.setString("userId", userId);
    await prefs.setString("role", role);

    state = AsyncData({
      "token": token,
      "email": email,
      "userId": userId,
      "role": role,
    });
  }

  /// Clear User Info (logout er somoy call korো)
  Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    state = const AsyncData({
      "token": null,
      "email": null,
      "userId": null,
      "role": null,
    });
  }
}

/// Riverpod Provider
final userPrefsProvider =
AsyncNotifierProvider<UserPrefsNotifier, Map<String, String?>>(
      () => UserPrefsNotifier(),
);