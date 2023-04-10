import 'package:widget_test_practice/clean_architecture/sample_04/features/home/domain/respsitories/expesne_repository.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/shared/domain/entities/expense_entity.dart';

class GetAllExpenses {
  final ExpenseRepository expenseRepository;

  GetAllExpenses({required this.expenseRepository});

  Future<List<ExpenseEntity>> call() {
    return expenseRepository.getAllExpenses();
  }
}
