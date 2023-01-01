import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widget_test_practice/clean_architecture/sample_01/features/posts/domain/use_cases/fetch_posts.dart';
import 'package:widget_test_practice/clean_architecture/sample_01/features/posts/presentation/blocs/posts/posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  final FetchPosts fetchPosts;

  PostsCubit(this.fetchPosts) : super(PostsInitial());

  getPosts([int? userId]) async {
    emit(PostsInProgress());
    final result = await fetchPosts(userId);
    result.when(
      error: (error) {
        emit(PostsFailure(error.error));
      },
      success: (success) {
        emit(PostsSuccess(success));
      },
    );
  }
}
