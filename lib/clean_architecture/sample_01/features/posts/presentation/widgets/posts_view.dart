import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widget_test_practice/clean_architecture/sample_01/features/posts/presentation/blocs/posts/posts_cubit.dart';
import 'package:widget_test_practice/clean_architecture/sample_01/features/posts/presentation/blocs/posts/posts_state.dart';
import 'package:widget_test_practice/clean_architecture/sample_01/core/utils/index_to_color_ext.dart';

class PostsView extends StatelessWidget {
  const PostsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostsCubit, PostsState>(
      builder: (context, state) {
        if (state is PostsInProgress) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is PostsSuccess) {
          final posts = state.posts;

          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: post.userId.convertToColor,
                  ),
                  title: Text(post.title),
                  subtitle: Text(post.body),
                ),
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
