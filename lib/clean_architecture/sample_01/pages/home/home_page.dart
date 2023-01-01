import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:widget_test_practice/clean_architecture/sample_01/features/posts/presentation/blocs/posts/posts_cubit.dart';
import 'package:widget_test_practice/clean_architecture/sample_01/features/posts/presentation/widgets/posts_view.dart';
import 'package:widget_test_practice/clean_architecture/sample_01/features/users/presentation/blocs/users_cubit.dart';
import 'package:widget_test_practice/clean_architecture/sample_01/features/users/presentation/widgets/users_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => GetIt.I.get<UsersCubit>()..getUsers(),
        ),
        BlocProvider(
          create: (_) => GetIt.I.get<PostsCubit>()..getPosts(),
        ),
      ],
      child: Scaffold(
        body: Builder(
          builder: (context) {
            return SafeArea(
              child: Column(
                children: [
                  UsersView(
                    onUserPressed: (userId) {
                      context.read<PostsCubit>().getPosts(userId);
                    },
                  ),
                  const SizedBox(height: 15),
                  const Expanded(child: PostsView()),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
