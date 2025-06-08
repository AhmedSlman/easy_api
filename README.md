<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

# Easy API

A Flutter package that makes API calls easy and maintainable. This package provides a simple and flexible way to make HTTP requests with built-in error handling, logging, and token management.

## Features

- 🚀 Simple and intuitive API
- 🔒 Built-in token management
- 📝 Comprehensive error handling
- 📊 Request/Response logging
- 🔄 Support for all HTTP methods (GET, POST, PUT, PATCH, DELETE)
- 📦 Form data support
- 🛠️ Customizable headers and base URL
- ⚡ Efficient and performant

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  easy_api: ^0.1.0
```

## Usage

### Basic Setup

```dart
import 'package:easy_api/easy_api.dart';

// Create an instance of DioConsumer
final api = DioConsumer(
  baseUrl: 'https://api.example.com',
  token: 'your-auth-token', // Optional
);

// Make API calls
try {
  // GET request
  final response = await api.get('/users');

  // POST request
  final data = await api.post(
    '/users',
    data: {'name': 'John Doe', 'email': 'john@example.com'},
  );

  // PUT request with form data
  final formData = await api.put(
    '/users/1',
    data: {'avatar': File('path/to/avatar.jpg')},
    isFormData: true,
  );
} catch (e) {
  if (e is ApiException) {
    print('API Error: ${e.message}');
  }
}
```

### Custom Headers

```dart
final api = DioConsumer(
  baseUrl: 'https://api.example.com',
  defaultHeaders: {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'X-Custom-Header': 'value',
  },
);

// Add additional headers for specific requests
final response = await api.get(
  '/users',
  headers: {'X-Request-ID': '123'},
);
```

### Error Handling

The package provides specific exceptions for different error scenarios:

```dart
try {
  final response = await api.get('/users');
} on BadRequestException catch (e) {
  print('Bad Request: ${e.message}');
} on UnauthorizedException catch (e) {
  print('Unauthorized: ${e.message}');
} on ForbiddenException catch (e) {
  print('Forbidden: ${e.message}');
} on NotFoundException catch (e) {
  print('Not Found: ${e.message}');
} on ServerException catch (e) {
  print('Server Error: ${e.message}');
} on ConnectionException catch (e) {
  print('Connection Error: ${e.message}');
} on ApiException catch (e) {
  print('API Error: ${e.message}');
}
```

## API Reference

### DioConsumer

The main class for making API requests.

#### Constructor

```dart
DioConsumer({
  Dio? dio,
  String? baseUrl,
  String? token,
  Map<String, String> defaultHeaders = const {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  },
  bool enableLogging = true,
})
```

#### Methods

- `get(String path, {Map<String, dynamic>? queryParameters, Map<String, dynamic>? headers})`
- `post(String path, {Object? data, Map<String, dynamic>? queryParameters, Map<String, dynamic>? headers, bool isFormData = false})`
- `put(String path, {Object? data, Map<String, dynamic>? queryParameters, Map<String, dynamic>? headers, bool isFormData = false})`
- `patch(String path, {Object? data, Map<String, dynamic>? queryParameters, Map<String, dynamic>? headers, bool isFormData = false})`
- `delete(String path, {Object? data, Map<String, dynamic>? queryParameters, Map<String, dynamic>? headers, bool isFormData = false})`

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
