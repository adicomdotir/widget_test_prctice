import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:widget_test_practice/clean_architecture/sample_07/core/constants/constants.dart';
import 'package:widget_test_practice/clean_architecture/sample_07/core/error/exception.dart';
import 'package:widget_test_practice/clean_architecture/sample_07/data/models/weather_model.dart';

abstract class WeatherRemoteDataSource {
  Future<WeatherModel> getCurrentWeather(String cityName);
}

class WeatherRemoteDataSourceImpl extends WeatherRemoteDataSource {
  final http.Client client;

  WeatherRemoteDataSourceImpl({required this.client});

  @override
  Future<WeatherModel> getCurrentWeather(String cityName) async {
    final response =
        await client.get(Uri.parse(Urls.currentWeatherByName(cityName)));

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }
}
