import 'package:widget_test_practice/clean_architecture/sample_04/features/category/data/data_sources/category_data_source.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/features/category/domain/repositories/category_repository.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/shared/data/models/category_model.dart';

class CategoryRepositoryImpl extends CategoryRepository {
  final CategoryDataSource dataSource;

  CategoryRepositoryImpl({required this.dataSource});

  @override
  Future<void> addCategory(CategoryModel categoryModel) {
    return dataSource.addCategory(categoryModel);
  }

  @override
  Future<void> deleteCategory(CategoryModel categoryModel) {
    // TODO: implement deleteCategory
    throw UnimplementedError();
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
    // TODO: implement updateCategory
    throw UnimplementedError();
  }
}
