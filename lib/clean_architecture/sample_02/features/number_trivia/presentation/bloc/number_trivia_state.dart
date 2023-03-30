abstract class NumberTriviaState {}

class Empty extends NumberTriviaState {}

class Loading extends NumberTriviaState {}

class ErrorState extends NumberTriviaState {
  final String message;
  ErrorState({required this.message});
}

class Loaded extends NumberTriviaState {
  final TriviaNumber trivia;
  Loaded({required this.trivia});
}
