import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vit_ap_student_app/core/models/credentials.dart';
import 'package:vit_ap_student_app/core/models/user.dart';
import 'package:objectbox/objectbox.dart';
import 'package:vit_ap_student_app/core/providers/user_preferences_notifier.dart';
import 'package:vit_ap_student_app/core/services/notification_service.dart';
import 'package:vit_ap_student_app/core/services/secure_store_service.dart';
import 'package:vit_ap_student_app/init_dependencies.dart';
import 'package:vit_ap_student_app/objectbox.g.dart';

part 'current_user.g.dart';

@Riverpod(keepAlive: true)
class CurrentUserNotifier extends _$CurrentUserNotifier {
  @override
  User? build() {
    // Load cached user from ObjectBox with proper ordering
    final store = serviceLocator.get<Store>();
    return store.box<User>().query().order(User_.id).build().findFirst();
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
      // Preserve the existing ID when updating
      final userWithId =
          state?.id != null ? updatedUser.copyWith(id: state!.id) : updatedUser;

      state = userWithId;
      _saveUserToObjectBox(userWithId);

      // Reschedule notifications with updated user data
      final prefs = ref.read(userPreferencesNotifierProvider);
      await NotificationService.cancelAllNotifications();
      await NotificationService.scheduleTimetableNotifications(
        user: userWithId,
        prefs: prefs,
      );
      await NotificationService.scheduleExamNotifications(
        user: userWithId,
        prefs: prefs,
      );
    } catch (e) {
      debugPrint("Failed to update user data: $e");
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
    debugPrint("Data saved: ${user.toString()}");
    final box = serviceLocator.get<Store>().box<User>();

    // Check if we're updating an existing user or creating a new one
    if (user.id != null && user.id! > 0) {
      // Update existing user
      final newId = box.put(user, mode: PutMode.put);
      debugPrint("Updated user with ID: $newId");
    } else {
      // For new users, clear existing data and create fresh
      box.removeAll();
      final newId = box.put(user, mode: PutMode.put);
      debugPrint("New user created with ID: $newId");
      // Update state with the new ID
      state = state?.copyWith(id: newId);
    }
  }

  // Manually clear user
  void _clearUserFromObjectBox() {
    serviceLocator.get<Store>().box<User>().removeAll();
  }

  bool get isLoggedIn => state != null;
}
