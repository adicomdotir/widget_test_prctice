import 'package:dartz/dartz.dart';
import 'package:widget_test_practice/clean_architecture/sample_02/core/error/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {}
