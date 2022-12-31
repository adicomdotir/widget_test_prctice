import 'package:dio/dio.dart';
import 'package:widget_test_practice/clean_architecture/sample_01/shared/data/models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<List<UserModel>> fetchUsers();
}

class UserRemoteDataSourceImpl extends UserRemoteDataSource {
  final Dio dio;

  UserRemoteDataSourceImpl(this.dio);

  @override
  Future<List<UserModel>> fetchUsers() async {
    final result = await dio.get('/users');
    return (result.data as List<dynamic>)
        .map((user) => UserModel.fromJson(user))
        .toList();
  }
}
