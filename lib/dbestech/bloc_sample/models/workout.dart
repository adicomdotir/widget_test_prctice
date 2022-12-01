import 'package:equatable/equatable.dart';
import 'package:widget_test_practice/dbestech/bloc_sample/models/exercise.dart';

class Workout extends Equatable {
  final String? title;
  final List<Exercise> exercises;

  const Workout({
    required this.exercises,
    required this.title,
  });

  factory Workout.fromJson(Map<String, dynamic> json) {
    List<Exercise> exercises = [];

    int index = 0;
    int startTime = 0;

    for (var ex in (json['exercises'] as Iterable)) {
      exercises.add(Exercise.fromJson(ex, index, startTime));
      index++;
      startTime += exercises.last.prelude! + exercises.last.duration!;
    }

    return Workout(exercises: exercises, title: json['title'] as String?);
  }

  Map<String, dynamic> toJson() => {'title': title, 'exercises': exercises};

  int getTotal() {
    int time = exercises.fold(
      0,
      (previousValue, element) =>
          previousValue + element.duration! + element.prelude!,
    );
    return time;
  }

  @override
  List<Object?> get props => [title, exercises];

  @override
  bool? get stringify => true;
}
