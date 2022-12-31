import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widget_test_practice/clean_architecture/sample_01/features/users/data/data_sources/remote/user_remote_data_source.dart';
import 'package:widget_test_practice/clean_architecture/sample_01/shared/data/models/user_model.dart';

import '../../../../../fixtures/fixture.dart';
import '../../../../../mocks/generated.mocks.dart';
import '../../../../../utils/dio_response_stub.dart';

void main() {
  group(
    'UserRemoteDataSource',
    () {
      late final MockHttpClientAdapter adapter;
      late final UserRemoteDataSource dataSource;

      setUpAll(
        () {
          adapter = MockHttpClientAdapter();
          dataSource = UserRemoteDataSourceImpl(
            Dio()..httpClientAdapter = adapter,
          );
        },
      );

      test(
        'fetching data successfully',
        () async {
          final userList = jsonDecode(fixture('users.json')) as List<dynamic>;
          final users = userList.map((e) => UserModel.fromJson(e)).toList();

          adapter.createMockResponseStub(json.encode(userList), 200);

          final result = await dataSource.fetchUsers();

          expect(result, users);
        },
      );

      test(
        'fetching data unsuccessfully',
        () async {
          adapter.createMockResponseStub('Error happened', 404);

          final call = dataSource.fetchUsers;

          expect(call, throwsA(const TypeMatcher<DioError>()));
        },
      );
    },
  );
}
