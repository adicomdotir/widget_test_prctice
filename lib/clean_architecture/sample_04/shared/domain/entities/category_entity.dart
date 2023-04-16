import 'package:widget_test_practice/clean_architecture/sample_04/shared/data/models/category_model.dart';

class CategoryEntity {
  final String id;
  final String title;

  CategoryEntity({
    required this.id,
    required this.title,
  });

  CategoryModel toModel() {
    return CategoryModel(
      id: id,
      title: title,
    );
  }
}
