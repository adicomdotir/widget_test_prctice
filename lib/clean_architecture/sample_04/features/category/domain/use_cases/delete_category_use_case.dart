import 'package:widget_test_practice/clean_architecture/sample_04/features/category/domain/repositories/category_repository.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/shared/domain/entities/category_entity.dart';

class DeleteCategoryUseCase {
  final CategoryRepository repository;

  DeleteCategoryUseCase({required this.repository});

  Future<void> call(CategoryEntity categoryEntity) {
    return repository.deleteCategory(categoryEntity.toModel());
  }
}
