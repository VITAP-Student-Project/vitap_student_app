import 'package:vit_ap_student_app/src/rust/api/vtop/vtop_errors.dart';
import 'package:flutter/foundation.dart';

class ServerException implements Exception {
  final String message;
  const ServerException(this.message);

  @override
  String toString() => 'ServerException: $message';
}

class SecureStorageException implements Exception {
  final String message;
  SecureStorageException(this.message);

  @override
  String toString() => 'SecureStorageException: $message';
}

/// Wrapper class to provide consistent error handling for VTOP errors
/// This converts VtopError (from Rust) into a standard Dart Exception
class VtopException implements Exception {
  final VtopError _error;
  String? _cachedMessage;
  String? _cachedErrorType;

  VtopException(this._error);

  /// Get user-friendly error message (cached after first call)
  Future<String> get message async {
    _cachedMessage ??= await _error.message();
    return _cachedMessage!;
  }

  /// Get error type for programmatic handling (cached after first call)
  Future<String> get errorType async {
    _cachedErrorType ??= await _error.errorType();
    return _cachedErrorType!;
  }

  /// Get debug message for logging (not cached)
  Future<String> get debugMessage async {
    return await _error.debugMessage();
  }

  /// Access the original VtopError for pattern matching
  VtopError get originalError => _error;

  /// Synchronous toString for logging (uses cached message if available)
  @override
  String toString() {
    if (_cachedMessage != null) {
      return 'VtopException: $_cachedMessage';
    }
    return 'VtopException: ${_error.runtimeType}';
  }

  /// Convenience method to create VtopException from VtopError
  static VtopException from(VtopError error) => VtopException(error);

  /// Static method to handle VtopError and convert to appropriate Failure message
  static Future<String> getFailureMessage(VtopError error) async {
    final vtopException = VtopException.from(error);
    final errorType = await vtopException.errorType;
    final message = await vtopException.message;

    // Log for debugging purposes (not shown to user)
    final debugMessage = await vtopException.debugMessage;
    debugPrint("VTOP Error [$errorType]: $debugMessage");

    // Return appropriate failure message based on error type
    return _createFailureMessage(errorType, message);
  }

  /// Create appropriate failure message based on VtopError type
  static String _createFailureMessage(String errorType, String message) {
    switch (errorType) {
      case 'NetworkError':
        return "No internet connection. Please check your network and try again.";

      case 'AuthenticationFailed':
      case 'InvalidCredentials':
        return "Invalid username or password. Please check your credentials and try again.";

      case 'SessionExpired':
        return "Your session has expired. Please login again.";

      case 'CaptchaRequired':
        return "Captcha verification is required. Please complete the captcha and try again.";

      case 'VtopServerError':
        return "VTOP server is temporarily unavailable. Please try again later.";

      case 'RegistrationParsingError':
        return "Invalid registration number format. Please check your registration number.";

      case 'ParseError':
        return "Unable to process server response. Please try again.";

      case 'ConfigurationError':
        return "App configuration error. Please restart the app and try again.";

      case 'InvalidResponse':
        return "Received invalid response from server. Please try again.";

      default:
        // For any unknown error types, return the user-friendly message from Rust
        return message;
    }
  }

  /// Check if this is a specific error type without async
  bool isErrorType(String type) {
    return _cachedErrorType == type;
  }

  /// Quick checks for common error types (requires errorType to be cached)
  bool get isNetworkError => _cachedErrorType == 'NetworkError';
  bool get isAuthenticationError => _cachedErrorType == 'AuthenticationFailed';
  bool get isSessionExpired => _cachedErrorType == 'SessionExpired';
  bool get isCaptchaRequired => _cachedErrorType == 'CaptchaRequired';
  bool get isInvalidCredentials => _cachedErrorType == 'InvalidCredentials';
}

/// Exception for general app errors
class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic originalError;

  const AppException(
    this.message, {
    this.code,
    this.originalError,
  });

  @override
  String toString() {
    if (code != null) {
      return 'AppException($code): $message';
    }
    return 'AppException: $message';
  }
}

/// Exception for network-related errors
class NetworkException implements Exception {
  final String message;
  final int? statusCode;

  const NetworkException(
    this.message, {
    this.statusCode,
  });

  @override
  String toString() {
    if (statusCode != null) {
      return 'NetworkException($statusCode): $message';
    }
    return 'NetworkException: $message';
  }
}

/// Exception for validation errors
class ValidationException implements Exception {
  final String message;
  final Map<String, List<String>>? fieldErrors;

  const ValidationException(
    this.message, {
    this.fieldErrors,
  });

  @override
  String toString() => 'ValidationException: $message';
}
