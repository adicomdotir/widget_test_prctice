import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/features/category/domain/use_cases/add_category_use_case.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/features/category/domain/use_cases/get_all_categories_use_case.dart';

import 'category_event.dart';
import 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetAllCategoriesUseCase getAllCategoriesUseCase;
  final AddCategoryUseCase addCategoryUseCase;

  CategoryBloc({
    required this.getAllCategoriesUseCase,
    required this.addCategoryUseCase,
  }) : super(CategoryInitialState()) {
    on<GetAllCategoryEvent>((event, emit) async {
      emit(CategoryLoadingState());
      final result = await getAllCategoriesUseCase();
      emit(CategoryLoadedState(result));
    });

    on<AddCategoryEvent>((event, emit) async {
      emit(CategoryLoadingState());
      await addCategoryUseCase(event.categoryEntity);
      add(GetAllCategoryEvent());
    });
  }
}
