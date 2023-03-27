import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:widget_test_practice/clean_architecture/airplane_clean/data/models/user_model.dart';
import 'package:widget_test_practice/clean_architecture/airplane_clean/domain/entities/user_entity.dart';

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
  });

  group('toJson', () {
    test('should return a json map containing proper data', () async {
      final result = tUserModel.toJson();

      final expectedMap = {
        'id': tUserModel.id,
        'email': tUserModel.email,
        'name': tUserModel.name,
        'hobby': tUserModel.hobby,
        'balance': tUserModel.balance,
      };

      expect(result, expectedMap);
    });
  });
}
