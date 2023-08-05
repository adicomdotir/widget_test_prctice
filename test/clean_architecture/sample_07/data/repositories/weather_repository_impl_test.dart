import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:widget_test_practice/clean_architecture/sample_07/core/error/exception.dart';
import 'package:widget_test_practice/clean_architecture/sample_07/core/error/failure.dart';
import 'package:widget_test_practice/clean_architecture/sample_07/data/models/weather_model.dart';
import 'package:widget_test_practice/clean_architecture/sample_07/data/repositories/weather_repository_impl.dart';
import 'package:widget_test_practice/clean_architecture/sample_07/domain/entities/weather_entitiy.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockWeatherRemoteDataSource mockWeatherRemoteDataSource;
  late WeatherRepositoryImpl weatherRepositoryImpl;

  setUp(() {
    mockWeatherRemoteDataSource = MockWeatherRemoteDataSource();
    weatherRepositoryImpl = WeatherRepositoryImpl(
      weatherRemoteDataSource: mockWeatherRemoteDataSource,
    );
  });

  const testWeatherModel = WeatherModel(
    cityName: 'cityName',
    main: 'main',
    description: 'description',
    iconCode: 'iconCode',
    temperature: 0.0,
    pressure: 0,
    humidity: 0,
  );

  const testWeatherEntity = WeatherEntity(
    cityName: 'cityName',
    main: 'main',
    description: 'description',
    iconCode: 'iconCode',
    temperature: 0.0,
    pressure: 0,
    humidity: 0,
  );

  const testCityName = 'Ardabil';

  group('get current weather', () {
    test(
      'should return current weather when a call to data source is successfull',
      () async {
        // arrange
        when(mockWeatherRemoteDataSource.getCurrentWeather(testCityName))
            .thenAnswer((_) async => testWeatherModel);

        // act
        final result =
            await weatherRepositoryImpl.getCurrentWeather(testCityName);

        // assert
        expect(result, equals(const Right(testWeatherEntity)));
      },
    );

    test(
      'should return server failure when a call to data source is unsuccessfull',
      () async {
        // arrange
        when(mockWeatherRemoteDataSource.getCurrentWeather(testCityName))
            .thenThrow(ServerException());

        // act
        final result =
            await weatherRepositoryImpl.getCurrentWeather(testCityName);

        // assert
        expect(
          result,
          equals(const Left(ServerFailure('An error has occurred'))),
        );
      },
    );

    test(
      'should return connection failure when the device has no internet',
      () async {
        // arrange
        when(mockWeatherRemoteDataSource.getCurrentWeather(testCityName))
            .thenThrow(SocketException());

        // act
        final result =
            await weatherRepositoryImpl.getCurrentWeather(testCityName);

        // assert
        expect(
          result,
          equals(
            const Left(
              ConnectionFailure('Failed to connect to the network'),
            ),
          ),
        );
      },
    );
  });
}
