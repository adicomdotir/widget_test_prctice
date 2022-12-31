import 'package:widget_test_practice/clean_architecture/sample_01/features/users/domain/user.dart';

class UserModel extends User {
  const UserModel({
    required int id,
    required String name,
    required String username,
    required String email,
  }) : super(id: id, name: name, username: username, email: email);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'email': email,
    };
  }
}
