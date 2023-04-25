import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widget_test_practice/clean_architecture/sample_aec/features/home/presentation/blocs/home_bloc.dart';
import 'package:widget_test_practice/clean_architecture/sample_aec/features/home/presentation/blocs/home_event.dart';
import 'package:widget_test_practice/clean_architecture/sample_aec/features/home/presentation/blocs/home_state.dart';
import 'package:widget_test_practice/clean_architecture/sample_aec/features/home/presentation/widgets/people_list_widget.dart';
import '../../../../injection_container.dart' as di;

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmark'),
      ),
      body: Center(
        child: BlocProvider<HomeBloc>(
          create: (context) =>
              di.inject.get<HomeBloc>()..add(GetBookmarkHomeEvent()),
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeLoadingState) {
                return const CircularProgressIndicator();
              } else if (state is HomeLoadedState) {
                if (state.peoples.isEmpty) {
                  return const Text('No Data');
                } else {
                  return PeopleListWidget(
                    state.peoples,
                    isLoadFromBookmark: true,
                  );
                }
              } else {
                return const Text('Unknown');
              }
            },
          ),
        ),
      ),
    );
  }
}
