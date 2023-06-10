class ServerException implements Exception {}

class DatabaseException implements Exception {
  DatabaseException(this.message);
  final String message;
}
