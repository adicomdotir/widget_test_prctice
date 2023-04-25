import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widget_test_practice/clean_architecture/sample_aec/features/home/domain/use_cases/bookmark_use_case.dart';
import 'package:widget_test_practice/clean_architecture/sample_aec/features/home/domain/use_cases/get_peoples_use_case.dart';
import 'package:widget_test_practice/clean_architecture/sample_aec/features/home/presentation/blocs/home_event.dart';
import 'package:widget_test_practice/clean_architecture/sample_aec/features/home/presentation/blocs/home_state.dart';
import '../../domain/use_cases/get_bookmark_use_case.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetPeoplesUseCase getPeoplesUseCase;
  final BookmarkUseCase bookmarkUseCase;
  final GetBookmarkUseCase getBookMarkUseCase;

  HomeBloc({
    required this.getPeoplesUseCase,
    required this.bookmarkUseCase,
    required this.getBookMarkUseCase,
  }) : super(HomeInitialState()) {
    on<GetPeoplesHomeEvent>((event, emit) async {
      emit(HomeLoadingState());
      try {
        final result = await getPeoplesUseCase();
        emit(HomeLoadedState(peoples: result));
      } catch (e) {
        emit(HomeErrorState(message: e.toString()));
      }
    });

    on<BookmarkPeopleHomeEvent>((event, emit) async {
      emit(HomeLoadingState());
      final result = await bookmarkUseCase(event.peopleEntity);
      if (result) {
        if (event.loadFromBookmark) {
          add(GetBookmarkHomeEvent());
        } else {
          add(GetPeoplesHomeEvent());
        }
      } else {
        emit(HomeErrorState(message: 'message'));
      }
    });

    on<GetBookmarkHomeEvent>((event, emit) async {
      emit(HomeLoadingState());
      final result = await getBookMarkUseCase();
      emit(HomeLoadedState(peoples: result));
    });
  }
}
