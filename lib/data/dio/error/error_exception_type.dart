/// Timeout error
class TimeoutException implements Exception {
  final String message;
  TimeoutException(this.message);

  @override
  String toString() => message;
}

/// Server error
class ServerException implements Exception {
  final String message;
  final int? statusCode;
  ServerException(this.message, {this.statusCode});

  @override
  String toString() => message;
}

// Token missing error
class TokenMissingException implements Exception {
  final String message;
  TokenMissingException(this.message);

  @override
  String toString() => message;
}

/// Network error
class NetworkException implements Exception {
  final String message;
  NetworkException(this.message);

  @override
  String toString() => message;
}
