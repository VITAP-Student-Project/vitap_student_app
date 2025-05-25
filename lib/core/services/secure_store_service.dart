import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final FlutterSecureStorage storage;

  SecureStorageService({required this.storage});

  static const String _bearerTokenKey = 'bearer_token';
  // Save the token
  Future<void> saveToken(String token) async {
    await storage.write(key: _bearerTokenKey, value: token);
    log('Token saved: $token');
  }

  // Get the token
  Future<String?> getToken() async {
    final token = await storage.read(key: _bearerTokenKey);
    log('Token retrieved: $token');
    return token;
  }

  // Clear the token
  Future<void> clearToken() async {
    await storage.delete(key: _bearerTokenKey);
    log('Token cleared');
  }
}
