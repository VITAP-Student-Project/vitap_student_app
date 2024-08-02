class InvalidCaptchaException implements Exception {
  final String message;
  final int statusCode;

  InvalidCaptchaException(this.message, this.statusCode);

  @override
  String toString() => 'CaptchaException : $message (Status code: $statusCode)';
}
