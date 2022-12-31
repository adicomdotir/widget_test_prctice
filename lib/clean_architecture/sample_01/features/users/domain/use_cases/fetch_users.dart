import 'package:widget_test_practice/clean_architecture/sample_01/core/either.dart';
import 'package:widget_test_practice/clean_architecture/sample_01/core/error/failure.dart';
import 'package:widget_test_practice/clean_architecture/sample_01/core/use_cases/use_case.dart';
import 'package:widget_test_practice/clean_architecture/sample_01/features/users/domain/repositories/user_repository.dart';

import '../user.dart';

class FetchUsers extends UseCase<String, List<User>, NoParams> {
  final UserRepository repository;

  FetchUsers(this.repository);

  @override
  Future<Either<Failure<String>, List<User>>> call(NoParams params) {
    return repository.getUsers();
  }
}