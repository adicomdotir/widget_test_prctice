import 'package:widget_test_practice/clean_architecture/sample_04/shared/data/models/category_model.dart';

abstract class CategoryRepository {
  Future<void> addCategory(CategoryModel categoryModel);
  Future<void> updateCategory(CategoryModel categoryModel);
  Future<void> deleteCategory(CategoryModel categoryModel);
  Future<CategoryModel> getCategory(String id);
  Future<List<CategoryModel>> getAllCategories();
}
