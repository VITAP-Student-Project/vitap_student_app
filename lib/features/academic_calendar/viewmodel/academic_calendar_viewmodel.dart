import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vit_ap_student_app/core/models/academic_calendar.dart';
import 'package:vit_ap_student_app/core/models/credentials.dart';
import 'package:vit_ap_student_app/core/providers/current_user.dart';
import 'package:vit_ap_student_app/features/academic_calendar/repository/academic_calendar_repository.dart';

part 'academic_calendar_viewmodel.g.dart';

@riverpod
class AcademicCalendarViewModel extends _$AcademicCalendarViewModel {
  late AcademicCalendarRepository _repository;

  /// Starts empty: reading the stored calendar needs the semester id, which
  /// lives with the saved credentials and can only be read asynchronously.
  /// [loadCached] fills this in, and nothing here ever contacts VTOP — a
  /// refresh is a request per month, so it is always the student's decision.
  @override
  AsyncValue<AcademicCalendar?> build() {
    _repository = ref.watch(academicCalendarRepositoryProvider);
    return const AsyncValue.data(null);
  }

  Future<void> refreshCalendar() async {
    final userNotifier = ref.read(currentUserProvider.notifier);
    final Credentials? credentials = await userNotifier.getSavedCredentials();
    if (credentials == null) {
      state = AsyncValue.error(
        'User not found. Please Logout and Login.',
        StackTrace.current,
      );
      return;
    }

    state = const AsyncValue.loading();

    final res = await _repository.fetchCalendar(
      registrationNumber: credentials.registrationNumber,
      password: credentials.password,
      semSubId: credentials.semSubId,
    );

    if (res case Left(value: final failure)) {
      state = AsyncValue.error(failure.message, StackTrace.current);
    } else if (res case Right(value: final calendar)) {
      state = AsyncValue.data(calendar);
    }
  }

  /// Loads the stored calendar, if there is one.
  Future<void> loadCached() async {
    final credentials = await ref
        .read(currentUserProvider.notifier)
        .getSavedCredentials();
    if (credentials == null) return;

    state = AsyncValue.data(_repository.cached(semSubId: credentials.semSubId));
  }
}
