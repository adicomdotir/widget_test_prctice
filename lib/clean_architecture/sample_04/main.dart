import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/core/utils/date_format.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/core/utils/id_generator.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/domain/entities/expense_entity.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/presentation/bloc/expense_bloc.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    ),
  );
}

List<String> categories = [
  'Food',
  'Car',
  'Home',
  'Technonogy',
  'Smoke',
];

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.inject.get<ExpenseBloc>(),
      child: Builder(
        builder: (context) {
          BlocProvider.of<ExpenseBloc>(context).add(GetAllExpenseEvent());
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // ElevatedButton(
                      //   onPressed: () {
                      //     BlocProvider.of<ExpenseBloc>(context)
                      //         .add(GetAllExpenseEvent());
                      //   },
                      //   child: const Text('Get All Expenses'),
                      // ),
                      ElevatedButton(
                        onPressed: () {
                          final random = Random();
                          String category =
                              categories[random.nextInt(categories.length)];
                          final expenseEntity = ExpenseEntity(
                            id: idGenerator(),
                            category: category,
                            amount: random.nextInt(100) + 10,
                            date: DateTime.now().millisecondsSinceEpoch,
                          );
                          BlocProvider.of<ExpenseBloc>(context)
                              .add(AddExpenseEvent(expenseEntity));
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
              Text('Category: ${expense.category}'),
              const SizedBox(
                width: 16,
              ),
              dateTimeWidget(expense.date)
            ],
          ),
          leading: CircleAvatar(
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
