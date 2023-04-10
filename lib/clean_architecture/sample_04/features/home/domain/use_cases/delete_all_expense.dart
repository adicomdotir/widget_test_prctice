import 'package:widget_test_practice/clean_architecture/sample_04/features/home/domain/respsitories/expesne_repository.dart';

class DeleteAllExpense {
  final ExpenseRepository expenseRepository;

  DeleteAllExpense({required this.expenseRepository});

  Future<void> call() {
    return expenseRepository.deleteAllExpense();
  }
}
