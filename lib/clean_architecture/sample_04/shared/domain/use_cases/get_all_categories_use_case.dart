import 'package:widget_test_practice/clean_architecture/sample_04/shared/domain/entities/category_entity.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/shared/domain/repositories/category_repository.dart';

class GetAllCategoriesUseCase {
  final CategoryRepository repository;

  GetAllCategoriesUseCase({required this.repository});

  Future<List<CategoryEntity>> call() {
    return repository.getAllCategories();
  }
}
