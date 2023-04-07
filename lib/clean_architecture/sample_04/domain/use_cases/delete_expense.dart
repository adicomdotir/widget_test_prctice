import 'package:widget_test_practice/clean_architecture/sample_04/data/models/expense_model.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/domain/entities/expense_entity.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/domain/respsitories/expesne_repository.dart';

class DeleteExpense {
  final ExpenseRepository expenseRepository;

  DeleteExpense({required this.expenseRepository});

  Future<void> call(ExpenseEntity expenseEntity) {
    return expenseRepository.deleteExpense(expenseEntity.toModel());
  }
}
