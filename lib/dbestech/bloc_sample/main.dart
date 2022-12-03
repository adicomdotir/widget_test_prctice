import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widget_test_practice/dbestech/bloc_sample/blocs/workout_cubit.dart';
import 'package:widget_test_practice/dbestech/bloc_sample/blocs/workouts_cubit.dart';
import 'package:widget_test_practice/dbestech/bloc_sample/screens/edit_workout_screen.dart';
import 'package:widget_test_practice/dbestech/bloc_sample/screens/home_page.dart';
import 'package:widget_test_practice/dbestech/bloc_sample/states/workout_state.dart';

import 'models/workout.dart';

void main() {
  runApp(const WorkoutTime());
}

class WorkoutTime extends StatelessWidget {
  const WorkoutTime({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Workouts',
      theme: ThemeData(
        primaryColor: Colors.blue,
        textTheme: const TextTheme(
          bodyText2: TextStyle(color: Color.fromARGB(255, 66, 74, 96)),
        ),
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<WorkoutsCubit>(
            create: (context) {
              WorkoutsCubit workoutsCubit = WorkoutsCubit();
              if (workoutsCubit.state.isEmpty) {
                print('... loading json since the state is empty');
                workoutsCubit.getWorkouts();
              } else {
                print('... the state is not empty ...');
              }
              return workoutsCubit;
            },
          ),
          BlocProvider<WorkoutCubit>(
            create: (context) => WorkoutCubit(),
          ),
        ],
        child: BlocBuilder<WorkoutCubit, WorkoutState>(
          builder: (context, state) {
            if (state is WorkoutInitial) {
              return const HomePage();
            } else if (state  is WorkoutEditing) {
              return const EditWorkoutScreen();
            }
            return Container();
          },
        ),
      ),
    );
  }
}
