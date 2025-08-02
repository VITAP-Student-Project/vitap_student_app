import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vit_ap_student_app/core/models/credentials.dart';
import 'package:vit_ap_student_app/core/models/user.dart';
import 'package:vit_ap_student_app/core/providers/current_user.dart';
import 'package:vit_ap_student_app/core/services/analytics_service.dart';
import 'package:vit_ap_student_app/features/account/repository/account_remote_repository.dart';

part 'account_viewmodel.g.dart';

@riverpod
class AccountViewModel extends _$AccountViewModel {
  late AccountRemoteRepository _accountRemoteRepository;

  @override
  AsyncValue<User>? build() {
    _accountRemoteRepository = ref.watch(accountRemoteRepositoryProvider);
    return null;
  }

  Future<void> sync() async {
    state = const AsyncValue.loading();
    final User? user = ref.read(currentUserNotifierProvider);
    final userNotifier = ref.read(currentUserNotifierProvider.notifier);
    final Credentials? credentials = await userNotifier.getSavedCredentials();
    if (credentials == null) {
      AnalyticsService.logError(
          'sync_credentials_missing', 'User credentials not found during sync');
      AsyncValue.error(
          "User not found. Please Logout and Login.", StackTrace.current);
    }

    AnalyticsService.logEvent('sync_started', {
      'registration_number':
          credentials?.registrationNumber.substring(0, 4) ?? 'unknown',
      'semester_id': credentials?.semSubId ?? 'unknown',
    });

    state = const AsyncValue.loading();
    final res = await _accountRemoteRepository.syncUser(
      registrationNumber: credentials!.registrationNumber,
      password: credentials.password,
      semSubId: credentials.semSubId,
    );

    if (res case Left(value: final failure)) {
      AnalyticsService.logError('sync_failed', failure.message);
      state = AsyncValue.error(failure.message, StackTrace.current);
    } else if (res case Right(value: final newUser)) {
      AnalyticsService.logEvent('sync_completed', {
        'user_id': newUser.profile.target?.applicationNumber.substring(0, 6) ??
            'unknown',
        'data_updated': DateTime.now().toIso8601String(),
      });
      state = AsyncValue.data(newUser);
      if (user != null) {
        newUser.copyWith(id: user.id);
        userNotifier.updateUser(newUser);
      }
    }
  }
}
