import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vit_ap_student_app/core/models/credentials.dart';
import 'package:vit_ap_student_app/core/models/mark.dart';
import 'package:vit_ap_student_app/core/models/user.dart';
import 'package:vit_ap_student_app/core/providers/current_user.dart';
import 'package:vit_ap_student_app/core/services/demo_service.dart';
import 'package:vit_ap_student_app/features/grade_view/model/grade_view_detail.dart';
import 'package:vit_ap_student_app/features/grade_view/repository/grade_view_remote_repository.dart';

part 'mark_detail_viewmodel.g.dart';

@riverpod
class MarkDetailViewModel extends _$MarkDetailViewModel {
  late GradeViewRemoteRepository _gradeViewRemoteRepository;

  @override
  AsyncValue<GradeStatisticsModel?>? build() {
    _gradeViewRemoteRepository = ref.watch(gradeViewRemoteRepositoryProvider);
    return null;
  }

  /// Ensures the class statistics for [mark] are available.
  Future<void> loadStats(Mark mark) async {
    try {
      // Already cached from a previous open.
      if (mark.gradeStatsJson != null && mark.gradeStatsJson!.isNotEmpty) {
        state = AsyncValue.data(_decode(mark.gradeStatsJson!));
        return;
      }

      // Not graded yet, or no id to fetch with: no stats to show.
      if (mark.grade == null ||
          mark.gradeCourseId == null ||
          mark.gradeCourseId!.isEmpty) {
        state = const AsyncValue.data(null);
        return;
      }

      state = const AsyncValue.loading();

      if (DemoService.isDemoMode) {
        final detail = await DemoService.instance.gradeViewDetail();
        mark.gradeStatsJson = jsonEncode(detail.statistics.toJson());
        state = AsyncValue.data(detail.statistics);
        return;
      }

      final User? user = ref.read(currentUserProvider);
      final userNotifier = ref.read(currentUserProvider.notifier);
      final Credentials? credentials = await userNotifier.getSavedCredentials();

      if (credentials == null) {
        state = AsyncValue.error('User not found. Please Logout.', StackTrace.current);
        return;
      }

      // Explicit 10-second timeout kills the infinite loading indicator if VTOP hangs
      final res = await _gradeViewRemoteRepository.fetchGradeViewDetail(
        registrationNumber: credentials.registrationNumber,
        password: credentials.password,
        semSubId: credentials.semSubId,
        courseId: mark.gradeCourseId!,
      ).timeout(const Duration(seconds: 10));

      if (res case Left(value: final failure)) {
        state = AsyncValue.error(failure.message, StackTrace.current);
      } else if (res case Right(value: final detail)) {
        mark.gradeStatsJson = jsonEncode(detail.statistics.toJson());
        if (user != null) {
          // Safely update user cache
          await userNotifier.updateUser(user);
        }
        state = AsyncValue.data(detail.statistics);
      }
    } catch (e, st) {
      // Catch network timeouts, Rust panics, or JSON errors and push them to the UI
      state = AsyncValue.error(e.toString(), st);
    }
  }

  GradeStatisticsModel _decode(String jsonStr) =>
      GradeStatisticsModel.fromJson(json.decode(jsonStr) as Map<String, dynamic>);
}