sealed class ApiException implements Exception {
  const ApiException();

  factory ApiException.server({
    required int statusCode,
    required String body,
  }) = ServerApiException;

  factory ApiException.network({required String message}) = NetworkApiException;

  factory ApiException.timeout() = TimeoutApiException;
}

final class ServerApiException extends ApiException {
  final int statusCode;
  final String body;

  const ServerApiException({
    required this.statusCode,
    required this.body,
  });

  @override
  String toString() => 'ServerApiException($statusCode): $body';
}

final class NetworkApiException extends ApiException {
  final String message;

  const NetworkApiException({required this.message});

  @override
  String toString() => 'NetworkApiException: $message';
}

final class TimeoutApiException extends ApiException {
  const TimeoutApiException();

  @override
  String toString() => 'TimeoutApiException: request timed out';
}
