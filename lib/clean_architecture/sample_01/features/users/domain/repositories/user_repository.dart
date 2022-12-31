import 'package:widget_test_practice/clean_architecture/sample_01/core/either.dart';
import 'package:widget_test_practice/clean_architecture/sample_01/core/error/failure.dart';
import 'package:widget_test_practice/clean_architecture/sample_01/shared/data/models/user_model.dart';

abstract class UserRepository {
  Future<Either<Failure<String>, List<UserModel>>> getUsers();
}