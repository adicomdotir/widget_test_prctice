import 'package:widget_test_practice/clean_architecture/sample_04/data/data_sources/expense_data_source.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/data/models/expense_model.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/domain/respsitories/expesne_repository.dart';

class ExpenseRepositoryImpl extends ExpenseRepository {
  final ExpenseDataSource dataSource;

  ExpenseRepositoryImpl({required this.dataSource});

  @override
  Future<void> addExpense(ExpenseModel expenseModel) {
    return dataSource.addExpesne(expenseModel);
  }

  @override
  Future<void> deleteExpense(ExpenseModel expenseModel) {
    return dataSource.deleteExpesne(expenseModel);
  }

  @override
  Future<List<ExpenseModel>> getAllExpenses() {
    return dataSource.getAllExpenses();
  }

  @override
  void updateExpense(ExpenseModel expenseModel) {
    // TODO: implement updateExpense
  }
}
