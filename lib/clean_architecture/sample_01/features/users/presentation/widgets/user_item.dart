import 'package:flutter/material.dart';
import 'package:widget_test_practice/clean_architecture/sample_01/core/utils/index_to_color_ext.dart';
import 'package:widget_test_practice/clean_architecture/sample_01/features/users/domain/user.dart';
import 'package:widget_test_practice/clean_architecture/sample_01/features/users/presentation/widgets/users_view.dart';

class UserItem extends StatelessWidget {
  final User user;
  final OnUserPressed? onUserPressed;

  const UserItem({Key? key, required this.user, this.onUserPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 70,
            height: 70,
            child: Material(
              borderRadius: BorderRadius.circular(35),
              color: user.id.convertToColor,
              child: InkWell(
                borderRadius: BorderRadius.circular(35),
                onTap: () {
                  onUserPressed?.call(user.id);
                },
                child: Center(
                  child: Text(
                    user.name[0],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 5,),
          Text(
            user.username,
            style: const TextStyle(
              fontSize: 14,
              height: 1,
            ),
          )
        ],
      ),
    );
  }
}
