import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/features/category/presentation/screens/add_update_category_screen.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/shared/domain/entities/category_entity.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/shared/presentation/bloc/category_bloc.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/shared/presentation/bloc/category_event.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/shared/presentation/bloc/category_state.dart';
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
                Navigator.of(context)
                    .push(
                      MaterialPageRoute(
                        builder: (context) => AddUpdateCategoryScreen(),
                      ),
                    )
                    .then(
                      (value) => BlocProvider.of<CategoryBloc>(context)
                          .add(GetAllCategoryEvent()),
                    );
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
                  return SizedBox(
                    width: double.maxFinite,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(state.message ?? ''),
                        const SizedBox(
                          height: 16,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<CategoryBloc>(context)
                                .add(GetAllCategoryEvent());
                          },
                          child: const Text('Back'),
                        ),
                      ],
                    ),
                  );
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
          leading: IconButton(
            icon: const Icon(
              Icons.edit,
              color: Colors.blueGrey,
            ),
            onPressed: () {
              Navigator.of(context)
                  .push(
                    MaterialPageRoute(
                      builder: (context) =>
                          AddUpdateCategoryScreen(categoryEntity: category),
                    ),
                  )
                  .then(
                    (value) => BlocProvider.of<CategoryBloc>(context)
                        .add(GetAllCategoryEvent()),
                  );
            },
          ),
          title: Text(category.title),
          trailing: IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onPressed: () {
              BlocProvider.of<CategoryBloc>(context)
                  .add(DeleteCategoryEvent(category));
            },
          ),
        );
      },
    );
  }
}
