class CaptchaException implements Exception {
  final String message;
  final int statusCode;

  CaptchaException(this.message, this.statusCode);

  @override
  String toString() => 'CaptchaException : $message (Status code: $statusCode)';
}
