import 'package:widget_test_practice/clean_architecture/sample_04/core/database_helper.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/data/models/expense_model.dart';

abstract class ExpenseDataSource {
  Future<void> addExpesne(ExpenseModel expenseModel);

  Future<void> deleteExpesne(ExpenseModel expenseModel);

  Future<void> deleteAllExpesne();

  Future<List<ExpenseModel>> getAllExpenses();
}

class ExpenseDataSourceImpl extends ExpenseDataSource {
  final DatabaseHelper databaseHelper;

  ExpenseDataSourceImpl({required this.databaseHelper});

  @override
  Future<void> addExpesne(ExpenseModel expenseModel) {
    return databaseHelper.addExpense(expenseModel);
  }

  @override
  Future<List<ExpenseModel>> getAllExpenses() {
    return databaseHelper.getAllExpenses();
  }

  @override
  Future<void> deleteExpesne(ExpenseModel expenseModel) {
    return databaseHelper.deleteExpense(expenseModel);
  }

  @override
  Future<void> deleteAllExpesne() {
    return databaseHelper.deleteAllExpense();
  }
}
