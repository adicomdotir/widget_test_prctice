import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widget_test_practice/clean_architecture/sample_aec/features/home/presentation/blocs/home_bloc.dart';
import 'package:widget_test_practice/clean_architecture/sample_aec/features/home/presentation/blocs/home_event.dart';
import 'package:widget_test_practice/clean_architecture/sample_aec/features/home/presentation/blocs/home_state.dart';
import 'package:widget_test_practice/clean_architecture/sample_aec/features/home/presentation/screens/bookmark_screen.dart';
import 'package:widget_test_practice/clean_architecture/sample_aec/features/home/presentation/widgets/people_list_widget.dart';
import '../../../../injection_container.dart' as di;

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          di.inject.get<HomeBloc>()..add(GetPeoplesHomeEvent()),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Home'),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BookmarkScreen(),
                      ),
                    ).then(
                      (value) => BlocProvider.of<HomeBloc>(context)
                          .add(GetPeoplesHomeEvent()),
                    );
                  },
                  icon: const Icon(Icons.favorite),
                ),
              ],
            ),
            body: Center(
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is HomeInitialState) {
                    return const Text('Init');
                  } else if (state is HomeLoadingState) {
                    return const Text('Loading');
                  } else if (state is HomeLoadedState) {
                    if (state.peoples.isEmpty) {
                      return const Text('No Data');
                    } else {
                      return PeopleListWidget(
                        state.peoples,
                        isLoadFromBookmark: false,
                      );
                    }
                  } else if (state is HomeErrorState) {
                    return Text(state.message);
                  } else {
                    return const Text('Unknown');
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
