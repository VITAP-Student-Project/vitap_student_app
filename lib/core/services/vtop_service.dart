import 'package:flutter/foundation.dart';
import 'package:vit_ap_student_app/core/models/credentials.dart';
import 'package:vit_ap_student_app/src/rust/api/vtop/vtop_client.dart';
import 'package:vit_ap_student_app/src/rust/api/vtop_get_client.dart';

/// Singleton service for managing VTOP client instances
/// Maintains a single VtopClient instance per session and persists login state
/// across multiple requests with the same credentials

class VtopClientService {
  static VtopClientService? _instance;
  VtopClient? _client;
  bool _isInitialized = false;
  String? _currentUsername;
  String? _currentPassword;

  VtopClientService._();

  static VtopClientService get instance {
    _instance ??= VtopClientService._();
    return _instance!;
  }

  // Factory constructor for service locator compatibility
  factory VtopClientService() {
    return instance;
  }

  /// Get the VTOP client instance, initializing if necessary
  Future<VtopClient> getClient({
    required String username,
    required String password,
  }) async {
    // reinitialize only if credentials change (different credentials)
    if (_client == null ||
        !_isInitialized ||
        _currentUsername != username ||
        _currentPassword != password) {
      debugPrint("Creating a new Vtop client");
      await _initializeClient(username: username, password: password);
    }
    debugPrint("Using existing Vtop client");
    return _client!;
  }

  /// Initialize the VTOP client and login
  Future<void> _initializeClient({
    required String username,
    required String password,
  }) async {
    try {
      // Create client
      _client = getVtopClient(username: username, password: password);

      // Login
      await vtopClientLogin(client: _client!);

      // Store current credentials
      _currentUsername = username;
      _currentPassword = password;
      _isInitialized = true;
    } catch (e) {
      _isInitialized = false;
      _client = null;
      _currentUsername = null;
      _currentPassword = null;
      rethrow;
    }
  }

  /// Get client from saved credentials
  Future<VtopClient> getClientFromCredentials(Credentials credentials) async {
    return await getClient(
      username: credentials.registrationNumber,
      password: credentials.password,
    );
  }

  /// Reset the client (for logout or credential changes)
  void resetClient() {
    _client = null;
    _isInitialized = false;
    _currentUsername = null;
    _currentPassword = null;
  }

  /// Get the current client instance if available
  VtopClient? get currentClient => _isInitialized ? _client : null;

  /// Check if client is initialized
  bool get isInitialized => _isInitialized && _client != null;

  /// Check if current session matches provided credentials
  bool hasSessionFor({required String username, required String password}) {
    return _isInitialized &&
        _currentUsername == username &&
        _currentPassword == password;
  }
}
