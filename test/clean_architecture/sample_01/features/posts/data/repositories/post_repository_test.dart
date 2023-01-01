import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:widget_test_practice/clean_architecture/sample_01/core/either.dart';
import 'package:widget_test_practice/clean_architecture/sample_01/core/error/failure.dart';
import 'package:widget_test_practice/clean_architecture/sample_01/features/posts/data/repositories/post_repository_impl.dart';
import 'package:widget_test_practice/clean_architecture/sample_01/features/posts/domain/entities/post.dart';
import 'package:widget_test_practice/clean_architecture/sample_01/features/posts/domain/repositories/post_repository.dart';

import '../../../../mocks/generated.mocks.dart';
import '../../../../mocks/mock_data.dart';

void main() {
  group(
    'PostRepository',
    () {
      late final MockPostRemoteDataSource dataSource;
      late final PostRepository repository;

      setUpAll(() {
        dataSource = MockPostRemoteDataSource();
        repository = PostRepositoryImpl(dataSource);
      });

      test(
        'fetching posts data successfully',
        () async {
          const List<Post> posts = mockPosts;
          when(dataSource.fetchPosts(any)).thenAnswer((_) async => mockPosts);

          final result = await repository.getPosts(1);

          expect(result, const Success(posts));
          verify(dataSource.fetchPosts(1));
          verifyNoMoreInteractions(dataSource);
        },
      );

      test(
        'fetching process gets DioError',
        () async {
          const errorMessage = 'Error happened';

          when(dataSource.fetchPosts(any)).thenThrow(
            DioError(
              requestOptions: RequestOptions(path: ''),
              error: errorMessage,
            ),
          );

          final result = await repository.getPosts(1);

          expect(result, const Error(Failure.network(errorMessage)));
          verify(dataSource.fetchPosts(1));
          verifyNoMoreInteractions(dataSource);
        },
      );

      test(
        'fetching process gets Exception',
        () async {
          when(dataSource.fetchPosts()).thenThrow(Exception());

          final result = await repository.getPosts();

          expect(result, const Error(Failure<String>.other()));
        },
      );
    },
  );
}
