import 'package:dartz/dartz.dart';
import 'package:widget_test_practice/clean_architecture/sample_02/core/error/failures.dart';

class InputConvertor {
  Either<Failure, int> stringToUnsignedInteger(String str) {
    try {
      final result = int.parse(str);
      if (result >= 0) {
        return Right(result);
      } else {
        throw const FormatException();
      }
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}

class InvalidInputFailure extends Failure {}
