import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widget_test_practice/clean_architecture/sample_02/core/error/failures.dart';
import 'package:widget_test_practice/clean_architecture/sample_02/core/usecase/usecase.dart';
import 'package:widget_test_practice/clean_architecture/sample_02/core/util/input_converter.dart';
import 'package:widget_test_practice/clean_architecture/sample_02/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:widget_test_practice/clean_architecture/sample_02/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:widget_test_practice/clean_architecture/sample_02/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:widget_test_practice/clean_architecture/sample_02/features/number_trivia/presentation/bloc/number_trivia_event.dart';
import 'package:widget_test_practice/clean_architecture/sample_02/features/number_trivia/presentation/bloc/number_trivia_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero.';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConvertor inputConvertor;

  NumberTriviaBloc({
    required this.getConcreteNumberTrivia,
    required this.getRandomNumberTrivia,
    required this.inputConvertor,
  }) : super(Empty()) {
    on<GetTriviaForConcreteNumber>((event, emit) {
      final inputEither =
          inputConvertor.stringToUnsignedInteger(event.numberString);

      inputEither.fold(
        (failure) => emit(ErrorState(message: INVALID_INPUT_FAILURE_MESSAGE)),
        (integer) async {
          emit(Loading());
          final failureOrTrivia = await getConcreteNumberTrivia(
            Params(number: integer),
          );
          emit(_eitherLoadedOrErrorState(failureOrTrivia));
        },
      );
    });

    on<GetTriviaForRandomNumber>((event, emit) async {
      emit(Loading());
      final failureOrTrivia = await getRandomNumberTrivia(
        NoParams(),
      );
      emit(_eitherLoadedOrErrorState(failureOrTrivia));
    });
  }

  NumberTriviaState _eitherLoadedOrErrorState(
    Either<Failure, TriviaNumber> failureOrTrivia,
  ) {
    return failureOrTrivia.fold(
      (failure) => ErrorState(message: _mapFailureToMessage(failure)),
      (trivia) => Loaded(trivia: trivia),
    );
  }

  _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}
