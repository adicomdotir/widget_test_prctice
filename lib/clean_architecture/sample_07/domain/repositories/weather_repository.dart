import 'package:dartz/dartz.dart';
import 'package:widget_test_practice/clean_architecture/sample_07/core/error/failure.dart';
import 'package:widget_test_practice/clean_architecture/sample_07/domain/entities/weather_entitiy.dart';

abstract class WeatherRepository {
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(String cityName);
}
