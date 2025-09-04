import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/login_users.dart';

final loginProvider = Provider<LoginService>((ref) => LoginService());
final loginLoadingProvider = StateProvider<bool>((ref) => false);
