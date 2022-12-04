import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widget_test_practice/dbestech/bloc_sample/models/exercise.dart';
import 'package:widget_test_practice/dbestech/bloc_sample/models/workout.dart';

class WorkoutsCubit extends Cubit<List<Workout>> {
  WorkoutsCubit() : super([]);

  getWorkouts() async {
    final List<Workout> workouts = [];

    final workoutsJson =
        jsonDecode(await rootBundle.loadString('assets/workouts.json'));

    for (var item in (workoutsJson as Iterable)) {
      workouts.add(Workout.fromJson(item));
    }

    emit(workouts);
  }

  saveWorkout(Workout workout, int index) {
    Workout newWorkout = Workout(exercises: [], title: workout.title);
    int exIndex = 0;
    int startTime = 0;
    for (var ex in workout.exercises) {
      newWorkout.exercises.add(
        Exercise(
          title: ex.title,
          prelude: ex.prelude,
          duration: ex.duration,
          index: ex.index,
          startTime: ex.startTime,
        ),
      );
      exIndex++;
      startTime += ex.prelude! + ex.duration!;
    }

    state[index] = newWorkout;
    emit([...state]);
  }
}
