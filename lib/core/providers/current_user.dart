import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vit_ap_student_app/core/models/user.dart';

part 'current_user.g.dart';

@Riverpod(keepAlive: true)
class CurrentUserNotifier extends _$CurrentUserNotifier {
  @override
  User? build() => null;

  void setUser(User user) {
    state = user;
  }

  void clearUser() {
    state = null;
  }

  bool get isLoggedIn => state != null;
}
