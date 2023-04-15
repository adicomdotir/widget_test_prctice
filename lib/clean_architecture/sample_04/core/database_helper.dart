import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/shared/data/models/expense_model.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/shared/data/models/report_model.dart';

class DatabaseHelper {
  final String path;

  DatabaseHelper(this.path);

  Future<void> init() async {
    Hive.init(path);
  }

  Future<void> addExpense(ExpenseModel expense) async {
    await Hive.openBox('expenses');
    await Hive.box('expenses').put(expense.id, jsonEncode(expense.toJson()));
  }

  Future<List<ExpenseModel>> getAllExpenses() async {
    await Hive.openBox('expenses');
    final box = Hive.box('expenses');
    final expenses =
        box.values.map((e) => ExpenseModel.fromJson(jsonDecode(e))).toList();
    expenses.sort((a, b) => b.date - a.date);
    return expenses;
  }

  Future<void> deleteExpense(ExpenseModel expenseModel) async {
    await Hive.openBox('expenses');
    await Hive.box('expenses').delete(expenseModel.id);
  }

  Future<void> deleteAllExpense() async {
    await Hive.openBox('expenses');
    final box = Hive.box('expenses');
    box.deleteAll(box.keys);
  }

  Future<List<ReportModel>> getReport() async {
    await Hive.openBox('expenses');
    final box = Hive.box('expenses');
    final expenses =
        box.values.map((e) => ExpenseModel.fromJson(jsonDecode(e))).toList();
    final categories =
        expenses.map((expenseModel) => expenseModel.category).toSet();
    List<ReportModel> reports = [];
    for (var category in categories) {
      final result = expenses
          .where((expenseModel) => expenseModel.category == category)
          .map((expenseModel) => expenseModel.amount)
          .reduce((value, amount) => amount + value);
      reports.add(ReportModel(category: category, amount: result));
    }
    reports.sort((a, b) => b.amount.round() - a.amount.round());
    return reports;
  }
}
