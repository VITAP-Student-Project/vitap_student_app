import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vit_ap_student_app/core/providers/current_user.dart';
import 'package:vit_ap_student_app/features/home/model/wifi_response.dart';
import 'package:vit_ap_student_app/features/home/repository/wifi_remote_repository.dart';

part 'wifi_viewmodel.g.dart';

@riverpod
class WifiViewModel extends _$WifiViewModel {
  late WifiRemoteRepository _wifiRemoteRepository;

  @override
  AsyncValue<WifiResponse>? build() {
    _wifiRemoteRepository = ref.watch(wifiRemoteRepositoryProvider);
    return null;
  }

  Future<void> wifiLogin() async {
    state = const AsyncValue.loading();
    final credentials = await ref
        .read(currentUserNotifierProvider.notifier)
        .getSavedCredentials();

    if (credentials == null) {
      state = AsyncValue.error("No credentials found.", StackTrace.current);
      return;
    }

    if (credentials.wifiUsername == null ||
        credentials.wifiPassword == null ||
        credentials.wifiUsername!.isEmpty ||
        credentials.wifiPassword!.isEmpty) {
      state = AsyncValue.data(WifiResponse.credentialsError());
      return;
    }

    final res = await _wifiRemoteRepository.universityWifiLogin(
      credentials.wifiUsername!,
      credentials.wifiPassword!,
    );

    state = switch (res) {
      Left(value: final failure) =>
        AsyncValue.error(failure.message, StackTrace.current),
      Right(value: final response) => AsyncValue.data(response),
    };
  }

  Future<void> wifiLogout() async {
    state = const AsyncValue.loading();
    final credentials = await ref
        .read(currentUserNotifierProvider.notifier)
        .getSavedCredentials();

    if (credentials == null) {
      state = AsyncValue.error("No credentials found.", StackTrace.current);
      return;
    }

    if (credentials.wifiUsername == null ||
        credentials.wifiPassword == null ||
        credentials.wifiUsername!.isEmpty ||
        credentials.wifiPassword!.isEmpty) {
      state = AsyncValue.data(WifiResponse.credentialsError());
      return;
    }

    final res = await _wifiRemoteRepository.universityWifiLogout(
      credentials.wifiUsername!,
      credentials.wifiPassword!,
    );

    state = switch (res) {
      Left(value: final failure) =>
        AsyncValue.error(failure.message, StackTrace.current),
      Right(value: final response) => AsyncValue.data(response),
    };
  }
}
