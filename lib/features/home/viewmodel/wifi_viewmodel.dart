import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vit_ap_student_app/core/error/failure.dart';
import 'package:vit_ap_student_app/core/providers/current_user.dart';
import 'package:vit_ap_student_app/core/utils/show_snackbar.dart';
import 'package:vit_ap_student_app/features/home/model/hostel_wifi_response.dart';
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

  /// Unified WiFi login that tries hostel first, then university
  Future<void> unifiedWifiLogin() async {
    state = const AsyncValue.loading();
    final credentials = await ref
        .read(currentUserNotifierProvider.notifier)
        .getSavedCredentials();

    if (credentials == null) {
      state = AsyncValue.error("No credentials found.", StackTrace.current);
      return;
    }

    if (credentials.hostelWifiUsername == null ||
        credentials.hostelWifiPassword == null ||
        credentials.hostelWifiUsername!.isEmpty ||
        credentials.hostelWifiPassword!.isEmpty) {
      state = AsyncValue.data(WifiResponse.credentialsError());
      return;
    }

    final res = await _wifiRemoteRepository.unifiedWifiLogin(
      credentials.hostelWifiUsername!,
      credentials.hostelWifiPassword!,
    );

    state = switch (res) {
      Left(value: final failure) =>
        AsyncValue.error(failure.message, StackTrace.current),
      Right(value: final response) => AsyncValue.data(response),
    };
  }

  /// Unified WiFi logout that tries both networks
  Future<void> unifiedWifiLogout() async {
    state = const AsyncValue.loading();
    final credentials = await ref
        .read(currentUserNotifierProvider.notifier)
        .getSavedCredentials();

    if (credentials == null) {
      state = AsyncValue.error("No credentials found.", StackTrace.current);
      return;
    }

    if (credentials.hostelWifiUsername == null ||
        credentials.hostelWifiPassword == null ||
        credentials.hostelWifiUsername!.isEmpty ||
        credentials.hostelWifiPassword!.isEmpty) {
      state = AsyncValue.data(WifiResponse.credentialsError());
      return;
    }

    final res = await _wifiRemoteRepository.unifiedWifiLogout(
      credentials.hostelWifiUsername!,
      credentials.hostelWifiPassword!,
    );

    state = switch (res) {
      Left(value: final failure) =>
        AsyncValue.error(failure.message, StackTrace.current),
      Right(value: final response) => AsyncValue.data(response),
    };
  }

  // Legacy methods for backward compatibility (fixed hostel logout bug)
  Future<void> hostelWifiLogin() async {
    state = const AsyncValue.loading();
    final credentials = await ref
        .read(currentUserNotifierProvider.notifier)
        .getSavedCredentials();
    if (credentials == null) {
      state = AsyncValue.error("No credentials found.", StackTrace.current);
      return;
    }
    late Either<Failure, HostelWifiResponse> res;
    if (credentials.hostelWifiUsername != null &&
        credentials.hostelWifiPassword != null) {
      res = await _wifiRemoteRepository.hostelWifiLogin(
        credentials.hostelWifiUsername!,
        credentials.hostelWifiPassword!,
      );
    } else {
      state = AsyncValue.error("No credentials found.", StackTrace.current);
      return;
    }

    // Convert HostelWifiResponse to WifiResponse
    state = switch (res) {
      Left(value: final failure) =>
        AsyncValue.error(failure.message, StackTrace.current),
      Right(value: final hostelResponse) => AsyncValue.data(WifiResponse(
          message: hostelResponse.message,
          snackBarType: hostelResponse.snackBarType,
          wifiType: WifiType.hostel,
          success: hostelResponse.snackBarType == SnackBarType.success,
        )),
    };
  }

  Future<void> hostelWifiLogout() async {
    state = const AsyncValue.loading();
    final credentials = await ref
        .read(currentUserNotifierProvider.notifier)
        .getSavedCredentials();
    if (credentials == null) {
      state = AsyncValue.error("No credentials found", StackTrace.current);
      return;
    }
    late Either<Failure, HostelWifiResponse> res;
    if (credentials.hostelWifiUsername != null &&
        credentials.hostelWifiPassword != null) {
      // FIXED: Use hostelWifiLogout instead of hostelWifiLogin
      res = await _wifiRemoteRepository.hostelWifiLogout(
        credentials.hostelWifiUsername!,
        credentials.hostelWifiPassword!,
      );
    } else {
      state = AsyncValue.error("No credentials found.", StackTrace.current);
      return;
    }

    // Convert HostelWifiResponse to WifiResponse
    state = switch (res) {
      Left(value: final failure) =>
        AsyncValue.error(failure.message, StackTrace.current),
      Right(value: final hostelResponse) => AsyncValue.data(WifiResponse(
          message: hostelResponse.message,
          snackBarType: hostelResponse.snackBarType,
          wifiType: WifiType.hostel,
          success: hostelResponse.snackBarType == SnackBarType.success,
        )),
    };
  }

  /// University WiFi login using Rust bindings
  Future<void> universityWifiLogin() async {
    state = const AsyncValue.loading();
    final credentials = await ref
        .read(currentUserNotifierProvider.notifier)
        .getSavedCredentials();

    if (credentials == null) {
      state = AsyncValue.error("No credentials found.", StackTrace.current);
      return;
    }

    if (credentials.hostelWifiUsername == null ||
        credentials.hostelWifiPassword == null ||
        credentials.hostelWifiUsername!.isEmpty ||
        credentials.hostelWifiPassword!.isEmpty) {
      state = AsyncValue.data(WifiResponse.credentialsError());
      return;
    }

    final res = await _wifiRemoteRepository.universityWifiLogin(
      credentials.hostelWifiUsername!,
      credentials.hostelWifiPassword!,
    );

    state = switch (res) {
      Left(value: final failure) =>
        AsyncValue.error(failure.message, StackTrace.current),
      Right(value: final response) => AsyncValue.data(response),
    };
  }

  /// University WiFi logout using Rust bindings
  Future<void> universityWifiLogout() async {
    state = const AsyncValue.loading();
    final credentials = await ref
        .read(currentUserNotifierProvider.notifier)
        .getSavedCredentials();

    if (credentials == null) {
      state = AsyncValue.error("No credentials found.", StackTrace.current);
      return;
    }

    if (credentials.hostelWifiUsername == null ||
        credentials.hostelWifiPassword == null ||
        credentials.hostelWifiUsername!.isEmpty ||
        credentials.hostelWifiPassword!.isEmpty) {
      state = AsyncValue.data(WifiResponse.credentialsError());
      return;
    }

    final res = await _wifiRemoteRepository.universityWifiLogout(
      credentials.hostelWifiUsername!,
      credentials.hostelWifiPassword!,
    );

    state = switch (res) {
      Left(value: final failure) =>
        AsyncValue.error(failure.message, StackTrace.current),
      Right(value: final response) => AsyncValue.data(response),
    };
  }
}
