import 'dart:developer';

import 'package:firebase_analytics/firebase_analytics.dart';
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

  Future<void> loginUser({
    required String semSubId,
  }) async {
    state = const AsyncValue.loading();
    final credentials = await ref
        .read(currentUserNotifierProvider.notifier)
        .getSavedCredentials();
    if (credentials == null) AsyncValue.error("error", StackTrace.current);
    final res = await _authRemoteRepository.login(
      registrationNumber: credentials!.registrationNumber,
      password: credentials.password,
      semSubId: semSubId,
    );

    final Credentials newCredentials = Credentials(
      registrationNumber: credentials.registrationNumber,
      password: credentials.password,
      semSubId: semSubId,
    );

    await setUserProperties(credentials.registrationNumber);

    final val = switch (res) {
      Left(value: final l) => state = AsyncValue.error(
          l.message,
          StackTrace.current,
        ),
      Right(value: final r) => _getDataSuccess(r, newCredentials),
    };
    log(StackTrace.current.toString());
  }

  AsyncValue<User> _getDataSuccess(User user, Credentials credentials) {
    _currentUserNotifier.loginUser(user, credentials);
    return state = AsyncValue.data(user);
  }

  Future<void> setUserProperties(String regNo) async {
    final regex = RegExp(r'^\d{2}[A-Z]{3}\d+$', caseSensitive: false);

    String joiningYear;
    String branch;

    if (regex.hasMatch(regNo)) {
      joiningYear = '20${regNo.substring(0, 2)}';
      branch = regNo.substring(2, 5).toUpperCase();
    } else {
      joiningYear = 'Custom';
      branch = 'Custom';
    }

    await FirebaseAnalytics.instance
        .setUserProperty(name: 'joining_year', value: joiningYear);
    await FirebaseAnalytics.instance
        .setUserProperty(name: 'branch', value: branch);
  }
}
