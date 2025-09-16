class ServerException implements Exception {
  final String message;
  final String code;

  const ServerException(this.code, this.message);
}
