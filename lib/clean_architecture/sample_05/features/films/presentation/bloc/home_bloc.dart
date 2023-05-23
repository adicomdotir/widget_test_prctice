import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:widget_test_practice/clean_architecture/sample_05/features/films/domain/entities/film.dart';
import 'package:widget_test_practice/clean_architecture/sample_05/features/films/domain/usecases%20/films_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final FilmsUsecase filmsUsecase;
  HomeBloc({required this.filmsUsecase}) : super(HomeInitial()) {
    on<GetFilmsEvent>((event, emit) async {
      emit(GetFilmsLoading());
      final result =
          await filmsUsecase.getFilms(params: FilmsParams(path: '/film'));
      result.fold(
        (l) => emit(GetFilmsError(errorMessage: l.toString())),
        (r) => emit(GetFilmsSuccess(films: r)),
      );
    });
  }
}
