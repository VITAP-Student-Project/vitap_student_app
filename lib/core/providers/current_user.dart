import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vit_ap_student_app/core/models/credentials.dart';
import 'package:vit_ap_student_app/core/models/user.dart';
import 'package:objectbox/objectbox.dart';
import 'package:vit_ap_student_app/core/services/secure_store_service.dart';
import 'package:vit_ap_student_app/init_dependencies.dart';

part 'current_user.g.dart';

@Riverpod(keepAlive: true)
class CurrentUserNotifier extends _$CurrentUserNotifier {
  @override
  User? build() {
    // Load cached user from ObjectBox
    final store = serviceLocator.get<Store>();
    return store.box<User>().query().build().findFirst();
  }

  Future<void> loginUser(User user, Credentials credentials) async {
    try {
      // Save user to state and ObjectBox
      state = user;
      _saveUserToObjectBox(user);

      // Save credentials
      await serviceLocator
          .get<SecureStorageService>()
          .saveCredentials(credentials);
    } catch (e) {
      // Rollback on failure
      state = null;
      _clearUserFromObjectBox();
      throw Exception('Login failed: $e');
    }
  }

  Future<void> logout() async {
    try {
      // Clear user state and storage
      state = null;
      _clearUserFromObjectBox();

      // Remove credentials
      await serviceLocator.get<SecureStorageService>().clearCredentials();
    } catch (e) {
      throw Exception('Logout failed: $e');
    }
  }

  Future<Credentials?> getSavedCredentials() async {
    return await serviceLocator.get<SecureStorageService>().getCredentials();
  }

  // Existing ObjectBox methods
  void _saveUserToObjectBox(User user) {
    final box = serviceLocator.get<Store>().box<User>();
    box.removeAll();
    box.put(user, mode: PutMode.insert);
  }

  void _clearUserFromObjectBox() {
    serviceLocator.get<Store>().box<User>().removeAll();
  }

  bool get isLoggedIn => state != null;
}
