/// Custom exceptions for API-related errors
class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic data;

  ApiException({required this.message, this.statusCode, this.data});

  @override
  String toString() =>
      'ApiException: $message${statusCode != null ? ' (Status: $statusCode)' : ''}';
}

class BadRequestException extends ApiException {
  BadRequestException({
    String message = 'Bad Request',
    int? statusCode,
    dynamic data,
  }) : super(message: message, statusCode: statusCode, data: data);
}

class UnauthorizedException extends ApiException {
  UnauthorizedException({
    String message = 'Unauthorized',
    int? statusCode,
    dynamic data,
  }) : super(message: message, statusCode: statusCode, data: data);
}

class ForbiddenException extends ApiException {
  ForbiddenException({
    String message = 'Forbidden',
    int? statusCode,
    dynamic data,
  }) : super(message: message, statusCode: statusCode, data: data);
}

class NotFoundException extends ApiException {
  NotFoundException({
    String message = 'Not Found',
    int? statusCode,
    dynamic data,
  }) : super(message: message, statusCode: statusCode, data: data);
}

class ServerException extends ApiException {
  ServerException({
    String message = 'Server Error',
    int? statusCode,
    dynamic data,
  }) : super(message: message, statusCode: statusCode, data: data);
}

class ConnectionException extends ApiException {
  ConnectionException({
    super.message = 'No Internet Connection',
    super.statusCode,
    super.data,
  });
}
