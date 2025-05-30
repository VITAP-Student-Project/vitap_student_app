import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vit_ap_student_app/core/models/credentials.dart';
import 'package:vit_ap_student_app/core/models/user.dart';
import 'package:objectbox/objectbox.dart';
import 'package:vit_ap_student_app/core/providers/user_preferences_notifier.dart';
import 'package:vit_ap_student_app/core/services/notification_service.dart';
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

      final prefs = ref.read(userPreferencesNotifierProvider);
      await NotificationService.scheduleTimetableNotifications(
        user: user,
        prefs: prefs,
      );
      await NotificationService.scheduleExamNotifications(
        user: user,
        prefs: prefs,
      );
    } catch (e) {
      state = null;
      _clearUserFromObjectBox();
      throw Exception('Login failed: $e');
    }
  }

  // Update user in state and ObjectBox
  Future<void> updateUser(User updatedUser) async {
    try {
      state = updatedUser;
      _saveUserToObjectBox(updatedUser);

      // Reschedule notifications with updated user data
      final prefs = ref.read(userPreferencesNotifierProvider);
      await NotificationService.cancelAllNotifications();
      await NotificationService.scheduleTimetableNotifications(
        user: updatedUser,
        prefs: prefs,
      );
      await NotificationService.scheduleExamNotifications(
        user: updatedUser,
        prefs: prefs,
      );
    } catch (e) {
      throw Exception('Failed to update user data: $e');
    }
  }

  Future<void> logout() async {
    try {
      // Clear user state and storage
      state = null;
      _clearUserFromObjectBox();

      // Remove credentials
      await serviceLocator.get<SecureStorageService>().clearCredentials();

      // Clear Notifications
      await NotificationService.cancelAllNotifications();
    } catch (e) {
      throw Exception('Logout failed: $e');
    }
  }

  Future<Credentials?> getSavedCredentials() async {
    return await serviceLocator.get<SecureStorageService>().getCredentials();
  }

  Future<void> updateSavedCredentials(
      {required Credentials newCredentials}) async {
    return await serviceLocator
        .get<SecureStorageService>()
        .saveCredentials(newCredentials);
  }

  // Manually save user
  void _saveUserToObjectBox(User user) {
    final box = serviceLocator.get<Store>().box<User>();
    box.removeAll();
    box.put(user, mode: PutMode.put);
  }

  // Manually clear user
  void _clearUserFromObjectBox() {
    serviceLocator.get<Store>().box<User>().removeAll();
  }

  bool get isLoggedIn => state != null;
}
