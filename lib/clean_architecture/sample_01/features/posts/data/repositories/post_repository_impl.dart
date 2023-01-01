import 'package:dio/dio.dart';
import 'package:widget_test_practice/clean_architecture/sample_01/core/either.dart';
import 'package:widget_test_practice/clean_architecture/sample_01/core/error/failure.dart';
import 'package:widget_test_practice/clean_architecture/sample_01/features/posts/data/data_sources/remote/post_remote_data_source.dart';
import 'package:widget_test_practice/clean_architecture/sample_01/features/posts/data/models/post_model.dart';
import 'package:widget_test_practice/clean_architecture/sample_01/features/posts/domain/repositories/post_repository.dart';

class PostRepositoryImpl extends PostRepository {
  final PostRemoteDataSource remoteDataSource;

  PostRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure<String>, List<PostModel>>> getPosts([int? userId]) async {
    try {
      final result = await remoteDataSource.fetchPosts(userId);
      return Success(result);
    } on DioError catch (e) {
      return Error(Failure.network(e.message));
    } catch (_) {
      return const Error(Failure.other());
    }
  }

}