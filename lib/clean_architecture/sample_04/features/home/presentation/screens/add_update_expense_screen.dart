import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/features/home/presentation/bloc/expense_bloc.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/shared/domain/entities/category_entity.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/shared/presentation/bloc/category_bloc.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/shared/presentation/bloc/category_event.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/shared/presentation/bloc/category_state.dart';
import '../../../../injection_container.dart' as di;

class AddUpdateExpenseScreen extends StatelessWidget {
  const AddUpdateExpenseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.inject.get<ExpenseBloc>(),
        ),
        BlocProvider(
          create: (context) =>
              di.inject.get<CategoryBloc>()..add(GetAllCategoryEvent()),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(runtimeType.toString()),
        ),
        body: Builder(
          builder: (context) {
            return BlocConsumer<ExpenseBloc, ExpenseState>(
              listener: (context, state) {
                if (state is ExpenseAddedOrUpdatedState) {
                  Navigator.of(context).pop();
                }
              },
              builder: (context, state) {
                if (state is ExpenseStateLoading) {
                  return const Text('Sending Data');
                } else if (state is ExpenseStateError) {
                  return const Text('ERROR');
                } else {
                  return Container(
                    padding: const EdgeInsets.all(16),
                    width: double.maxFinite,
                    child: Column(
                      children: [
                        const TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text('Title'),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Container(
                          width: double.infinity,
                          child: dropDowWidget(),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text('Save'),
                        ),
                      ],
                    ),
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }

  Widget dropDowWidget() {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoadedState) {
          // return DropdownButton<String>(
          //   items: state.categories
          //       .map<DropdownMenuItem<String>>(
          //         (categoryEntity) => DropdownMenuItem<String>(
          //           value: categoryEntity.id,
          //           child: Text(categoryEntity.title),
          //         ),
          //       )
          //       .toList(),
          //   onChanged: (value) {
          //     print(value);
          //   },
          // );
          return InputDecorator(
            decoration: const InputDecoration(
              labelText: 'Category',
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 0.0,
              ),
              border: OutlineInputBorder(),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                icon: const Icon(Icons.arrow_drop_down),
                iconSize: 24,
                elevation: 16,
                onChanged: (String? newValue) {},
                items:
                    state.categories.map<DropdownMenuItem<String>>((category) {
                  return DropdownMenuItem<String>(
                    value: category.id,
                    child: Text(category.title),
                  );
                }).toList(),
              ),
            ),
          );
        } else if (state is CategoryLoadingState) {
          return const Text('Loading Data');
        } else {
          return const Text('Unknown');
        }
      },
    );
  }
}
