import 'package:widget_test_practice/clean_architecture/sample_04/shared/data/models/expense_model.dart';

abstract class ExpenseRepository {
  Future<void> addExpense(ExpenseModel expenseModel);
  void updateExpense(ExpenseModel expenseModel);
  Future<void> deleteExpense(ExpenseModel expenseModel);
  Future<void> deleteAllExpense();
  Future<List<ExpenseModel>> getAllExpenses();
}
