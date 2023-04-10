import 'package:get_it/get_it.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/core/database_helper.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/features/home/data/data_sources/expense_data_source.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/features/home/data/respsitories/expesne_repository_impl.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/features/home/domain/respsitories/expesne_repository.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/features/home/domain/use_cases/add_expense.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/features/home/domain/use_cases/delete_all_expense.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/features/home/domain/use_cases/delete_expense.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/features/home/domain/use_cases/get_all_expenses.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/features/home/presentation/bloc/expense_bloc.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/features/report/data/data_soruces/report_data_source.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/features/report/data/repositories/report_repositories_impl.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/features/report/domain/repositories/report_repository.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/features/report/domain/use_cases/get_report_use_case.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/features/report/presentation/bloc/report_bloc.dart';

final inject = GetIt.instance;

Future<void> init() async {
  /// blocs
  inject.registerFactory(
    () => ExpenseBloc(inject(), inject(), inject(), inject()),
  );
  inject.registerFactory(
    () => ReportBloc(inject()),
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
  inject.registerLazySingleton(
    () => GetReportUseCase(reportRepository: inject()),
  );

  /// repository
  inject.registerLazySingleton<ExpenseRepository>(
    () => ExpenseRepositoryImpl(dataSource: inject()),
  );
  inject.registerLazySingleton<ReportRepository>(
    () => ReportRepositoryImpl(reportDataSource: inject()),
  );

  /// data sources
  inject.registerLazySingleton<ExpenseDataSource>(
    () => ExpenseDataSourceImpl(databaseHelper: inject()),
  );
  inject.registerLazySingleton<ReportDataSource>(
    () => ReportDataSourceImpl(databaseHelper: inject()),
  );

  /// database helper
  inject.registerLazySingleton(() => DatabaseHelper(''));
}
