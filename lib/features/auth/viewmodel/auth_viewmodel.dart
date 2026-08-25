import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vit_ap_student_app/core/constants/analytics_constants.dart';
import 'package:vit_ap_student_app/core/models/credentials.dart';
import 'package:vit_ap_student_app/core/models/mark.dart';
import 'package:vit_ap_student_app/core/models/user.dart';
import 'package:vit_ap_student_app/core/providers/current_user.dart';
import 'package:vit_ap_student_app/core/services/analytics_service.dart';
import 'package:vit_ap_student_app/core/services/demo_service.dart';
import 'package:vit_ap_student_app/features/auth/repository/auth_remote_repository.dart';
import 'package:vit_ap_student_app/features/grade_view/model/grade_view_course.dart';
import 'package:vit_ap_student_app/features/grade_view/repository/grade_view_remote_repository.dart';

part 'auth_viewmodel.g.dart';

@riverpod
class AuthViewModel extends _$AuthViewModel {
  late AuthRemoteRepository _authRemoteRepository;
  late CurrentUserNotifier _currentUserNotifier;
  late AnalyticsService _analytics;
  late GradeViewRemoteRepository _gradeViewRemoteRepository;

  @override
  AsyncValue<User>? build() {
    _authRemoteRepository = ref.watch(authRemoteRepositoryProvider);
    _currentUserNotifier = ref.watch(currentUserProvider.notifier);
    _analytics = ref.watch(analyticsServiceProvider);
    _gradeViewRemoteRepository = ref.watch(gradeViewRemoteRepositoryProvider);
    return null;
  }

  /// Logs in the bundled demo account for App Store review / demos.
  ///
  /// Bypasses the entire VTOP flow (no credential check, no semester fetch, no
  /// OTP) and seeds local storage from [DemoService]'s sanitized dataset.
  Future<void> loginDemoUser() async {
    state = const AsyncValue.loading();

    _analytics.logEvent(AnalyticsEvents.loginAttempt, {
      AnalyticsParams.method: 'demo',
    });

    try {
      final user = await DemoService.instance.loadDemoUser();
      final credentials = DemoService.instance.credentials;

      await DemoService.instance.setDemoMode(true);
      await _currentUserNotifier.loginUser(user, credentials);

      _analytics.logLogin('demo');
      _analytics.logEvent(AnalyticsEvents.loginSuccess, {
        AnalyticsParams.method: 'demo',
      });

      state = AsyncValue.data(user);
    } catch (e) {
      // Roll back the flag so the app doesn't get stuck in a broken demo state.
      await DemoService.instance.setDemoMode(false);
      _analytics.logError('auth_error', e, location: 'loginDemoUser');
      state = AsyncValue.error(
        'Failed to start the demo. Please try again.',
        StackTrace.current,
      );
    }
  }

  Future<void> loginUser({
    required String semSubId,
    String? registrationNumber,
    String? password,
  }) async {
    state = const AsyncValue.loading();

    Credentials? credentials;

    // If credentials are provided as parameters, use them (first-time login)
    if (registrationNumber != null && password != null) {
      credentials = Credentials(
        registrationNumber: registrationNumber,
        password: password,
        semSubId: semSubId,
      );
    } else {
      // Otherwise, try to get saved credentials (re-authentication)
      credentials = await ref
          .read(currentUserProvider.notifier)
          .getSavedCredentials();
      if (credentials == null) {
        state = AsyncValue.error(
            'No saved credentials found. Please log in again.',
            StackTrace.current);
        _analytics.logError(
          'auth_error',
          'No saved credentials found',
          location: 'loginUser',
        );
        return;
      }
    }

    // The typed login id is never logged — it identifies the student. Cohort
    // properties are set from the scraped registration number after login.
    _analytics.logEvent(AnalyticsEvents.loginAttempt, {
      AnalyticsParams.method: 'vtop_credentials',
    });

    final res = await _authRemoteRepository.login(
      registrationNumber: credentials.registrationNumber,
      password: credentials.password,
      semSubId: semSubId,
    );

    final Credentials newCredentials = Credentials(
      registrationNumber: credentials.registrationNumber,
      password: credentials.password,
      semSubId: semSubId,
    );

    if (res case Left(value: final failure)) {
      // Log login failure
      _analytics.logEvent(AnalyticsEvents.loginFailed, {
        AnalyticsParams.method: 'vtop_credentials',
        AnalyticsParams.reason: failure.message,
      });
      state = AsyncValue.error(failure.message, StackTrace.current);
    } else if (res case Right(value: final user)) {
      // Log successful login. The registration number scraped from VTOP is the
      // authoritative one — the login id the student typed may be something
      // else entirely.
      final regNo = user.profile.target?.registrationNumber;
      if (regNo != null && regNo.isNotEmpty) {
        _analytics.identifyStudent(regNo);
      }
      _analytics.logLogin('vtop_credentials');
      _analytics.logEvent(AnalyticsEvents.loginSuccess, {
        AnalyticsParams.method: 'vtop_credentials',
      });

      // Added Grade View fetching

      final oldUser = ref.read(currentUserProvider);
      final marksList = user.marks.toList();

      // Transfer saved stats from the old database objects to the new ones
      if (oldUser != null) {
        for (final newMark in marksList) {
          try {
            final oldMark = oldUser.marks.firstWhere(
                    (m) => m.courseCode == newMark.courseCode && m.courseType == newMark.courseType
            );
            newMark.gradeStatsJson = oldMark.gradeStatsJson;
          } catch (_) {} // Different semester or new course, no cache to transfer
        }
      }

      final gradeRes = await _gradeViewRemoteRepository.fetchGradeView(
        registrationNumber: credentials.registrationNumber,
        password: credentials.password,
        semSubId: semSubId,
      );

      gradeRes.match(
            (_) => _purgeGrades(marksList),
            (courses) {
          if (courses.isEmpty) {
            _purgeGrades(marksList);
          } else {
            _mergeGrades(marksList, courses);
          }
        },
      );
      _getDataSuccess(user, newCredentials);
    }
  }

  AsyncValue<User> _getDataSuccess(User user, Credentials credentials) {
    _currentUserNotifier.loginUser(user, credentials);
    return state = AsyncValue.data(user);
  }

  void _purgeGrades(List<Mark> marks) {
    for (final mark in marks) {
      mark.grade = null;
      mark.grandTotal = null;
      mark.gradeCourseId = null;
      mark.gradeStatsJson = null;
    }
  }

  void _mergeGrades(List<Mark> marks, List<GradeViewCourseModel> courses) {
    final Map<String, List<GradeViewCourseModel>> groupedCourses = {};
    for (final c in courses) {
      groupedCourses.putIfAbsent(c.courseCode.trim(), () => []).add(c);
    }

    for (final mark in marks) {
      final matchGroup = groupedCourses[mark.courseCode.trim()];
      if (matchGroup != null) {
        final validGrade = matchGroup.firstWhere(
              (c) => c.grade.trim().isNotEmpty && c.grade != '-',
          orElse: () => matchGroup.first,
        );
        final validId = matchGroup.firstWhere(
              (c) => c.courseId.trim().isNotEmpty,
          orElse: () => matchGroup.first,
        );
        final validTotal = matchGroup.firstWhere(
              (c) => c.grandTotal.trim().isNotEmpty && c.grandTotal != '-',
          orElse: () => matchGroup.first,
        );

        mark.grade = validGrade.grade.trim().isEmpty || validGrade.grade == '-' ? null : validGrade.grade;
        mark.grandTotal = validTotal.grandTotal.trim().isEmpty || validTotal.grandTotal == '-' ? null : validTotal.grandTotal;
        mark.gradeCourseId = validId.courseId.trim().isEmpty ? null : validId.courseId;
      } else {
        mark.grade = null;
        mark.grandTotal = null;
        mark.gradeCourseId = null;
        mark.gradeStatsJson = null;
      }
    }
  }
}