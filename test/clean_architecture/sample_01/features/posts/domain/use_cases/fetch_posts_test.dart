import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:widget_test_practice/clean_architecture/sample_01/core/either.dart';
import 'package:widget_test_practice/clean_architecture/sample_01/core/error/failure.dart';
import 'package:widget_test_practice/clean_architecture/sample_01/features/posts/domain/use_cases/fetch_posts.dart';

import '../../../../mocks/generated.mocks.dart';
import '../../../../mocks/mock_data.dart';

void main() {
  group(
    'FetchPosts',
    () {
      late final MockPostRepository repository;
      late final FetchPosts fetchPosts;

      setUpAll(() {
        repository = MockPostRepository();
        fetchPosts = FetchPosts(repository);
      });

      test('gets posts successfully', () async {
        when(repository.getPosts(any)).thenAnswer(
          (_) async => const Success(mockPosts),
        );

        final result = await fetchPosts(1);

        expect(result, equals(const Success(mockPosts)));
      });

      test('gets users failed', () async {
        const error = 'Error happened';

        when(repository.getPosts(any)).thenAnswer(
          (_) async => const Error(Failure.network(error)),
        );

        final result = await fetchPosts(1);

        expect(result, equals(const Error(Failure.network(error))));
      });
    },
  );
}
