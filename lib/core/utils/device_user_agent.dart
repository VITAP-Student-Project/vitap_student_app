import 'dart:io' show Platform;

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';

/// The device's browser User-Agent, resolved once per process.
///
/// This is the identity every VTOP request carries. VTOP binds a session to the
/// User-Agent that created it, so the Rust client and the in-app WebView have
/// to send the same string or the portal rejects the second one — see
/// `get_vtop_client`. It is cached because it cannot change while the app runs
/// and the login path should not pay a platform-channel round trip for it.
String? _cachedUserAgent;

/// Gets the device's user agent string.
///
/// Returns a user agent string that matches the current device's
/// platform and version information.
Future<String> getDeviceUserAgent() async {
  final cached = _cachedUserAgent;
  if (cached != null) return cached;

  final resolved = await _resolveDeviceUserAgent();
  _cachedUserAgent = resolved;
  return resolved;
}

Future<String> _resolveDeviceUserAgent() async {
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
