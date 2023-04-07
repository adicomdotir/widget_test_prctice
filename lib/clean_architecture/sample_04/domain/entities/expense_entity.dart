import 'package:widget_test_practice/clean_architecture/sample_04/data/models/expense_model.dart';

class ExpenseEntity {
  final String id;
  final String category;
  final double amount;
  final int date;

  ExpenseEntity({
    required this.id,
    required this.category,
    required this.amount,
    required this.date,
  });

  ExpenseModel toModel() {
    return ExpenseModel(
      id: id,
      category: category,
      amount: amount,
      date: date,
    );
  }
}
