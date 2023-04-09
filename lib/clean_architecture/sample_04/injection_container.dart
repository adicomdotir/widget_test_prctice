import 'package:get_it/get_it.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/core/database_helper.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/data/data_sources/expense_data_source.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/data/respsitories/expesne_repository_impl.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/domain/respsitories/expesne_repository.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/domain/use_cases/add_expense.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/domain/use_cases/delete_all_expense.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/domain/use_cases/delete_expense.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/domain/use_cases/get_all_expenses.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/presentation/bloc/expense_bloc.dart';

final inject = GetIt.instance;

Future<void> init() async {
  /// blocs
  inject.registerFactory(
    () => ExpenseBloc(inject(), inject(), inject(), inject()),
  );

  /// use cases
  inject.registerLazySingleton(
    () => GetAllExpenses(expenseRepository: inject()),
  );
  inject.registerLazySingleton(
    () => AddExpense(expenseRepository: inject()),
  );
  inject.registerLazySingleton(
    () => DeleteAllExpense(expenseRepository: inject()),
  );
  inject.registerLazySingleton(
    () => DeleteExpense(expenseRepository: inject()),
  );

  /// repository
  inject.registerLazySingleton<ExpenseRepository>(
    () => ExpenseRepositoryImpl(dataSource: inject()),
  );

  /// data sources
  inject.registerLazySingleton<ExpenseDataSource>(
    () => ExpenseDataSourceImpl(databaseHelper: inject()),
  );

  /// database helper
  inject.registerLazySingleton(() => DatabaseHelper(''));
}
