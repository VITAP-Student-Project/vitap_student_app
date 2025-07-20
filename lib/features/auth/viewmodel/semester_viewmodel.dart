import 'dart:developer';

import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vit_ap_student_app/core/models/credentials.dart';
import 'package:vit_ap_student_app/core/providers/current_user.dart';
import 'package:vit_ap_student_app/features/auth/repository/auth_remote_repository.dart';
import 'package:vit_ap_student_app/src/rust/api/vtop/types/semester.dart';

part 'semester_viewmodel.g.dart';

@riverpod
class SemesterViewModel extends _$SemesterViewModel {
  late AuthRemoteRepository _authRemoteRepository;
  late CurrentUserNotifier _currentUserNotifier;

  @override
  AsyncValue<List<SemesterInfo>>? build() {
    _authRemoteRepository = ref.watch(authRemoteRepositoryProvider);
    _currentUserNotifier = ref.watch(currentUserNotifierProvider.notifier);
    return null;
  }

  Future<void> fetchSemesters({
    required String registrationNumber,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    final res = await _authRemoteRepository.fetchSemesters(
      registrationNumber: registrationNumber,
      password: password,
    );

    final Credentials credentials = Credentials(
      registrationNumber: registrationNumber,
      password: password,
      semSubId: "",
    );

    _currentUserNotifier.updateSavedCredentials(newCredentials: credentials);

    switch (res) {
      case Left(value: final l):
        state = AsyncValue.error(l.message, StackTrace.current);
      case Right(value: final r):
        state = AsyncValue.data(r);
    }
    log(StackTrace.current.toString());
  }
}
