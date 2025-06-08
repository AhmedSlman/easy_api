/// A Flutter package that makes API calls easy and maintainable.
///
/// This package provides a simple and flexible way to make HTTP requests
/// with built-in error handling, logging, and token management.
library easy_api;

export 'api_consumer.dart';
export 'dio_consumer.dart';
export 'api_interceptors.dart';
export 'api_exceptions.dart';

/// A Calculator.
class Calculator {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;
}
