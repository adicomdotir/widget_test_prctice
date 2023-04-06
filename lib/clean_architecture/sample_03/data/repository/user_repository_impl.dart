import 'package:widget_test_practice/clean_architecture/sample_03/data/data_source/firebase_user_data_source.dart';
import 'package:widget_test_practice/clean_architecture/sample_03/data/model/user.dart';
import 'package:widget_test_practice/clean_architecture/sample_03/domain/respsitory/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseUserDataSource firebaseUserDataSource;

  UserRepositoryImpl({required this.firebaseUserDataSource});

  @override
  Future<void> signUp(User user) async {
    await firebaseUserDataSource.signUp(user);
  }

  @override
  Future<void> login(String email, String password) async {
    await firebaseUserDataSource.login(email, password);
  }
}
