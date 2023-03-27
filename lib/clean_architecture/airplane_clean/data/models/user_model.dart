import 'package:widget_test_practice/clean_architecture/airplane_clean/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  final String id;
  final String email;
  final String name;
  final String hobby;
  final int balance;

  const UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.hobby,
    required this.balance,
  }) : super();

  factory UserModel.fromJson(String id, Map<String, dynamic> jsonMap) {
    return UserModel(
      id: id,
      email: jsonMap['email'] ?? '',
      name: jsonMap['name'] ?? '',
      hobby: jsonMap['hobby'] ?? '',
      balance: jsonMap['balance'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'hobby': hobby,
      'balance': balance,
    };
  }
}
