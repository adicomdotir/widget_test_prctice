import 'package:widget_test_practice/clean_architecture/sample_04/shared/domain/entities/expense_entity.dart';

class ExpenseModel extends ExpenseEntity {
  ExpenseModel({
    required String id,
    required String category,
    required double amount,
    required int date,
  }) : super(id: id, category: category, amount: amount, date: date);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'amount': amount,
      'date': date,
    };
  }

  factory ExpenseModel.fromJson(Map<String, dynamic> json) => ExpenseModel(
        id: json['id'],
        category: json['category'],
        amount: json['amount'],
        date: json['date'],
      );
}
