import 'package:widget_test_practice/clean_architecture/sample_04/shared/data/data_sources/category_data_source.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/shared/data/models/category_model.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/shared/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl extends CategoryRepository {
  final CategoryDataSource dataSource;

  CategoryRepositoryImpl({required this.dataSource});

  @override
  Future<void> addCategory(CategoryModel categoryModel) {
    return dataSource.addCategory(categoryModel);
  }

  @override
  Future<void> deleteCategory(CategoryModel categoryModel) {
    return dataSource.deleteCategory(categoryModel);
  }

  @override
  Future<List<CategoryModel>> getAllCategories() {
    return dataSource.getAllCategories();
  }

  @override
  Future<CategoryModel> getCategory(String id) {
    // TODO: implement getCategory
    throw UnimplementedError();
  }

  @override
  Future<void> updateCategory(CategoryModel categoryModel) {
    return dataSource.updateCategory(categoryModel);
  }
}
