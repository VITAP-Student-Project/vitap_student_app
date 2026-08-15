/// Canonical catalogue of the custom analytics events and parameters the app
/// emits.
///
/// Firebase caps an app at 500 distinct event names and 50 registered custom
/// dimensions, and both limits are permanent — a typo'd literal burns a slot
/// forever. Every `logEvent` call site goes through these constants so a typo
/// is a compile error instead of a silent new event.
///
/// Rules for adding one:
/// - Event names: <= 40 chars, snake_case, must start with a letter, and must
///   not collide with a Firebase reserved name (`app_update`, `session_start`,
///   `user_engagement`, `first_open`, `notification_receive`, ...).
/// - Prefer an existing event with a discriminating parameter over a new name.
/// - Never put free text, file names, ids, or anything a person typed into a
///   parameter — see [AnalyticsService.logEvent] for the sanitisation contract.
library;

/// Custom event names. Firebase's own `screen_view`, `login`, `session_start`
/// and `user_engagement` are emitted by the SDK or by dedicated
/// [AnalyticsService] methods and deliberately have no entry here.
abstract final class AnalyticsEvents {
  // Auth
  static const String loginAttempt = 'login_attempt';
  static const String loginSuccess = 'login_success';
  static const String loginFailed = 'login_failed';
  static const String logout = 'logout';
  static const String semesterFetchAttempt = 'semester_fetch_attempt';
  static const String semesterFetchSuccess = 'semester_fetch_success';
  static const String semesterFetchFailed = 'semester_fetch_failed';

  // Sync
  static const String syncStarted = 'sync_started';
  static const String syncCompleted = 'sync_completed';
  static const String manualSyncInitiated = 'manual_sync_initiated';
  static const String refreshInitiated = 'refresh_initiated';

  // Navigation / engagement
  static const String navigationTapped = 'navigation_tapped';
  static const String quickAccessUsed = 'quick_access_used';
  static const String featureUsed = 'feature_used';

  /// Records that the store rating sheet was requested, not that anyone rated —
  /// neither store reports the outcome back to the app.
  static const String reviewPromptShown = 'review_prompt_shown';

  /// A contextual "why is this?" link was followed into the FAQ.
  static const String faqTopicOpened = 'faq_topic_opened';

  /// The support sheet was opened, and which option inside it was tapped.
  static const String supportSheetOpened = 'support_sheet_opened';
  static const String supportActionTapped = 'support_action_tapped';

  // Academics
  static const String attendanceDetailOpened = 'attendance_detail_opened';
  static const String timetableDayChanged = 'timetable_day_changed';
  static const String outingTabChanged = 'outing_tab_changed';
  static const String facultySearch = 'faculty_search';
  static const String facultyOpened = 'faculty_opened';
  static const String cgpaCalculatorOpened = 'cgpa_calculator_opened';
  static const String cgpaCalculatorShared = 'cgpa_calculator_shared';
  static const String digitalAssignmentUpload = 'digital_assignment_upload';
  static const String digitalAssignmentDownload = 'digital_assignment_download';
  static const String forYouItemSubmitted = 'for_you_item_submitted';
  static const String tileDetailLinkOpened = 'tile_detail_link_opened';

  // Settings
  static const String settingChanged = 'setting_changed';
  static const String notificationsReset = 'notifications_reset';
  static const String profilePictureChangeStarted =
      'profile_picture_change_started';

  // Developer tools
  static const String developerModeEnabled = 'developer_mode_enabled';
  static const String forceSessionRefresh = 'force_session_refresh';
  static const String clearAllLocalData = 'clear_all_local_data';

  // Diagnostics
  static const String appError = 'app_error';
}

/// Parameter keys shared across events.
///
/// Firebase allows 25 parameters per event and truncates values at 100 chars.
/// There is deliberately no `timestamp` key: every event already carries
/// `event_timestamp` server-side, so sending one wastes a parameter slot and a
/// custom dimension registration.
abstract final class AnalyticsParams {
  static const String method = 'method';
  static const String screen = 'screen';
  static const String source = 'source';

  /// Which FAQ answer a contextual link opened — tells you which assumptions
  /// people are actually hitting, and where.
  static const String topic = 'topic';
  static const String target = 'target';
  static const String feature = 'feature';
  static const String setting = 'setting';
  static const String value = 'value';
  static const String reason = 'reason';
  static const String errorType = 'error_type';
  static const String location = 'location';
  static const String courseCode = 'course_code';
  static const String courseType = 'course_type';
  static const String dataType = 'data_type';
  static const String count = 'count';
  static const String sizeBytes = 'size_bytes';
  static const String fileExtension = 'file_extension';
  static const String queryLength = 'query_length';
  static const String dayIndex = 'day_index';
  static const String tab = 'tab';
  static const String mode = 'mode';
  static const String type = 'type';
}

/// User property names. Firebase caps these at 24 characters.
abstract final class AnalyticsUserProperties {
  /// Derived from the registration number prefix, e.g. `2023`.
  static const String joiningYear = 'joining_year';

  /// Derived from the registration number prefix, e.g. `BCE`.
  static const String branch = 'branch';
}
