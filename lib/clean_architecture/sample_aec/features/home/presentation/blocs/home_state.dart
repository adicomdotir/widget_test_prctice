import 'package:widget_test_practice/clean_architecture/sample_aec/features/home/domain/entities/people_entity.dart';

abstract class HomeState {}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {
  final List<PeopleEntity> peoples;

  HomeLoadedState({required this.peoples});
}

class HomeErrorState extends HomeState {
  final String message;

  HomeErrorState({required this.message});
}
