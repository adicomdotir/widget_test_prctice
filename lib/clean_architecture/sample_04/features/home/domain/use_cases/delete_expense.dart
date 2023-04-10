import 'package:widget_test_practice/clean_architecture/sample_04/features/home/domain/respsitories/expesne_repository.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/shared/domain/entities/expense_entity.dart';

class DeleteExpense {
  final ExpenseRepository expenseRepository;

  DeleteExpense({required this.expenseRepository});

  Future<void> call(ExpenseEntity expenseEntity) {
    return expenseRepository.deleteExpense(expenseEntity.toModel());
  }
}
