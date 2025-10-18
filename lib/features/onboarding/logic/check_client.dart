import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final roleProvider = StateProvider<String?>((_) => null);

Future<void> saveRole(WidgetRef ref, String role) async {
  final p = await SharedPreferences.getInstance();
  await p.setString('role', role);
  ref.read(roleProvider.notifier).state = role; // use elsewhere
}

// optional: load at app start
final loadRoleProvider = FutureProvider((ref) async {
  final p = await SharedPreferences.getInstance();
  final r = p.getString('role');
  ref.read(roleProvider.notifier).state = r;
  return r;
});