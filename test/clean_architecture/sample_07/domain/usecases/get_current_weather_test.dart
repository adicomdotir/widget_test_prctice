import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:widget_test_practice/clean_architecture/sample_07/domain/entities/weather_entitiy.dart';
import 'package:widget_test_practice/clean_architecture/sample_07/domain/usecases/get_current_weather.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetCurrentWeatherUseCase getCurrentWeatherUseCase;
  late MockWeatherRepository mockWeatherRepository;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    getCurrentWeatherUseCase =
        GetCurrentWeatherUseCase(weatherRepository: mockWeatherRepository);
  });

  const testCityName = 'Ardabil';
  const testWeatherEntity = WeatherEntity(
    cityName: 'cityName',
    main: 'main',
    description: 'description',
    iconCode: 'iconCode',
    temperature: 5.0,
    pressure: 0,
    humidity: 0,
  );

  test('should get current weather detail from the repository', () async {
    // arrange
    when(mockWeatherRepository.getCurrentWeather(testCityName))
        .thenAnswer((_) async => const Right(testWeatherEntity));
    // act
    final result = await getCurrentWeatherUseCase.execute(testCityName);
    // assert
    expect(result, const Right(testWeatherEntity));
  });
}
