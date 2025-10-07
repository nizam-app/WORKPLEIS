import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🔹 Controller
class BoolController extends StateNotifier<bool> {
  BoolController() : super(false); // initial value = false

  void toggle() => state = !state; // true ↔ false
  void setTrue() => state = true;
  void setFalse() => state = false;
}

// 🔹 Provider
final boolControllerProvider =
StateNotifierProvider<BoolController, bool>((ref) {
  return BoolController();
});
void checkForBusiness(WidgetRef ref, String value) {
  final controller = ref.read(boolControllerProvider.notifier);
  if (value.toLowerCase().contains('business')) {
    controller.setTrue();
  } else {
    controller.setFalse();
  }
}
