import 'package:flutter/foundation.dart';
import 'package:vit_ap_student_app/core/models/credentials.dart';
import 'package:vit_ap_student_app/src/rust/api/vtop/vtop_client.dart';
import 'package:vit_ap_student_app/src/rust/api/vtop_get_client.dart';

/// Singleton service for managing VTOP client instances
/// Maintains a single VtopClient instance per session and persists login state
/// across multiple requests with the same credentials
///
/// Features:
/// - Automatic session expiry detection (15-minute timeout)
/// - Proactive session renewal before expiry
/// - Automatic retry mechanism for failed requests
/// - Proper error handling and session state management

class VtopClientService {
  static VtopClientService? _instance;
  VtopClient? _client;
  bool _isInitialized = false;
  String? _currentUsername;
  String? _currentPassword;
  DateTime? _sessionCreatedAt;

  // VTOP sessions expire after 15 minutes, we'll refresh at 14 minutes to be safe
  static const Duration _sessionExpiryDuration = Duration(minutes: 15);
  static const Duration _sessionRefreshThreshold = Duration(minutes: 14);

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
  /// Automatically handles session expiry and re-authentication
  Future<VtopClient> getClient({
    required String username,
    required String password,
  }) async {
    // Check if we need to create a new client due to:
    // 1. No existing client
    // 2. Not initialized
    // 3. Different credentials
    // 4. Session approaching expiry (proactive refresh)
    bool needsNewClient = _client == null ||
        !_isInitialized ||
        _currentUsername != username ||
        _currentPassword != password ||
        _isSessionNearExpiry();

    debugPrint("getClient called: needsNewClient=$needsNewClient, "
        "hasClient=${_client != null}, "
        "isInitialized=$_isInitialized, "
        "sameCredentials=${_currentUsername == username && _currentPassword == password}");

    if (needsNewClient) {
      debugPrint(
          "Creating a new Vtop client - Reason: ${_getClientCreationReason(username, password)}");
      await _initializeClient(username: username, password: password);
    } else {
      debugPrint(
          "Using existing Vtop client (session age: ${_getSessionAge()})");
    }

    return _client!;
  }

  /// Check if session is near expiry (within refresh threshold)
  bool _isSessionNearExpiry() {
    if (_sessionCreatedAt == null) return true;

    final sessionAge = DateTime.now().difference(_sessionCreatedAt!);
    final isNearExpiry = sessionAge >= _sessionRefreshThreshold;

    // Debug logging to understand the issue
    debugPrint(
        "Session expiry check: age=${sessionAge.inMinutes}m ${sessionAge.inSeconds % 60}s, "
        "threshold=${_sessionRefreshThreshold.inMinutes}m, "
        "isNearExpiry=$isNearExpiry");

    return isNearExpiry;
  }

  /// Check if session is completely expired
  bool _isSessionExpired() {
    if (_sessionCreatedAt == null) return true;

    final sessionAge = DateTime.now().difference(_sessionCreatedAt!);
    return sessionAge >= _sessionExpiryDuration;
  }

  /// Get session age as human-readable string
  String _getSessionAge() {
    if (_sessionCreatedAt == null) return "unknown";

    final sessionAge = DateTime.now().difference(_sessionCreatedAt!);
    final hours = sessionAge.inHours;
    final minutes = sessionAge.inMinutes % 60;
    final seconds = sessionAge.inSeconds % 60;

    if (hours > 0) {
      return "${hours}h ${minutes}m ${seconds}s";
    } else {
      return "${minutes}m ${seconds}s";
    }
  }

  /// Get reason for client creation (for debugging)
  String _getClientCreationReason(String username, String password) {
    if (_client == null) return "No existing client";
    if (!_isInitialized) return "Not initialized";
    if (_currentUsername != username || _currentPassword != password) {
      return "Different credentials";
    }
    if (_isSessionExpired()) {
      return "Session expired (${_getSessionAge()})";
    }
    if (_isSessionNearExpiry()) {
      return "Session near expiry (${_getSessionAge()})";
    }
    return "Unknown reason";
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

      // Store current credentials and session timestamp
      _currentUsername = username;
      _currentPassword = password;
      _sessionCreatedAt = DateTime.now();
      _isInitialized = true;

      debugPrint("VTOP client initialized successfully at $_sessionCreatedAt");
    } catch (e) {
      _isInitialized = false;
      _client = null;
      _currentUsername = null;
      _currentPassword = null;
      _sessionCreatedAt = null;
      debugPrint("VTOP client initialization failed: $e");
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

  /// Execute a VTOP API call with automatic retry on session expiry
  /// This method wraps any VTOP client operation and handles session expiry gracefully
  ///
  /// Example usage:
  /// ```dart
  /// final timetable = await service.executeWithRetry(
  ///   credentials: credentials,
  ///   operation: (client) => client.getTimetable(semesterId),
  /// );
  /// ```
  Future<T> executeWithRetry<T>({
    required Credentials credentials,
    required Future<T> Function(VtopClient client) operation,
    int maxRetries = 2,
  }) async {
    int attempts = 0;

    while (attempts < maxRetries) {
      try {
        attempts++;
        final client = await getClientFromCredentials(credentials);
        return await operation(client);
      } catch (e) {
        debugPrint("VTOP operation failed (attempt $attempts/$maxRetries): $e");

        // If this was our last attempt, rethrow the error
        if (attempts >= maxRetries) {
          rethrow;
        }

        // Check if this is a session-related error that we can retry
        if (_isRetryableError(e)) {
          debugPrint(
              "Session-related error detected, forcing client reset and retry...");
          resetClient();
          // Brief delay before retry to avoid rapid successive requests
          await Future.delayed(const Duration(milliseconds: 500));
        } else {
          // For non-retryable errors, fail immediately
          rethrow;
        }
      }
    }

    throw Exception("Max retries exceeded");
  }

  /// Check if an error is retryable (session-related)
  bool _isRetryableError(dynamic error) {
    final errorString = error.toString().toLowerCase();

    // Check for session expiry indicators
    return errorString.contains('session') ||
        errorString.contains('expired') ||
        errorString.contains('unauthorized') ||
        errorString.contains('invalid credentials') ||
        errorString.contains('authentication failed');
  }

  /// Reset the client (for logout or credential changes)
  void resetClient() {
    debugPrint("Resetting VTOP client (session age: ${_getSessionAge()})");
    _client = null;
    _isInitialized = false;
    _currentUsername = null;
    _currentPassword = null;
    _sessionCreatedAt = null;
  }

  /// Get the current client instance if available
  VtopClient? get currentClient => _isInitialized ? _client : null;

  /// Check if client is initialized
  bool get isInitialized => _isInitialized && _client != null;

  /// Check if current session matches provided credentials
  bool hasSessionFor({required String username, required String password}) {
    return _isInitialized &&
        _currentUsername == username &&
        _currentPassword == password &&
        !_isSessionExpired();
  }

  /// Get session information for debugging
  Map<String, dynamic> getSessionInfo() {
    return {
      'isInitialized': _isInitialized,
      'hasClient': _client != null,
      'username': _currentUsername,
      'sessionCreatedAt': _sessionCreatedAt?.toIso8601String(),
      'sessionAge': _getSessionAge(),
      'isNearExpiry': _isSessionNearExpiry(),
      'isExpired': _isSessionExpired(),
    };
  }

  /// Get time remaining until session expiry
  Duration? getTimeUntilExpiry() {
    if (_sessionCreatedAt == null) return null;

    final expiryTime = _sessionCreatedAt!.add(_sessionExpiryDuration);
    final timeRemaining = expiryTime.difference(DateTime.now());

    return timeRemaining.isNegative ? Duration.zero : timeRemaining;
  }
}
