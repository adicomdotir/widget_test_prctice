import 'package:dartz/dartz.dart';
import 'package:widget_test_practice/clean_architecture/sample_07/core/error/failure.dart';
import 'package:widget_test_practice/clean_architecture/sample_07/domain/entities/weather_entitiy.dart';
import 'package:widget_test_practice/clean_architecture/sample_07/domain/repositories/weather_repository.dart';

class GetCurrentWeatherUseCase {
  final WeatherRepository weatherRepository;

  GetCurrentWeatherUseCase({required this.weatherRepository});

  Future<Either<Failure, WeatherEntity>> execute(String cityName) {
    return weatherRepository.getCurrentWeather(cityName);
  }
}
