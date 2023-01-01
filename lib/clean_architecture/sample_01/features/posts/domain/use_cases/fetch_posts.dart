import 'package:widget_test_practice/clean_architecture/sample_01/core/either.dart';
import 'package:widget_test_practice/clean_architecture/sample_01/core/error/failure.dart';
import 'package:widget_test_practice/clean_architecture/sample_01/core/use_cases/use_case.dart';
import 'package:widget_test_practice/clean_architecture/sample_01/features/posts/domain/entities/post.dart';
import 'package:widget_test_practice/clean_architecture/sample_01/features/posts/domain/repositories/post_repository.dart';

class FetchPosts extends UseCase<String, List<Post>, int?> {
  final PostRepository repository;

  FetchPosts(this.repository);

  @override
  Future<Either<Failure<String>, List<Post>>> call([int? params]) {
    return repository.getPosts(params);
  }
}