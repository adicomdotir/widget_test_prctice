import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:widget_test_practice/clean_architecture/sample_01/shared/data/models/user_model.dart';

import '../../../fixtures/fixture.dart';
import '../../../mocks/mock_data.dart';
//
void main() {
  group(
    'UserModel serialization/deserialization',
    () {
      test(
        'user successfully serialized',
        () {
          final jsonResult = jsonDecode(fixture('user.json'));
          final fromJsonModel = UserModel.fromJson(jsonResult);

          expect(fromJsonModel, mockUser);
        },
      );

      test(
        'user successfully deserialized',
        () {
          final jsonResult = jsonDecode(fixture('user.json'));
          final mockUserToJson = mockUser.toJson();

          expect(jsonResult, equals(mockUserToJson));
        },
      );
    },
  );
}
