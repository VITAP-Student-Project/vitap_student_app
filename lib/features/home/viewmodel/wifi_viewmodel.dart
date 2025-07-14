import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vit_ap_student_app/core/error/failure.dart';
import 'package:vit_ap_student_app/core/providers/current_user.dart';
import 'package:vit_ap_student_app/features/home/model/hostel_wifi_response.dart';
import 'package:vit_ap_student_app/features/home/repository/wifi_remote_repository.dart';

part 'wifi_viewmodel.g.dart';

@riverpod
class WifiViewModel extends _$WifiViewModel {
  late WifiRemoteRepository _wifiRemoteRepository;

  @override
  AsyncValue<HostelWifiResponse>? build() {
    _wifiRemoteRepository = ref.watch(wifiRemoteRepositoryProvider);

    return null;
  }

  Future<void> hostelWifiLogin() async {
    state = const AsyncValue.loading();
    final credentials = await ref
        .read(currentUserNotifierProvider.notifier)
        .getSavedCredentials();
    if (credentials == null) {
      AsyncValue.error("No credentials found.", StackTrace.current);
    }
    late Either<Failure, HostelWifiResponse> res;
    if (credentials!.hostelWifiUsername != null &&
        credentials.hostelWifiPassword != null) {
      res = await _wifiRemoteRepository.hostelWifiLogin(
        credentials.hostelWifiUsername!,
        credentials.hostelWifiPassword!,
      );
    } else {
      AsyncValue.error("No credentials found.", StackTrace.current);
    }

    state = switch (res) {
      Left(value: final failure) =>
        AsyncValue.error(failure.message, StackTrace.current),
      Right(value: final res) => AsyncValue.data(res),
    };
  }

  Future<void> hostelWifiLogout() async {
    state = const AsyncValue.loading();
    final credentials = await ref
        .read(currentUserNotifierProvider.notifier)
        .getSavedCredentials();
    if (credentials == null) {
      AsyncValue.error("No credentials found", StackTrace.current);
    }
    late Either<Failure, HostelWifiResponse> res;
    if (credentials!.hostelWifiUsername != null &&
        credentials.hostelWifiPassword != null) {
      res = await _wifiRemoteRepository.hostelWifiLogin(
        credentials.hostelWifiUsername!,
        credentials.hostelWifiPassword!,
      );
    } else {
      AsyncValue.error("No credentials found.", StackTrace.current);
    }

    state = switch (res) {
      Left(value: final failure) =>
        AsyncValue.error(failure.message, StackTrace.current),
      Right(value: final res) => AsyncValue.data(res),
    };
  }
}
