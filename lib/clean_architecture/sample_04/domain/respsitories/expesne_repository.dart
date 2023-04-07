import 'package:widget_test_practice/clean_architecture/sample_04/data/models/expense_model.dart';

abstract class ExpenseRepository {
  Future<void> addExpense(ExpenseModel expenseModel);
  void updateExpense(ExpenseModel expenseModel);
  Future<void> deleteExpense(ExpenseModel expenseModel);
  Future<List<ExpenseModel>> getAllExpenses();
}
