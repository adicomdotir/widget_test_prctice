import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:widget_test_practice/clean_architecture/airplane_clean/data/models/domain/entities/user_entity.dart';
import 'package:widget_test_practice/clean_architecture/airplane_clean/data/models/user_model.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  const tUserModel = UserModel(
    id: '1',
    email: 'email@gmail.com',
    name: 'name',
    hobby: 'hobby',
    balance: 100,
  );

  test('should be a subclass of UserEntity', () async {
    expect(tUserModel, isA<UserEntity>());
  });

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap = jsonDecode(
        fixture('user.json'),
      );
      // act
      final result = UserModel.fromJson(tUserModel.id, jsonMap);
      // assert
      expect(result, tUserModel);
    });

    group('toJson', () {
      test('should return a json map containing proper data', () async {});
    });
  });
}
