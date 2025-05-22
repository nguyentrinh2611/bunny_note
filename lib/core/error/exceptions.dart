// ignore_for_file: public_member_api_docs, sort_constructors_first
class ServerException implements Exception {
  final String? errorCode;
  ServerException({
    this.errorCode,
  });
}

class NetworkException implements Exception {}

class CacheException implements Exception {}

class AuthException implements Exception {
  final String errorCode;
  AuthException({
    required this.errorCode,
  });
}
