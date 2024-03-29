import 'package:widget_test_practice/clean_architecture/sample_04/shared/domain/entities/category_entity.dart';

abstract class CategoryState {}

class CategoryInitialState extends CategoryState {}

class CategoryLoadingState extends CategoryState {}

class CategoryErrorState extends CategoryState {
  final String? message;

  CategoryErrorState([this.message]);
}

class CategoryLoadedState extends CategoryState {
  final List<CategoryEntity> categories;

  CategoryLoadedState(this.categories);
}

class CategoryAddedOrUpdatedState extends CategoryState {}
