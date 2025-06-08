import 'package:flutter_test/flutter_test.dart';

import 'package:easy_api/easy_api.dart';

void main() {
  group('EasyApi', () {
    late EasyApi api;

    setUp(() {
      api = EasyApi(
        baseUrl: 'https://jsonplaceholder.typicode.com',
      );
    });

    test('should create instance with default values', () {
      expect(api.baseUrl, 'https://jsonplaceholder.typicode.com');
      expect(api.enableLogging, true);
    });

    test('should have correct default headers', () {
      final headers = api._getHeaders(null);
      expect(headers['Accept'], 'application/json');
      expect(headers['Content-Type'], 'application/json');
    });
  });
}
