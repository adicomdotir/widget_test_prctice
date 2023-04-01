import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:widget_test_practice/clean_architecture/sample_02/core/error/failures.dart';
import 'package:widget_test_practice/clean_architecture/sample_02/core/usecase/usecase.dart';
import 'package:widget_test_practice/clean_architecture/sample_02/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:widget_test_practice/clean_architecture/sample_02/features/number_trivia/domain/repositories/number_trivia_repository.dart';

class GetConcreteNumberTrivia implements UseCase<TriviaNumber, Params> {
  final NumberTriviaRepository repository;

  GetConcreteNumberTrivia(this.repository);

  @override
  Future<Either<Failure, TriviaNumber>> call(Params params) async {
    return await repository.getConcreteNumberTrivia(params.number);
  }
}

class Params extends Equatable {
  final int number;

  const Params({required this.number});

  @override
  List<Object> get props => [number];
}
