import 'package:easy_api/easy_api.dart';
import 'package:easy_api/api_exceptions.dart';

void main() async {
  // Create an instance of DioConsumer
  final api = DioConsumer(
    baseUrl: 'https://jsonplaceholder.typicode.com',
    enableLogging: true,
  );

  try {
    // Example 1: GET request
    print('Fetching users...');
    final users = await api.get('/users');
    print('Users: $users');

    // Example 2: POST request
    print('\nCreating a new post...');
    final newPost = await api.post(
      '/posts',
      data: {
        'title': 'Hello World',
        'body': 'This is a test post',
        'userId': 1,
      },
    );
    print('New post: $newPost');

    // Example 3: PUT request
    print('\nUpdating a post...');
    final updatedPost = await api.put(
      '/posts/1',
      data: {
        'title': 'Updated Title',
        'body': 'Updated body content',
        'userId': 1,
      },
    );
    print('Updated post: $updatedPost');

    // Example 4: PATCH request
    print('\nPartially updating a post...');
    final patchedPost = await api.patch(
      '/posts/1',
      data: {
        'title': 'Patched Title',
      },
    );
    print('Patched post: $patchedPost');

    // Example 5: DELETE request
    print('\nDeleting a post...');
    final deletedPost = await api.delete('/posts/1');
    print('Deleted post: $deletedPost');
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
}
