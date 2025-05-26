import 'dart:developer';

import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vit_ap_student_app/core/models/credentials.dart';
import 'package:vit_ap_student_app/core/models/user.dart';
import 'package:vit_ap_student_app/core/providers/current_user.dart';
import 'package:vit_ap_student_app/features/auth/repository/auth_remote_repository.dart';

part 'auth_viewmodel.g.dart';

@riverpod
class AuthViewModel extends _$AuthViewModel {
  late AuthRemoteRepository _authRemoteRepository;
  late CurrentUserNotifier _currentUserNotifier;

  @override
  AsyncValue<User>? build() {
    _authRemoteRepository = ref.watch(authRemoteRepositoryProvider);
    _currentUserNotifier = ref.watch(currentUserNotifierProvider.notifier);
    return null;
  }

  Future<void> loginUser(
      {required String registrationNumber,
      required String password,
      required String semSubId}) async {
    state = const AsyncValue.loading();
    final res = await _authRemoteRepository.login(
      registrationNumber: registrationNumber,
      password: password,
      semSubId: semSubId,
    );

    final Credentials credentials = Credentials(
      registrationNumber: registrationNumber,
      password: password,
      semSubId: semSubId,
    );

    final val = switch (res) {
      Left(value: final l) => state = AsyncValue.error(
          l.message,
          StackTrace.current,
        ),
      Right(value: final r) => _getDataSuccess(r, credentials),
    };
    log(val.toString());
  }

  AsyncValue<User> _getDataSuccess(User user, Credentials credentials) {
    _currentUserNotifier.loginUser(user, credentials);
    return state = AsyncValue.data(user);
  }
}
