import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widget_test_practice/dbestech/bloc_sample/blocs/workout_cubit.dart';
import 'package:widget_test_practice/dbestech/bloc_sample/blocs/workouts_cubit.dart';
import 'package:widget_test_practice/dbestech/bloc_sample/helpers.dart';
import 'package:widget_test_practice/dbestech/bloc_sample/models/exercise.dart';
import 'package:widget_test_practice/dbestech/bloc_sample/models/workout.dart';
import 'package:widget_test_practice/dbestech/bloc_sample/screens/edit_exersice_screen.dart';
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
              title: InkWell(
                onTap: () => showDialog(
                  context: context,
                  builder: (_) {
                    final controller =
                        TextEditingController(text: we.workout!.title);
                    return AlertDialog(
                      content: TextField(
                        controller: controller,
                        decoration: const InputDecoration(
                          labelText: 'Workout title',
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            if (controller.text.isNotEmpty) {
                              Navigator.pop(context);
                              Workout renamed = we.workout!.copyWith(title: controller.text);
                              BlocProvider.of<WorkoutsCubit>(context).saveWorkout(renamed, we.index);
                              BlocProvider.of<WorkoutCubit>(context).editWorkout(renamed, we.index);
                            }
                          },
                          child: const Text('Rename'),
                        )
                      ],
                    );
                  },
                ),
                child: Text(we.workout!.title!),
              ),
            ),
            body: ListView.builder(
              itemCount: we.workout!.exercises.length,
              itemBuilder: (context, index) {
                Exercise exercise = we.workout!.exercises[index];
                if (we.exIndex == index) {
                  return EditExerciseScreen(
                    index: we.index,
                    workout: we.workout,
                    exIndex: we.exIndex,
                  );
                } else {
                  return ListTile(
                    leading: Text(formatTime(exercise.prelude!, true)),
                    title: Text(exercise.title!),
                    trailing: Text(formatTime(exercise.duration!, true)),
                    onTap: () => BlocProvider.of<WorkoutCubit>(context)
                        .editExercise(index),
                  );
                }
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
