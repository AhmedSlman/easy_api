import 'package:dio/dio.dart';
import 'api_consumer.dart';
import '../exceptions/api_exceptions.dart';
import '../utils/cache_helper.dart';

/// A concrete implementation of [ApiConsumer] that uses the Dio package
/// for making HTTP requests.
/// 
/// This class provides a simple and flexible way to make HTTP requests
/// with built-in token management, error handling, and logging.
class EasyApi extends ApiConsumer {
  /// The Dio instance used for making HTTP requests.
  final Dio dio;

  /// The base URL for all requests.
  final String? baseUrl;

  /// The authentication token to use for requests.
  final String? token;

  /// The default headers to include in all requests.
  final Map<String, String> defaultHeaders;

  /// Whether to enable request/response logging.
  final bool enableLogging;

  /// Creates a new instance of [EasyApi].
  /// 
  /// [dio] is an optional Dio instance to use. If not provided, a new instance
  /// will be created.
  /// [baseUrl] is the base URL for all requests.
  /// [token] is the authentication token to use for requests.
  /// [defaultHeaders] are the default headers to include in all requests.
  /// [enableLogging] determines whether to enable request/response logging.
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

  /// Gets the headers to use for a request.
  /// 
  /// [additionalHeaders] are optional additional headers to include.
  /// 
  /// Returns a map of headers to use for the request.
  Map<String, String> getHeaders(Map<String, dynamic>? additionalHeaders) {
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

  /// Handles Dio exceptions and converts them to appropriate [ApiException]s.
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
        options: Options(headers: getHeaders(headers)),
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
        options: Options(headers: getHeaders(headers)),
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
        options: Options(headers: getHeaders(headers)),
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
        options: Options(headers: getHeaders(headers)),
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
        options: Options(headers: getHeaders(headers)),
      );
      return response.data;
    } on DioException catch (e) {
      _handleDioException(e);
    }
  }
} 