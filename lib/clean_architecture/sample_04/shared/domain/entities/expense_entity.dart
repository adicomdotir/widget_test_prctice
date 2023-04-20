import 'package:widget_test_practice/clean_architecture/sample_04/shared/data/models/expense_model.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/shared/domain/entities/category_entity.dart';

class ExpenseEntity {
  final String id;
  final String categoryId;
  final double amount;
  final int date;

  ExpenseEntity({
    required this.id,
    required this.categoryId,
    required this.amount,
    required this.date,
  });

  ExpenseModel toModel() {
    return ExpenseModel(
      id: id,
      categoryId: categoryId,
      amount: amount,
      date: date,
    );
  }
}
