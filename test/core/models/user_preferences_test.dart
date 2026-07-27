import 'package:flutter_test/flutter_test.dart';
import 'package:vit_ap_student_app/core/models/user_preferences.dart';

/// The analytics opt-in is stored as a nullable bool specifically so that
/// ObjectBox's backfill of `false` into rows written before the property
/// existed cannot silently opt out the whole existing user base on upgrade.
void main() {
  test('analytics defaults to enabled when never chosen', () {
    expect(UserPreferences().isAnalyticsEnabled, isNull);
    expect(UserPreferences().analyticsEnabled, isTrue);
  });

  test('an explicit opt-out is honoured', () {
    final prefs = UserPreferences().copyWith(isAnalyticsEnabled: false);
    expect(prefs.analyticsEnabled, isFalse);
  });

  test('an explicit opt-in is honoured', () {
    final prefs = UserPreferences().copyWith(isAnalyticsEnabled: true);
    expect(prefs.analyticsEnabled, isTrue);
  });

  test('copyWith preserves the choice when the field is omitted', () {
    final optedOut = UserPreferences().copyWith(isAnalyticsEnabled: false);
    expect(optedOut.copyWith(fontScale: 1.2).analyticsEnabled, isFalse);
  });
}
