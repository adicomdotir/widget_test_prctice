import 'package:equatable/equatable.dart';
import 'package:widget_test_practice/clean_architecture/sample_01/shared/data/models/user_model.dart';

class User extends Equatable {
  final int id;
  final String name;
  final String username;
  final String email;

  const User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    username,
    email,
  ];
}
