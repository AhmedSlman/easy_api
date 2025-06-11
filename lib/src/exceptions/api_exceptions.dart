/// Base class for all API-related exceptions.
/// 
/// This class provides a common interface for all API exceptions,
/// including a message, status code, and optional data.
class ApiException implements Exception {
  /// The error message.
  final String message;

  /// The HTTP status code, if available.
  final int? statusCode;

  /// Additional error data, if available.
  final dynamic data;

  /// Creates a new instance of [ApiException].
  /// 
  /// [message] is the error message.
  /// [statusCode] is the optional HTTP status code.
  /// [data] is optional additional error data.
  ApiException({
    required this.message,
    this.statusCode,
    this.data,
  });

  @override
  String toString() => 'ApiException: $message${statusCode != null ? ' (Status: $statusCode)' : ''}';
}

/// Exception thrown when there is a connection error.
/// 
/// This exception is typically thrown when there is no internet connection
/// or when a connection timeout occurs.
class ConnectionException extends ApiException {
  /// Creates a new instance of [ConnectionException].
  /// 
  /// [message] is the error message.
  /// [statusCode] is the optional HTTP status code.
  /// [data] is optional additional error data.
  ConnectionException({
    required super.message,
    super.statusCode,
    super.data,
  });
}

/// Exception thrown when there is a server error.
/// 
/// This exception is typically thrown when the server returns a 5xx status code.
class ServerException extends ApiException {
  /// Creates a new instance of [ServerException].
  /// 
  /// [message] is the error message.
  /// [statusCode] is the optional HTTP status code.
  /// [data] is optional additional error data.
  ServerException({
    required super.message,
    super.statusCode,
    super.data,
  });
}

/// Exception thrown when there is a bad request.
/// 
/// This exception is typically thrown when the server returns a 400 status code.
class BadRequestException extends ApiException {
  /// Creates a new instance of [BadRequestException].
  /// 
  /// [message] is the error message.
  /// [statusCode] is the optional HTTP status code.
  /// [data] is optional additional error data.
  BadRequestException({
    required super.message,
    super.statusCode,
    super.data,
  });
}

/// Exception thrown when the request is unauthorized.
/// 
/// This exception is typically thrown when the server returns a 401 status code.
class UnauthorizedException extends ApiException {
  /// Creates a new instance of [UnauthorizedException].
  /// 
  /// [message] is the error message.
  /// [statusCode] is the optional HTTP status code.
  /// [data] is optional additional error data.
  UnauthorizedException({
    required super.message,
    super.statusCode,
    super.data,
  });
}

/// Exception thrown when the request is forbidden.
/// 
/// This exception is typically thrown when the server returns a 403 status code.
class ForbiddenException extends ApiException {
  /// Creates a new instance of [ForbiddenException].
  /// 
  /// [message] is the error message.
  /// [statusCode] is the optional HTTP status code.
  /// [data] is optional additional error data.
  ForbiddenException({
    required super.message,
    super.statusCode,
    super.data,
  });
}

/// Exception thrown when the requested resource is not found.
/// 
/// This exception is typically thrown when the server returns a 404 status code.
class NotFoundException extends ApiException {
  /// Creates a new instance of [NotFoundException].
  /// 
  /// [message] is the error message.
  /// [statusCode] is the optional HTTP status code.
  /// [data] is optional additional error data.
  NotFoundException({
    required super.message,
    super.statusCode,
    super.data,
  });
} 