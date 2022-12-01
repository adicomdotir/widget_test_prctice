import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widget_test_practice/dbestech/bloc_sample/models/workout.dart';

class WorkoutsCubit extends Cubit<List<Workout>> {
  WorkoutsCubit() : super([]);

  getWorkouts() async {
    final List<Workout> workouts = [];

    final workoutsJson = jsonDecode(await rootBundle.loadString('assets/workouts.json'));

    for(var item in (workoutsJson as Iterable)) {
      workouts.add(Workout.fromJson(item));
    }

    emit(workouts);
  }
}