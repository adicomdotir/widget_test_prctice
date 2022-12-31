import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:widget_test_practice/clean_architecture/sample_01/features/users/data/data_sources/remote/user_remote_data_source.dart';

@GenerateMocks([
  HttpClientAdapter,
  UserRemoteDataSource,
  // UserRepository,
  // FetchUsers,
  // PostRemoteDataSource,
  // PostRepository,
  // FetchPosts,
])
void generate() {}
