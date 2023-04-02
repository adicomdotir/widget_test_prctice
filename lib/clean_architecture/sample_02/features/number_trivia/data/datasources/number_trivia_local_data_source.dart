import 'package:widget_test_practice/clean_architecture/sample_02/features/number_trivia/domain/entities/number_trivia.dart';

abstract class NumberTriviaLocalDataSource {
  Future<void> cacheNumberTrivia(TriviaNumber remoteTrivia);

  Future<TriviaNumber> getLastNumberTrivia();
}
