import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widget_test_practice/dbestech/bloc_sample/blocs/workout_cubit.dart';
import 'package:widget_test_practice/dbestech/bloc_sample/helpers.dart';
import 'package:widget_test_practice/dbestech/bloc_sample/models/exercise.dart';
import 'package:widget_test_practice/dbestech/bloc_sample/models/workout.dart';
import 'package:widget_test_practice/dbestech/bloc_sample/states/workout_state.dart';

class WorkoutInProgressScreen extends StatelessWidget {
  const WorkoutInProgressScreen({Key? key}) : super(key: key);

  Map<String, dynamic> _getStats(Workout workout, int workoutElapsed) {
    int workoutTotal = workout.getTotal();
    Exercise exercise = workout.getCurrentExercise(workoutElapsed);
    int exerciseElapsed = workoutElapsed - exercise.startTime!;

    int exerciseRemaining = exercise.prelude! - exerciseElapsed;
    bool isPrelude = exerciseElapsed < exercise.prelude!;
    // int exerciseTotal = isPrelude ? exercise.prelude! : exercise.duration!;

    if (!isPrelude) {
      exerciseElapsed -= exercise.prelude!;
      exerciseRemaining += exercise.duration!;
    }

    return {
      'workoutTitle': workout.title,
      'workoutProgress': workoutElapsed / workoutTotal,
      'workoutElapsed': workoutElapsed,
      'totalExercise': workout.exercises.length,
      'currentExerciseIndex': exercise.index!.toDouble(),
      'workoutRemaining': workoutTotal - workoutElapsed,
      'exerciseRemaining': exerciseRemaining,
    };
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WorkoutCubit, WorkoutState>(
      builder: (context, state) {
        final stats = _getStats(state.workout!, state.elapsed!);
        return Scaffold(
          appBar: AppBar(
            title: Text(state.workout!.title.toString()),
            leading: BackButton(
              onPressed: () => BlocProvider.of<WorkoutCubit>(context).goHome(),
            ),
          ),
          body: Container(
            padding: const EdgeInsets.all(32),
            child: Column(
              children: [
                LinearProgressIndicator(
                  backgroundColor: Colors.blue[100],
                  minHeight: 10,
                  value: stats['workoutProgress'],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(formatTime(stats['workoutElapsed'], true)),
                      Text('-${formatTime(stats['workoutRemaining'], true)}'),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
