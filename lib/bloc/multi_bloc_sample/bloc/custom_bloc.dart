import 'package:bloc/bloc.dart';
import 'package:widget_test_practice/bloc/multi_bloc_sample/bloc/CountStatus.dart';

part 'custom_event.dart';
part 'custom_state.dart';

class CustomBloc extends Bloc<CustomEvent, CustomState> {
  CustomBloc()
      : super(
          CustomState(
            countStatus1: CountStatusCompleted(0),
            countStatus2: CountStatusCompleted(0),
          ),
        ) {
    on<CustomEvent1>((event, emit) {
      emit(
        state.copyWith(
          newCountStatus1: CountStatusCompleted(event.count + 1),
        ),
      );
    });

    on<CustomEvent2>((event, emit) {
      if (event.count < 10) {
        emit(
          state.copyWith(
            newCountStatus2: CountStatusCompleted(event.count + 1),
          ),
        );
      } else {
        emit(
          state.copyWith(
            newCountStatus2: CountStatusError('Number bigger than 10!'),
          ),
        );
      }
    });

    on<ResetEvent>((event, emit) {
      emit(
        state.copyWith(
          newCountStatus2: CountStatusCompleted(event.count),
        ),
      );
    });
  }
}
