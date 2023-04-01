import 'package:dartz/dartz.dart';
import 'package:widget_test_practice/clean_architecture/sample_02/core/error/failures.dart';
import 'package:widget_test_practice/clean_architecture/sample_02/core/usecase/usecase.dart';
import 'package:widget_test_practice/clean_architecture/sample_02/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:widget_test_practice/clean_architecture/sample_02/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:widget_test_practice/clean_architecture/sample_02/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';

class GetRandomNumberTrivia implements UseCase<TriviaNumber, NoParams> {
  final NumberTriviaRepository repository;

  GetRandomNumberTrivia(this.repository);

  @override
  Future<Either<Failure, TriviaNumber>> call(NoParams noParams) async {
    return await repository.getRandomNumberTrivia();
  }
}
