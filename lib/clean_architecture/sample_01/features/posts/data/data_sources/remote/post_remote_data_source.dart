import 'package:dio/dio.dart';
import 'package:widget_test_practice/clean_architecture/sample_01/features/posts/data/models/post_model.dart';

abstract class PostRemoteDataSource {
  Future<List<PostModel>> fetchPosts([int? userId]);
}

class PostRemoteDataSourceImpl extends PostRemoteDataSource {
  final Dio dio;

  PostRemoteDataSourceImpl(this.dio);

  @override
  Future<List<PostModel>> fetchPosts([int? userId]) async {
    final result = await dio.get(
      '/posts',
      queryParameters: {
        if (userId != null) 'userId': userId,
      },
    );
    return (result.data as List<dynamic>)
        .map((post) => PostModel.fromJson(post))
        .toList();
  }
}
