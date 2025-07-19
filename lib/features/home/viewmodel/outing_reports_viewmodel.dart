import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vit_ap_student_app/core/providers/current_user.dart';
import 'package:vit_ap_student_app/features/home/model/general_outing_report.dart';
import 'package:vit_ap_student_app/features/home/model/weekend_outing_report.dart';
import 'package:vit_ap_student_app/features/home/repository/home_remote_repository.dart';

part 'outing_reports_viewmodel.g.dart';

@riverpod
class GeneralOutingReportsViewModel extends _$GeneralOutingReportsViewModel {
  late HomeRemoteRepository _homeRemoteRepository;

  @override
  AsyncValue<List<GeneralOutingReport>>? build() {
    _homeRemoteRepository = ref.watch(homeRemoteRepositoryProvider);
    return null;
  }

  Future<void> fetchGeneralOutingReports() async {
    state = const AsyncValue.loading();
    final credentials = await ref
        .read(currentUserNotifierProvider.notifier)
        .getSavedCredentials();
    if (credentials == null) {
      state = AsyncValue.error(
        "User credentials not found. Please login again.",
        StackTrace.current,
      );
      return;
    }

    final res = await _homeRemoteRepository.fetchGeneralOutingReports(
      registrationNumber: credentials.registrationNumber,
      password: credentials.password,
    );

    state = switch (res) {
      Left(value: final failure) =>
        AsyncValue.error(failure.message, StackTrace.current),
      Right(value: final reports) => AsyncValue.data(reports),
    };
  }
}

@riverpod
class WeekendOutingReportsViewModel extends _$WeekendOutingReportsViewModel {
  late HomeRemoteRepository _homeRemoteRepository;

  @override
  AsyncValue<List<WeekendOutingReport>>? build() {
    _homeRemoteRepository = ref.watch(homeRemoteRepositoryProvider);
    return null;
  }

  Future<void> fetchWeekendOutingReports() async {
    state = const AsyncValue.loading();
    final credentials = await ref
        .read(currentUserNotifierProvider.notifier)
        .getSavedCredentials();
    if (credentials == null) {
      state = AsyncValue.error(
        "User credentials not found. Please login again.",
        StackTrace.current,
      );
      return;
    }

    final res = await _homeRemoteRepository.fetchWeekendOutingReports(
      registrationNumber: credentials.registrationNumber,
      password: credentials.password,
    );

    state = switch (res) {
      Left(value: final failure) =>
        AsyncValue.error(failure.message, StackTrace.current),
      Right(value: final reports) => AsyncValue.data(reports),
    };
  }
}
