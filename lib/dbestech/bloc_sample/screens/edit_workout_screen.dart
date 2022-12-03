import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widget_test_practice/dbestech/bloc_sample/blocs/workout_cubit.dart';
import 'package:widget_test_practice/dbestech/bloc_sample/helpers.dart';
import 'package:widget_test_practice/dbestech/bloc_sample/models/exercise.dart';
import 'package:widget_test_practice/dbestech/bloc_sample/states/workout_state.dart';

class EditWorkoutScreen extends StatelessWidget {
  const EditWorkoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: BlocBuilder<WorkoutCubit, WorkoutState>(
        builder: (context, state) {
          WorkoutEditing we = state as WorkoutEditing;
          return Scaffold(
            appBar: AppBar(
              leading: BackButton(
                onPressed: () =>
                    BlocProvider.of<WorkoutCubit>(context).goHome(),
              ),
            ),
            body: ListView.builder(
              itemCount: we.workout!.exercises.length,
              itemBuilder: (context, index) {
                Exercise exercise = we.workout!.exercises[index];
                return ListTile(
                  leading: Text(formatTime(exercise.prelude!, true)),
                  title: Text(exercise.title!),
                  trailing: Text(formatTime(exercise.duration!, true)),
                  onTap: () => BlocProvider.of<WorkoutCubit>(context).editExercise(index),
                );
              },
            ),
          );
        },
      ),
      onWillPop: () {
        return BlocProvider.of<WorkoutCubit>(context).goHome();
      },
    );
  }
}
