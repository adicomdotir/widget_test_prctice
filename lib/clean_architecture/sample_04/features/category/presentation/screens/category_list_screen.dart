import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/core/utils/id_generator.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/features/category/presentation/bloc/category_event.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/features/category/presentation/bloc/category_state.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/main.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/shared/domain/entities/category_entity.dart';
import '../bloc/category_bloc.dart';
import '../../../../injection_container.dart' as di;

class CategoryListScreen extends StatelessWidget {
  const CategoryListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CategoryBloc>(
      create: (context) =>
          di.inject.get<CategoryBloc>()..add(GetAllCategoryEvent()),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Category List'),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                final random = Random().nextInt(categoriesMockData.length);
                final category = categoriesMockData[random];
                final CategoryEntity categoryEntity = CategoryEntity(
                  id: idGenerator(),
                  title: category,
                );
                BlocProvider.of<CategoryBloc>(context)
                    .add(AddCategoryEvent(categoryEntity));
              },
              child: const Icon(Icons.add),
            ),
            body: BlocBuilder<CategoryBloc, CategoryState>(
              builder: (context, state) {
                if (state is CategoryInitialState) {
                  return const Text('Init');
                } else if (state is CategoryLoadingState) {
                  return const Text('Loading');
                } else if (state is CategoryLoadedState) {
                  final categories = state.categories;
                  if (categories.isEmpty) {
                    return const Text('Not Data');
                  }
                  return buildListView(categories);
                } else if (state is CategoryErrorState) {
                  return const Text('Error');
                } else {
                  return const Text('Unkwon');
                }
              },
            ),
          );
        },
      ),
    );
  }

  Widget buildListView(List<CategoryEntity> categories) {
    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return ListTile(
          title: Text(category.title),
        );
      },
    );
  }
}
