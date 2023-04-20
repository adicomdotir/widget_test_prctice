import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/core/error/exception.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/shared/domain/use_cases/add_category_use_case.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/shared/domain/use_cases/delete_category_use_case.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/shared/domain/use_cases/get_all_categories_use_case.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/shared/domain/use_cases/update_category_use_case.dart';

import 'category_event.dart';
import 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetAllCategoriesUseCase getAllCategoriesUseCase;
  final AddCategoryUseCase addCategoryUseCase;
  final UpdateCategoryUseCase updateCategoryUseCase;
  final DeleteCategoryUseCase deleteCategoryUseCase;

  CategoryBloc({
    required this.getAllCategoriesUseCase,
    required this.addCategoryUseCase,
    required this.deleteCategoryUseCase,
    required this.updateCategoryUseCase,
  }) : super(CategoryInitialState()) {
    on<GetAllCategoryEvent>((event, emit) async {
      emit(CategoryLoadingState());
      try {
        final result = await getAllCategoriesUseCase();
        emit(CategoryLoadedState(result));
      } catch (e) {
        emit(CategoryErrorState());
      }
    });

    on<AddCategoryEvent>((event, emit) async {
      emit(CategoryLoadingState());
      try {
        await addCategoryUseCase(event.categoryEntity);
        emit(CategoryAddedOrUpdatedState());
      } on DuplicateCategoryException catch (e) {
        emit(CategoryErrorState(e.message));
      }
    });

    on<DeleteCategoryEvent>((event, emit) async {
      emit(CategoryLoadingState());
      try {
        await deleteCategoryUseCase(event.categoryEntity);
        add(GetAllCategoryEvent());
      } on Exception {
        emit(CategoryErrorState());
      }
    });

    on<UpdateCategoryEvent>((event, emit) async {
      emit(CategoryLoadingState());
      try {
        await updateCategoryUseCase(event.categoryEntity);
        emit(CategoryAddedOrUpdatedState());
      } on DuplicateCategoryException catch (e) {
        emit(CategoryErrorState(e.message));
      }
    });
  }
}
