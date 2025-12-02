import 'dart:io' show Platform;

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';

/// Gets the device's user agent string for WebView.
///
/// Returns a user agent string that matches the current device's
/// platform and version information.
Future<String> getDeviceUserAgent() async {
  try {
    final deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      final version = androidInfo.version;
      return 'Mozilla/5.0 (Linux; Android ${version.release}; '
          '${androidInfo.model}) AppleWebKit/537.36 '
          '(KHTML, like Gecko) Chrome/120.0.0.0 Mobile Safari/537.36';
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      return 'Mozilla/5.0 (${iosInfo.model}; CPU iPhone OS '
          '${iosInfo.systemVersion.replaceAll('.', '_')} like Mac OS X) '
          'AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 '
          'Mobile/15E148 Safari/604.1';
    }
  } catch (e) {
    debugPrint('Failed to get device info: $e');
  }

  // Fallback user agent
  return 'Mozilla/5.0 (Linux; Android 13; Pixel 7) AppleWebKit/537.36 '
      '(KHTML, like Gecko) Chrome/120.0.0.0 Mobile Safari/537.36';
}
