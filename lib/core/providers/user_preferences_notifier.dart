import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:objectbox/objectbox.dart';
import 'package:vit_ap_student_app/core/models/user_preferences.dart';
import 'package:vit_ap_student_app/core/providers/current_user.dart';
import 'package:vit_ap_student_app/core/services/notification_service.dart';
import 'package:vit_ap_student_app/init_dependencies.dart';

part 'user_preferences_notifier.g.dart';

@Riverpod(keepAlive: true)
class UserPreferencesNotifier extends _$UserPreferencesNotifier {
  @override
  UserPreferences build() {
    // Load cached user preferences from ObjectBox
    final store = serviceLocator.get<Store>();
    return store.box<UserPreferences>().query().build().findFirst() ??
        UserPreferences();
  }

  Future<void> updatePreferences(UserPreferences newPreferences) async {
    try {
      final store = serviceLocator.get<Store>();
      final box = store.box<UserPreferences>();
      final existing = box.query().build().findFirst();
      if (existing != null) {
        newPreferences.id = existing.id;
      }
      box.put(newPreferences);
      state = newPreferences;

      final user = ref.read(currentUserNotifierProvider);
      if (user != null) {
        // Cancel all notifications first
        await NotificationService.cancelAllNotifications();

        // Reschedule timetable notifications if enabled
        if (newPreferences.isTimetableNotificationsEnabled) {
          await NotificationService.scheduleTimetableNotifications(
            user: user,
            prefs: newPreferences,
          );
        }

        // Reschedule exam notifications if enabled
        if (newPreferences.isExamScheduleNotificationEnabled) {
          await NotificationService.scheduleExamNotifications(
            user: user,
            prefs: newPreferences,
          );
        }
      }
    } catch (e) {
      throw Exception('Failed to update preferences: $e');
    }
  }

  // Manually clear user preferences
  void clearUserPreferences() {
    serviceLocator.get<Store>().box<UserPreferences>().removeAll();
  }
}
