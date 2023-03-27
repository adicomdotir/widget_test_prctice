import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:widget_test_practice/clean_architecture/airplane_clean/data/models/destination_model.dart';
import 'package:widget_test_practice/clean_architecture/airplane_clean/domain/entities/destination_entity.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  const tDestinationModel = DestinationModel(
    id: '1',
    name: 'name',
    city: 'city',
    imageUrl: 'imageUrl',
    rating: 1.0,
    price: 1,
  );

  test('should be a subclass of DestinationEntity', () async {
    expect(tDestinationModel, isA<DestinationEntity>());
  });

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap = jsonDecode(
        fixture('destination.json'),
      );
      // act
      final result = DestinationModel.fromJson(tDestinationModel.id, jsonMap);
      // assert
      expect(result, tDestinationModel);
    });
  });

  group('toJson', () {
    test('should return a json map containing proper data', () async {
      final result = tDestinationModel.toJson();

      final expectedMap = {
        'id': tDestinationModel.id,
        'name': tDestinationModel.name,
        'city': tDestinationModel.city,
        'imageUrl': tDestinationModel.imageUrl,
        'rating': tDestinationModel.rating,
        'price': tDestinationModel.price,
      };

      expect(result, expectedMap);
    });
  });
}
