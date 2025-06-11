/// An abstract class that defines the interface for making HTTP requests.
///
/// This class provides a contract for implementing HTTP clients that can make
/// GET, POST, PATCH, PUT, and DELETE requests.
abstract class ApiConsumer {
  /// Makes a GET request to the specified [path].
  ///
  /// [queryParameters] are optional query parameters to include in the request.
  /// [headers] are optional headers to include in the request.
  ///
  /// Returns the response data.
  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });

  /// Makes a POST request to the specified [path].
  ///
  /// [data] is the data to send in the request body.
  /// [queryParameters] are optional query parameters to include in the request.
  /// [headers] are optional headers to include in the request.
  /// [isFormData] determines whether to send the data as form data.
  ///
  /// Returns the response data.
  Future<dynamic> post(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    bool isFormData = false,
  });

  /// Makes a PATCH request to the specified [path].
  ///
  /// [data] is the data to send in the request body.
  /// [queryParameters] are optional query parameters to include in the request.
  /// [headers] are optional headers to include in the request.
  /// [isFormData] determines whether to send the data as form data.
  ///
  /// Returns the response data.
  Future<dynamic> patch(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    bool isFormData = false,
  });

  /// Makes a PUT request to the specified [path].
  ///
  /// [data] is the data to send in the request body.
  /// [queryParameters] are optional query parameters to include in the request.
  /// [headers] are optional headers to include in the request.
  /// [isFormData] determines whether to send the data as form data.
  ///
  /// Returns the response data.
  Future<dynamic> put(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    bool isFormData = false,
  });

  /// Makes a DELETE request to the specified [path].
  ///
  /// [data] is the data to send in the request body.
  /// [queryParameters] are optional query parameters to include in the request.
  /// [headers] are optional headers to include in the request.
  /// [isFormData] determines whether to send the data as form data.
  ///
  /// Returns the response data.
  Future<dynamic> delete(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    bool isFormData = false,
  });
} 