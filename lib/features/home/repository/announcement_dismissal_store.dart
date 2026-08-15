import 'package:shared_preferences/shared_preferences.dart';

/// Which announcements this device has swiped away.
///
/// Kept in [SharedPreferences] rather than on the `UserPreferences` ObjectBox
/// entity: this is throwaway local state, and adding a property to a shipping
/// entity means a schema migration for something that does not deserve one.
class AnnouncementDismissalStore {
  const AnnouncementDismissalStore();

  static const String _key = 'dismissed_announcement_ids';

  Future<Set<String>> read() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return (prefs.getStringList(_key) ?? const <String>[]).toSet();
  }

  Future<void> write(Set<String> ids) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_key, ids.toList());
  }
}
