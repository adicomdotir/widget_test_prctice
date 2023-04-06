import 'package:widget_test_practice/clean_architecture/sample_03/data/model/user.dart';

abstract class UserRepository {
  Future<void> signUp(User user);
  Future<void> login(String email, String password);
}
