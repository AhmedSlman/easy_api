import 'package:dio/dio.dart';
import 'api_consumer.dart';
import 'api_exceptions.dart';
import 'cache_helper.dart';

class EasyApi extends ApiConsumer {
  final Dio dio;
  final String? baseUrl;
  final String? token;
  final Map<String, String> defaultHeaders;
  final bool enableLogging;

  EasyApi({
    Dio? dio,
    this.baseUrl,
    this.token,
    this.defaultHeaders = const {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    },
    this.enableLogging = true,
  }) : dio = dio ?? Dio() {
    if (baseUrl != null) {
      this.dio.options.baseUrl = baseUrl!;
    }

    if (enableLogging) {
      this.dio.interceptors.add(
            LogInterceptor(
              request: true,
              requestBody: true,
              requestHeader: true,
              responseBody: true,
              responseHeader: true,
              error: true,
            ),
          );
    }
  }

  Map<String, String> _getHeaders(Map<String, dynamic>? additionalHeaders) {
    final headers = Map<String, String>.from(defaultHeaders);
    final authToken = token ?? CacheHelper.getToken();
    if (authToken != null) {
      headers['Authorization'] = 'Bearer $authToken';
    }
    if (additionalHeaders != null) {
      headers.addAll(Map<String, String>.from(additionalHeaders));
    }
    return headers;
  }

  void _handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw ConnectionException(
          message: 'Connection timeout',
          statusCode: e.response?.statusCode,
          data: e.response?.data,
        );
      case DioExceptionType.badResponse:
        switch (e.response?.statusCode) {
          case 400:
            throw BadRequestException(
              message: e.response?.data['message'] ?? 'Bad Request',
              statusCode: e.response?.statusCode,
              data: e.response?.data,
            );
          case 401:
            throw UnauthorizedException(
              message: e.response?.data['message'] ?? 'Unauthorized',
              statusCode: e.response?.statusCode,
              data: e.response?.data,
            );
          case 403:
            throw ForbiddenException(
              message: e.response?.data['message'] ?? 'Forbidden',
              statusCode: e.response?.statusCode,
              data: e.response?.data,
            );
          case 404:
            throw NotFoundException(
              message: e.response?.data['message'] ?? 'Not Found',
              statusCode: e.response?.statusCode,
              data: e.response?.data,
            );
          case 500:
          case 501:
          case 502:
          case 503:
            throw ServerException(
              message: e.response?.data['message'] ?? 'Server Error',
              statusCode: e.response?.statusCode,
              data: e.response?.data,
            );
          default:
            throw ApiException(
              message: e.response?.data['message'] ?? 'Unknown Error',
              statusCode: e.response?.statusCode,
              data: e.response?.data,
            );
        }
      case DioExceptionType.cancel:
        throw ApiException(message: 'Request cancelled');
      case DioExceptionType.unknown:
        throw ConnectionException(
          message: 'No Internet Connection',
          data: e.error,
        );
      default:
        throw ApiException(message: 'Unknown Error', data: e.error);
    }
  }

  @override
  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await dio.get(
        path,
        queryParameters: queryParameters,
        options: Options(headers: _getHeaders(headers)),
      );
      return response.data;
    } on DioException catch (e) {
      _handleDioException(e);
    }
  }

  @override
  Future<dynamic> post(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    bool isFormData = false,
  }) async {
    try {
      final requestData = isFormData && data is Map<String, dynamic>
          ? FormData.fromMap(data)
          : data;

      final response = await dio.post(
        path,
        data: requestData,
        queryParameters: queryParameters,
        options: Options(headers: _getHeaders(headers)),
      );
      return response.data;
    } on DioException catch (e) {
      _handleDioException(e);
    }
  }

  @override
  Future<dynamic> patch(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    bool isFormData = false,
  }) async {
    try {
      final requestData = isFormData && data is Map<String, dynamic>
          ? FormData.fromMap(data)
          : data;

      final response = await dio.patch(
        path,
        data: requestData,
        queryParameters: queryParameters,
        options: Options(headers: _getHeaders(headers)),
      );
      return response.data;
    } on DioException catch (e) {
      _handleDioException(e);
    }
  }

  @override
  Future<dynamic> put(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    bool isFormData = false,
  }) async {
    try {
      final requestData = isFormData && data is Map<String, dynamic>
          ? FormData.fromMap(data)
          : data;

      final response = await dio.put(
        path,
        data: requestData,
        queryParameters: queryParameters,
        options: Options(headers: _getHeaders(headers)),
      );
      return response.data;
    } on DioException catch (e) {
      _handleDioException(e);
    }
  }

  @override
  Future<dynamic> delete(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    bool isFormData = false,
  }) async {
    try {
      final requestData = isFormData && data is Map<String, dynamic>
          ? FormData.fromMap(data)
          : data;

      final response = await dio.delete(
        path,
        data: requestData,
        queryParameters: queryParameters,
        options: Options(headers: _getHeaders(headers)),
      );
      return response.data;
    } on DioException catch (e) {
      _handleDioException(e);
    }
  }
}
