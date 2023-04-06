import 'package:firebase_auth/firebase_auth.dart';
import 'package:widget_test_practice/clean_architecture/sample_03/data/model/user.dart'
    as my_user;

class FirebaseUserDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signUp(my_user.User user) async {
    await _auth.createUserWithEmailAndPassword(
      email: user.email,
      password: user.password,
    );
  }

  Future<void> login(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }
}
