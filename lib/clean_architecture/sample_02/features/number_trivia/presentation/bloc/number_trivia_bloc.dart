import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widget_test_practice/clean_architecture/sample_02/features/number_trivia/presentation/bloc/number_trivia_event.dart';
import 'package:widget_test_practice/clean_architecture/sample_02/features/number_trivia/presentation/bloc/number_trivia_state.dart';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  NumberTriviaBloc(NumberTriviaState initialState) : super(initialState);
}
