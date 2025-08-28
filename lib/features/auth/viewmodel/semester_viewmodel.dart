import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vit_ap_student_app/features/auth/repository/auth_remote_repository.dart';
import 'package:vit_ap_student_app/src/rust/api/vtop/types/semester.dart';

part 'semester_viewmodel.g.dart';

@riverpod
class SemesterViewModel extends _$SemesterViewModel {
  late AuthRemoteRepository _authRemoteRepository;

  @override
  AsyncValue<List<SemesterInfo>>? build() {
    _authRemoteRepository = ref.watch(authRemoteRepositoryProvider);
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

    // Don't save credentials here - let the auth flow handle it after semester selection
    // The fetchSemesters should only fetch semesters, not modify stored credentials

    switch (res) {
      case Left(value: final l):
        state = AsyncValue.error(l.message, StackTrace.current);
      case Right(value: final r):
        state = AsyncValue.data(r);
    }
  }
}
