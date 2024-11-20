import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../api/wifi/university_wifi.dart';

final UniversityWifiProvider = Provider<UniversityWifi>((ref) {
  return UniversityWifi(
    baseUrl: 'http://172.18.10.10:1000/login',
    initialMagic: '031e2a53aa0c76ca',
  );
});

final universityWifiLoginProvider =
    FutureProvider.family<bool, Map<String, String>>((ref, credentials) async {
  final UniversityWifi = ref.read(UniversityWifiProvider);
  return await UniversityWifi.login(
    username: credentials['username']!,
    password: credentials['password']!,
  );
});

final secureStorageProvider =
    Provider<FlutterSecureStorage>((ref) => FlutterSecureStorage());
