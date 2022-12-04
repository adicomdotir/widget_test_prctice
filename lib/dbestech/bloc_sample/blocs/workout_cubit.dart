import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widget_test_practice/dbestech/bloc_sample/models/workout.dart';
import 'package:widget_test_practice/dbestech/bloc_sample/states/workout_state.dart';
import 'package:wakelock/wakelock.dart';

class WorkoutCubit extends Cubit<WorkoutState> {
  Timer? _timer;

  WorkoutCubit() : super(const WorkoutInitial());

  editWorkout(Workout workout, int index) =>
      emit(WorkoutEditing(workout, index, null));

  editExercise(int? exIndex) => emit(
      WorkoutEditing(state.workout, (state as WorkoutEditing).index, exIndex));

  goHome() {
    emit(const WorkoutInitial());
  }

  onTick(Timer timer) {
    if (state is WorkoutInProgress) {
      WorkoutInProgress wip = state as WorkoutInProgress;
      if (wip.elapsed! < wip.workout!.getTotal()) {
        emit(WorkoutInProgress(wip.workout, wip.elapsed! + 1));
      } else {
        _timer!.cancel();
        Wakelock.disable();
        emit(const WorkoutInitial());
      }
    }
  }

  startWorkout(Workout workout, [int? index]) {
    Wakelock.enable();
    if (index != null) {
    } else {
      emit(WorkoutInProgress(workout, 0));
    }

    _timer = Timer.periodic(const Duration(seconds: 1), onTick);
  }
}
