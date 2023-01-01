import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widget_test_practice/clean_architecture/sample_01/features/users/presentation/blocs/users_cubit.dart';
import 'package:widget_test_practice/clean_architecture/sample_01/features/users/presentation/blocs/users_state.dart';
import 'package:widget_test_practice/clean_architecture/sample_01/features/users/presentation/widgets/user_item.dart';

typedef OnUserPressed = void Function(int userId);

class UsersView extends StatefulWidget {
  final OnUserPressed? onUserPressed;

  const UsersView({
    Key? key,
    this.onUserPressed,
  }) : super(key: key);

  @override
  State<UsersView> createState() => _UsersViewState();
}

class _UsersViewState extends State<UsersView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersCubit, UsersState>(
      builder: (context, state) {
        if (state is UsersInProgress) {
          return const LinearProgressIndicator();
        }

        if (state is UsersSuccess) {
          final users = state.users;

          return SizedBox(
            height: 90,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return UserItem(
                  user: user,
                  onUserPressed: widget.onUserPressed,
                );
              },
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
