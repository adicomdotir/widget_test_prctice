import 'package:dio/dio.dart';
import 'package:widget_test_practice/clean_architecture/sample_01/core/either.dart';
import 'package:widget_test_practice/clean_architecture/sample_01/core/error/failure.dart';
import 'package:widget_test_practice/clean_architecture/sample_01/features/users/data/data_sources/remote/user_remote_data_source.dart';
import 'package:widget_test_practice/clean_architecture/sample_01/features/users/domain/repositories/user_repository.dart';
import 'package:widget_test_practice/clean_architecture/sample_01/shared/data/models/user_model.dart';

class UserRepositoryImpl extends UserRepository {
  final UserRemoteDataSource dataSource;

  UserRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure<String>, List<UserModel>>> getUsers() async {
    try {
      final result = await dataSource.fetchUsers();
      return Success(result);
    } on DioError catch (e) {
      return Error(Failure.network(e.message));
    } catch (_) {
      return const Error(Failure.other());
    }
  }
}
