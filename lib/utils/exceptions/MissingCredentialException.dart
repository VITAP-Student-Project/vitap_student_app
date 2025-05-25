class MissingCredentialsException implements Exception {
  final String message;
  MissingCredentialsException(this.message);

  @override
  String toString() => message;
}
