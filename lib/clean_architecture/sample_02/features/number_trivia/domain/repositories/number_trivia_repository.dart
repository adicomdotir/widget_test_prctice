import 'package:dartz/dartz.dart';
import 'package:widget_test_practice/clean_architecture/sample_02/core/error/failures.dart';
import 'package:widget_test_practice/clean_architecture/sample_02/features/number_trivia/domain/entities/number_trivia.dart';

abstract class NumberTriviaRepository {
  Future<Either<Failure, TriviaNumber>> getConcreteNumberTrivia(int number);

  Future<Either<Failure, TriviaNumber>> getRandomNumberTrivia();
}
