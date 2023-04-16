import 'package:widget_test_practice/clean_architecture/sample_04/core/database_helper.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/shared/data/models/category_model.dart';

abstract class CategoryDataSource {
  Future<void> addCategory(CategoryModel categoryModel);
  Future<void> updateCategory(CategoryModel categoryModel);
  Future<void> deleteCategory(CategoryModel categoryModel);
  Future<CategoryModel> getCategory(String id);
  Future<List<CategoryModel>> getAllCategories();
}

class CategoryDataSourceImpl extends CategoryDataSource {
  final DatabaseHelper databaseHelper;

  CategoryDataSourceImpl({required this.databaseHelper});

  @override
  Future<void> addCategory(CategoryModel categoryModel) {
    return databaseHelper.addCategory(categoryModel);
  }

  @override
  Future<void> deleteCategory(CategoryModel categoryModel) {
    // TODO: implement deleteCategory
    throw UnimplementedError();
  }

  @override
  Future<List<CategoryModel>> getAllCategories() {
    return databaseHelper.getAllCategories();
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
