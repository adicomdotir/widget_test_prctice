import 'package:widget_test_practice/clean_architecture/sample_01/core/either.dart';
import 'package:widget_test_practice/clean_architecture/sample_01/core/error/failure.dart';
import 'package:widget_test_practice/clean_architecture/sample_01/features/posts/data/models/post_model.dart';

abstract class PostRepository {
  Future<Either<Failure<String>, List<PostModel>>>  getPosts([int? userId]);
}