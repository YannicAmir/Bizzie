class ServerException implements Exception {
  final String message;
  ServerException({required this.message});
}

class CacheException implements Exception {}

class SubscriptionException implements Exception {
  final String message;
  SubscriptionException({required this.message});
}

class UserNotSignedInException implements Exception {}
