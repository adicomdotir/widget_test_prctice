import 'package:flutter_test/flutter_test.dart';
import 'package:widget_test_practice/clean_architecture/airplane_clean/data/models/user_model.dart';

void main() {
  const UserModel tUserModel = UserModel(
    id: '1',
    email: 'email@gmail.com',
    name: 'name',
    hobby: 'hobby',
    balance: 100,
  );

  group('get user by id', () {
    test('should return ApiRetureValue type UserModel', () async {});
  });
}
