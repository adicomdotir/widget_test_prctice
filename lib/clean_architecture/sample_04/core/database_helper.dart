import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/shared/data/models/category_model.dart';
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
      final expensesFilterByCategory =
          expenses.where((expenseModel) => expenseModel.category == category);
      final result = expensesFilterByCategory
          .map((expenseModel) => expenseModel.amount)
          .reduce((value, amount) => amount + value);
      reports.add(
        ReportModel(
          category: category,
          amount: result,
          count: expensesFilterByCategory.length,
        ),
      );
    }
    reports.sort((a, b) => b.amount.round() - a.amount.round());
    return reports;
  }

  Future<void> addCategory(CategoryModel categoryModel) async {
    await Hive.openBox('categories');
    await Hive.box('categories')
        .put(categoryModel.id, jsonEncode(categoryModel.toJson()));
  }

  Future<List<CategoryModel>> getAllCategories() async {
    await Hive.openBox('categories');
    final box = Hive.box('categories');
    final categories =
        box.values.map((e) => CategoryModel.fromJson(jsonDecode(e))).toList();
    return categories;
  }
}
