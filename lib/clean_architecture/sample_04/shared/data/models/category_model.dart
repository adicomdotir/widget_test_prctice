import 'package:widget_test_practice/clean_architecture/sample_04/shared/domain/entities/category_entity.dart';

class CategoryModel extends CategoryEntity {
  CategoryModel({
    required String id,
    required String title,
  }) : super(title: title, id: id);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
    };
  }

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json['id'],
        title: json['title'],
      );
}
