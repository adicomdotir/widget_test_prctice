import 'package:widget_test_practice/clean_architecture/sample_04/shared/domain/entities/category_entity.dart';

abstract class CategoryEvent {}

class GetAllCategoryEvent extends CategoryEvent {}

class AddCategoryEvent extends CategoryEvent {
  final CategoryEntity categoryEntity;

  AddCategoryEvent(this.categoryEntity);
}
