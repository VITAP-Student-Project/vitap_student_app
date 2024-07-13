// login_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'login_notifier.dart';
import '../../utils/state/login_state.dart';

final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>((ref) {
  return LoginNotifier();
});
