import 'package:widget_test_practice/clean_architecture/sample_04/shared/domain/entities/category_entity.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/shared/domain/repositories/category_repository.dart';

class UpdateCategoryUseCase {
  final CategoryRepository repository;

  UpdateCategoryUseCase({required this.repository});

  Future<void> call(CategoryEntity categoryEntity) {
    return repository.updateCategory(categoryEntity.toModel());
  }
}
