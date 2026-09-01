import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vit_ap_student_app/core/models/capstone_attendance.dart';
import 'package:vit_ap_student_app/core/models/credentials.dart';
import 'package:vit_ap_student_app/core/models/semester_cache.dart';
import 'package:vit_ap_student_app/core/models/user.dart';
import 'package:vit_ap_student_app/core/providers/user_preferences_notifier.dart';
import 'package:vit_ap_student_app/core/services/analytics_service.dart';
import 'package:vit_ap_student_app/core/services/demo_service.dart';
import 'package:vit_ap_student_app/core/services/notification_service.dart';
import 'package:vit_ap_student_app/core/services/secure_store_service.dart';
import 'package:vit_ap_student_app/init_dependencies.dart';
import 'package:vit_ap_student_app/objectbox.g.dart';

part 'current_user.g.dart';

/// Copies freshly fetched data onto the [existing] row already in the box.
///
/// Every relation the app refreshes has to be listed here. One left out is not
/// a compile error — it is silently dropped on every save after the first
/// login, so the data lives in memory for the session and is gone on restart.
/// That is exactly what happened to the capstone.
@visibleForTesting
void applyRefreshedUser(User existing, User updated) {
  // ToMany relations are cleared first so a refresh replaces rather than
  // appends.
  existing.attendance
    ..clear()
    ..addAll(updated.attendance);

  existing.examSchedule
    ..clear()
    ..addAll(updated.examSchedule);

  existing.marks
    ..clear()
    ..addAll(updated.marks);

  existing.profile.target = updated.profile.target;
  existing.timetable.target = updated.timetable.target;
  existing.capstoneAttendance.target = updated.capstoneAttendance.target;
}

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
      await serviceLocator.get<SecureStorageService>().saveCredentials(
        credentials,
      );

      final prefs = ref.read(userPreferencesProvider);
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
      _clearUserDataObjectBox();
      throw Exception('Login failed: $e');
    }
  }

  // Update user in state and ObjectBox
  Future<void> updateUser(User updatedUser) async {
    try {
      // Preserve the existing ID when updating
      final userWithId = state?.id != null
          ? updatedUser.copyWith(id: state!.id)
          : updatedUser;

      state = userWithId;
      _saveUserToObjectBox(userWithId);

      // Reschedule notifications with updated user data
      final prefs = ref.read(userPreferencesProvider);
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
      debugPrint('Failed to update user data: $e');
      throw Exception('Failed to update user data: $e');
    }
  }

  Future<void> logout() async {
    try {
      // Clear user state and storage
      state = null;
      _clearUserDataObjectBox();

      // Exit demo mode (no-op for normal accounts) so a subsequent real login
      // is not treated as a demo session.
      await DemoService.instance.setDemoMode(false);

      // Remove credentials
      await serviceLocator.get<SecureStorageService>().clearCredentials();

      // Drop the analytics identity so the next account on a shared device
      // does not inherit this student's cohort properties.
      await ref.read(analyticsServiceProvider).reset();

      // Clear Notifications
      await NotificationService.cancelAllNotifications();
    } catch (e) {
      throw Exception('Logout failed: $e');
    }
  }

  Future<Credentials?> getSavedCredentials() async {
    return await serviceLocator.get<SecureStorageService>().getCredentials();
  }

  Future<void> updateSavedCredentials({
    required Credentials newCredentials,
  }) async {
    return await serviceLocator.get<SecureStorageService>().saveCredentials(
      newCredentials,
    );
  }

  // Manually save user
  void _saveUserToObjectBox(User user) {
    debugPrint('Data saved: ${user.toString()}');
    final store = serviceLocator.get<Store>();
    final userBox = store.box<User>();

    // Check if we're updating an existing user or creating a new one
    if (user.id != null && user.id! > 0) {
      // For existing users, get the stored version and selectively update
      final existingUser = userBox.get(user.id!);
      if (existingUser != null) {
        // Replacing a ToOne leaves the old row behind: ObjectBox does not
        // cascade a delete through one. For the capstone that is a row plus one
        // per day of the punch calendar, so it is cleared before repointing.
        _removeCapstone(store, existingUser.capstoneAttendance.target);

        applyRefreshedUser(existingUser, user);

        // Save the updated user (this will assign proper IDs to all entities)
        userBox.put(existingUser);
        debugPrint('Updated existing user with ID: ${existingUser.id}');
      } else {
        // Fallback: if existing user not found, create new
        final newId = userBox.put(user);
        debugPrint('Created new user with ID: $newId');
      }
    } else {
      // For new users, clear existing data and create fresh
      userBox.removeAll();
      final newId = userBox.put(user);
      debugPrint('New user created with ID: $newId');
      // Update state with the new ID
      state = state?.copyWith(id: newId);
    }
  }

  /// Deletes a capstone and its punch calendar.
  ///
  /// Called before the relation is repointed at freshly fetched data, so the
  /// unlinked rows do not accumulate one calendar per refresh.
  void _removeCapstone(Store store, CapstoneAttendance? capstone) {
    if (capstone == null) return;

    final punchIds = capstone.punches
        .map((punch) => punch.id)
        .whereType<int>()
        .toList();
    if (punchIds.isNotEmpty) {
      store.box<CapstonePunch>().removeMany(punchIds);
    }

    final id = capstone.id;
    if (id != null) {
      store.box<CapstoneAttendance>().remove(id);
    }
  }

  // Manually clear user data
  void _clearUserDataObjectBox() {
    serviceLocator.get<Store>().box<User>().removeAll();

    // Clear semester cache
    serviceLocator.get<Store>().box<SemesterCache>().removeAll();
  }

  bool get isLoggedIn => state != null;
}
