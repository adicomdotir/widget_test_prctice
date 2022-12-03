import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widget_test_practice/dbestech/bloc_sample/blocs/workout_cubit.dart';
import 'package:widget_test_practice/dbestech/bloc_sample/blocs/workouts_cubit.dart';
import 'package:widget_test_practice/dbestech/bloc_sample/helpers.dart';
import 'package:widget_test_practice/dbestech/bloc_sample/models/workout.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout Time!'),
        actions: const [
          IconButton(onPressed: null, icon: Icon(Icons.event_available)),
          IconButton(onPressed: null, icon: Icon(Icons.settings)),
        ],
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<WorkoutsCubit, List<Workout>>(
          builder: (context, workouts) => ExpansionPanelList.radio(
            children: workouts
                .map(
                  (workout) => ExpansionPanelRadio(
                    value: workout,
                    headerBuilder: (context, isExpanded) => ListTile(
                      visualDensity: const VisualDensity(
                        horizontal: 0,
                        vertical: VisualDensity.maximumDensity,
                      ),
                      leading: IconButton(
                        onPressed: () {
                          BlocProvider.of<WorkoutCubit>(context)
                              .editWorkout(workout, workouts.indexOf(workout));
                        },
                        icon: const Icon(Icons.edit),
                      ),
                      title: Text(workout.title!),
                      trailing: Text(formatTime(workout.getTotal(), true)),
                    ),
                    body: ListView.builder(
                      shrinkWrap: true,
                      itemCount: workout.exercises.length,
                      itemBuilder: (context, index) => ListTile(
                        onTap: null,
                        visualDensity: const VisualDensity(
                          horizontal: 0,
                          vertical: VisualDensity.maximumDensity,
                        ),
                        leading: Text(
                          formatTime(workout.exercises[index].prelude!, true),
                        ),
                        title: Text(workout.exercises[index].title!),
                        trailing: Text(
                          formatTime(workout.exercises[index].duration!, true),
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
