import 'package:widget_test_practice/clean_architecture/sample_04/features/category/domain/repositories/category_repository.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/shared/domain/entities/category_entity.dart';

class UpdateCategoryUseCase {
  final CategoryRepository repository;

  UpdateCategoryUseCase({required this.repository});

  Future<void> call(CategoryEntity categoryEntity) {
    return repository.updateCategory(categoryEntity.toModel());
  }
}
