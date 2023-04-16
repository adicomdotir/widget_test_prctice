import 'package:widget_test_practice/clean_architecture/sample_04/features/category/domain/repositories/category_repository.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/shared/domain/entities/category_entity.dart';

class GetAllCategoriesUseCase {
  final CategoryRepository repository;

  GetAllCategoriesUseCase({required this.repository});

  Future<List<CategoryEntity>> call() {
    return repository.getAllCategories();
  }
}
