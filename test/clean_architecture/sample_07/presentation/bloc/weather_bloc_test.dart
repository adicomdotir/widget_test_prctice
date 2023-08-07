import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:widget_test_practice/clean_architecture/sample_07/core/error/failure.dart';
import 'package:widget_test_practice/clean_architecture/sample_07/domain/entities/weather_entitiy.dart';
import 'package:widget_test_practice/clean_architecture/sample_07/presentation/bloc/weather_bloc.dart';
import 'package:widget_test_practice/clean_architecture/sample_07/presentation/bloc/weather_event.dart';
import 'package:widget_test_practice/clean_architecture/sample_07/presentation/bloc/weather_state.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetCurrentWeatherUseCase mockGetCurrentWeatherUseCase;
  late WeatherBloc weatherBloc;

  setUp(() {
    mockGetCurrentWeatherUseCase = MockGetCurrentWeatherUseCase();
    weatherBloc = WeatherBloc(mockGetCurrentWeatherUseCase);
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

  test('initial state should be empty', () async {
    expect(weatherBloc.state, WeatherEmpty());
  });

  blocTest<WeatherBloc, WeatherState>(
    'should emit [WeatherLoading, WeatherLoaded] when data is gotten successfully',
    build: () {
      when(mockGetCurrentWeatherUseCase.execute(testCityName))
          .thenAnswer((_) async => const Right(testWeatherEntity));
      return weatherBloc;
    },
    act: (bloc) => bloc.add(const OnCityChanged(testCityName)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      WeatherLoading(),
      const WeatherLoaded(testWeatherEntity),
    ],
  );

  blocTest<WeatherBloc, WeatherState>(
    'should emit [WeatherLoading, WeatherLoadFailure] when get data is unsuccessful',
    build: () {
      when(mockGetCurrentWeatherUseCase.execute(testCityName))
          .thenAnswer((_) async => const Left(ServerFailure('Server failure')));
      return weatherBloc;
    },
    act: (bloc) => bloc.add(const OnCityChanged(testCityName)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      WeatherLoading(),
      const WeatherLoadFail('Server failure'),
    ],
  );
}
