// prefs + riverpod (short)
// file: logic/check_business_prefs.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kCheckBusiness = 'checkBisness'; // <-- key as requested
final checkBusinessP = StateProvider<String?>((_) => null);

Future<void> saveCheckBusiness(WidgetRef ref, String v) async {
  final p = await SharedPreferences.getInstance();
  await p.setString(_kCheckBusiness, v);           // replace same key
  ref.read(checkBusinessP.notifier).state = v;      // use anywhere
}

final loadCheckBusinessP = FutureProvider((ref) async {
  final p = await SharedPreferences.getInstance();
  ref.read(checkBusinessP.notifier).state = p.getString(_kCheckBusiness);
});