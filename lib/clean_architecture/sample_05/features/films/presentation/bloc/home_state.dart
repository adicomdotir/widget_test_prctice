part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class GetFilmsSuccess extends HomeState {
  List<Film> films;

  GetFilmsSuccess({required this.films});
}

class GetFilmsLoading extends HomeState {}

class GetFilmsError extends HomeState {
  final String errorMessage;

  const GetFilmsError({required this.errorMessage});
}
