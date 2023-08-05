import 'package:widget_test_practice/clean_architecture/sample_07/core/error/exception.dart';
import 'package:widget_test_practice/clean_architecture/sample_07/data/data_sources/remote_data_source.dart';
import 'package:widget_test_practice/clean_architecture/sample_07/domain/entities/weather_entitiy.dart';
import 'package:widget_test_practice/clean_architecture/sample_07/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:widget_test_practice/clean_architecture/sample_07/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl extends WeatherRepository {
  final WeatherRemoteDataSource weatherRemoteDataSource;

  WeatherRepositoryImpl({required this.weatherRemoteDataSource});

  @override
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(
    String cityName,
  ) async {
    try {
      final result = await weatherRemoteDataSource.getCurrentWeather(cityName);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure('An error has occurred'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
