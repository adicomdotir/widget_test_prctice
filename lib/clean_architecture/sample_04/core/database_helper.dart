import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/data/models/expense_model.dart';

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

    return box.values.map((e) => ExpenseModel.fromJson(jsonDecode(e))).toList();
  }

  Future<void> deleteExpense(ExpenseModel expenseModel) async {
    await Hive.openBox('expenses');
    await Hive.box('expenses').delete(expenseModel.id);
  }
}
