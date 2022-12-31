import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widget_test_practice/clean_architecture/sample_01/core/use_cases/use_case.dart';
import 'package:widget_test_practice/clean_architecture/sample_01/features/users/domain/use_cases/fetch_users.dart';
import 'package:widget_test_practice/clean_architecture/sample_01/features/users/presentation/blocs/users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  final FetchUsers fetchUsers;

  UsersCubit(this.fetchUsers) : super(UsersInitial());

  getUsers() async {
    emit(UsersInProgress());
    await Future.delayed(const Duration(seconds: 2));
    final result = await fetchUsers(NoParams());

    result.when(
      error: (failure) => emit(UsersFailure(failure.error)),
      success: (users) => emit(UsersSuccess(users)),
    );
  }
}
