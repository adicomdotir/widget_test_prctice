import 'package:widget_test_practice/clean_architecture/sample_04/shared/domain/entities/category_entity.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/shared/domain/repositories/category_repository.dart';

class DeleteCategoryUseCase {
  final CategoryRepository repository;

  DeleteCategoryUseCase({required this.repository});

  Future<void> call(CategoryEntity categoryEntity) {
    return repository.deleteCategory(categoryEntity.toModel());
  }
}
