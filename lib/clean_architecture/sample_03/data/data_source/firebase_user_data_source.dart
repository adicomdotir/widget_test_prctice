import 'package:widget_test_practice/clean_architecture/sample_03/data/model/user.dart'
    as my_user;

class FirebaseUserDataSource {
  Future<void> signUp(my_user.User user) async {}

  Future<void> login(String email, String password) async {}
}
