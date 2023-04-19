import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/features/category/presentation/bloc/category_bloc.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/features/category/presentation/bloc/category_event.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/features/category/presentation/bloc/category_state.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/shared/domain/entities/category_entity.dart';
import '../../../../injection_container.dart' as di;

class AddUpdateCategoryScreen extends StatelessWidget {
  AddUpdateCategoryScreen({
    Key? key,
    required this.categoryEntity,
  }) : super(key: key) {
    titleController.text = categoryEntity.title;
  }

  final TextEditingController titleController = TextEditingController();
  final CategoryEntity categoryEntity;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CategoryBloc>(
      create: (context) => di.inject.get<CategoryBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(runtimeType.toString()),
        ),
        body: Builder(
          builder: (context) {
            return BlocConsumer<CategoryBloc, CategoryState>(
              listener: (context, state) {
                if (state is CategoryAddedOrUpdatedState) {
                  Navigator.of(context).pop();
                }
              },
              builder: (context, state) {
                if (state is CategoryLoadingState) {
                  return const Text('Sending Data');
                } else if (state is CategoryErrorState) {
                  return Text('${state.message}');
                } else {
                  return Container(
                    padding: const EdgeInsets.all(16),
                    width: double.maxFinite,
                    child: Column(
                      children: [
                        TextField(
                          controller: titleController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text('Title'),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (titleController.text.trim().isNotEmpty) {
                              CategoryEntity newCatetoryEntity = categoryEntity
                                  .copyWith(newTitle: titleController.text);
                              BlocProvider.of<CategoryBloc>(context)
                                  .add(UpdateCategoryEvent(newCatetoryEntity));
                            }
                          },
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
}
