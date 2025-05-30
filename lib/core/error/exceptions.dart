class ServerException implements Exception {
  final String message;
  const ServerException(this.message);
}

class SecureStorageException implements Exception {
  final String message;
  SecureStorageException(this.message);
}
