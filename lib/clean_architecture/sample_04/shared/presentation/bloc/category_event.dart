import 'package:widget_test_practice/clean_architecture/sample_04/shared/domain/entities/category_entity.dart';

abstract class CategoryEvent {}

class GetAllCategoryEvent extends CategoryEvent {}

class AddCategoryEvent extends CategoryEvent {
  final CategoryEntity categoryEntity;

  AddCategoryEvent(this.categoryEntity);
}

class DeleteCategoryEvent extends CategoryEvent {
  final CategoryEntity categoryEntity;

  DeleteCategoryEvent(this.categoryEntity);
}

class UpdateCategoryEvent extends CategoryEvent {
  final CategoryEntity categoryEntity;

  UpdateCategoryEvent(this.categoryEntity);
}
