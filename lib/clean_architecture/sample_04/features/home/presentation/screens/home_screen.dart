import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/core/utils/date_format.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/features/category/presentation/screens/category_list_screen.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/features/home/presentation/bloc/expense_bloc.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/features/home/presentation/screens/add_update_expense_screen.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/features/report/presentation/screens/report_screen.dart';
import '../../../../injection_container.dart' as di;
import 'package:widget_test_practice/clean_architecture/sample_04/shared/domain/entities/expense_entity.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          di.inject.get<ExpenseBloc>()..add(GetAllExpenseEvent()),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Home'),
              actions: [
                PopupMenuButton(
                  itemBuilder: (context) {
                    return [
                      const PopupMenuItem<int>(
                        value: 0,
                        child: Text('Report'),
                      ),
                      const PopupMenuItem<int>(
                        value: 1,
                        child: Text('Category'),
                      ),
                    ];
                  },
                  onSelected: (value) {
                    if (value == 0) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ReportScreen(),
                        ),
                      );
                    } else if (value == 1) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CategoryListScreen(),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context)
                              .push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const AddUpdateExpenseScreen(),
                                ),
                              )
                              .then(
                                (value) => BlocProvider.of<ExpenseBloc>(context)
                                    .add(GetAllExpenseEvent()),
                              );
                        },
                        child: const Text('Add Expense'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<ExpenseBloc>(context)
                              .add(DeleteAllExpenseEvent());
                        },
                        child: const Text('Delete All Expenses'),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Expanded(
                    child: BlocBuilder<ExpenseBloc, ExpenseState>(
                      builder: (context, state) {
                        if (state is ExpenseStateInitial) {
                          return const Text('Init');
                        } else if (state is ExpenseStateLoading) {
                          return const Text('Loading');
                        } else if (state is ExpenseStateLoaded) {
                          final expenses = state.expenses;
                          if (expenses.isEmpty) {
                            return const Text('Not Data');
                          }
                          return buildListView(expenses);
                        } else if (state is ExpenseStateError) {
                          return const Text('Error');
                        } else {
                          return const Text('Unkwon');
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  ListView buildListView(List<ExpenseEntity> expenses) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) {
        final expense = expenses[index];
        return ListTile(
          title: Text('Price: \$${expense.amount}'),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Category: ${expense.categoryId}'),
              const SizedBox(
                width: 16,
              ),
              dateTimeWidget(expense.date)
            ],
          ),
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
            child: Text((index + 1).toString()),
          ),
          trailing: IconButton(
            onPressed: () {
              BlocProvider.of<ExpenseBloc>(context)
                  .add(DeleteExpenseEvent(expense));
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.redAccent,
            ),
          ),
        );
      },
    );
  }

  Text dateTimeWidget(int date) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(date);
    return Text(
      '${dateFormat(dateTime)} (${timeFormat(dateTime)})',
    );
  }
}
