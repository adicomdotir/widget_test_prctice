import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/features/home/domain/use_cases/add_expense.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/features/home/domain/use_cases/delete_all_expense.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/features/home/domain/use_cases/delete_expense.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/features/home/domain/use_cases/get_all_expenses.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/shared/domain/entities/expense_entity.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final GetAllExpenses getAllExpenses;
  final AddExpense addExpense;
  final DeleteExpense deleteExpense;
  final DeleteAllExpense deleteAllExpense;

  ExpenseBloc(
    this.getAllExpenses,
    this.addExpense,
    this.deleteExpense,
    this.deleteAllExpense,
  ) : super(ExpenseStateInitial()) {
    on<GetAllExpenseEvent>((event, emit) async {
      emit(ExpenseStateLoading());
      try {
        final result = await getAllExpenses();
        emit(ExpenseStateLoaded(expenses: result));
      } catch (e) {
        print(e);
        emit(ExpenseStateError());
      }
    });

    on<AddExpenseEvent>((event, emit) async {
      emit(ExpenseStateLoading());
      try {
        await addExpense(event.expenseEntity);
        add(GetAllExpenseEvent());
      } catch (e) {
        print(e);
        emit(ExpenseStateError());
      }
    });

    on<DeleteExpenseEvent>((event, emit) async {
      emit(ExpenseStateLoading());
      try {
        await deleteExpense(event.expenseEntity);
        add(GetAllExpenseEvent());
      } catch (e) {
        print(e);
        emit(ExpenseStateError());
      }
    });

    on<DeleteAllExpenseEvent>((event, emit) async {
      emit(ExpenseStateLoading());
      try {
        await deleteAllExpense();
        add(GetAllExpenseEvent());
      } catch (e) {
        print(e);
        emit(ExpenseStateError());
      }
    });
  }
}

abstract class ExpenseEvent {}

class GetAllExpenseEvent extends ExpenseEvent {}

class DeleteAllExpenseEvent extends ExpenseEvent {}

class AddExpenseEvent extends ExpenseEvent {
  final ExpenseEntity expenseEntity;

  AddExpenseEvent(this.expenseEntity);
}

class DeleteExpenseEvent extends ExpenseEvent {
  final ExpenseEntity expenseEntity;

  DeleteExpenseEvent(this.expenseEntity);
}

abstract class ExpenseState {}

class ExpenseStateInitial extends ExpenseState {}

class ExpenseStateLoading extends ExpenseState {}

class ExpenseStateError extends ExpenseState {}

class ExpenseStateLoaded extends ExpenseState {
  final List<ExpenseEntity> expenses;

  ExpenseStateLoaded({required this.expenses});
}

class ExpenseAddedOrUpdatedState extends ExpenseState {}
