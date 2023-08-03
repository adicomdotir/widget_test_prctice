import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:widget_test_practice/clean_architecture/sample_07/data/models/weather_model.dart';
import 'package:widget_test_practice/clean_architecture/sample_07/domain/entities/weather_entitiy.dart';

import '../../helpers/json_reader.dart';

void main() {
  const testWeatherModel = WeatherModel(
    cityName: 'cityName',
    main: 'main',
    description: 'description',
    iconCode: 'iconCode',
    temperature: 0.0,
    pressure: 0,
    humidity: 0,
  );

  test('should be a subclass of weather entity', () async {
    // assert
    expect(testWeatherModel, isA<WeatherEntity>());
  });

  test('should return a valid model from json', () async {
    // arrange
    final Map<String, dynamic> jsonMap = jsonDecode(
      readJson(
        'clean_architecture/sample_07/helpers/dummy_data/dummy_weather_response.json',
      ),
    );
    // act
    final result = WeatherModel.fromJson(jsonMap);
    // assert
    expect(result, equals(testWeatherModel));
  });

  test('should return a json map containing proper data', () async {
    // arrange

    // act
    final result = testWeatherModel.toJson();
    // assert
    final expectedJsonMap = {
      'name': 'cityName',
      'weather': [
        {
          'main': 'main',
          'description': 'description',
          'icon': 'iconCode',
        }
      ],
      'main': {
        'temperature': 0.0,
        'pressure': 0,
        'humidity': 0,
      }
    };
    expect(result, equals(expectedJsonMap));
  });
}
