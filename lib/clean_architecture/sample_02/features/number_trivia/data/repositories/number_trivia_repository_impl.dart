import 'package:widget_test_practice/clean_architecture/sample_02/core/error/exceptions.dart';
import 'package:widget_test_practice/clean_architecture/sample_02/core/network/network_info.dart';
import 'package:widget_test_practice/clean_architecture/sample_02/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:widget_test_practice/clean_architecture/sample_02/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:widget_test_practice/clean_architecture/sample_02/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:widget_test_practice/clean_architecture/sample_02/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:widget_test_practice/clean_architecture/sample_02/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:widget_test_practice/clean_architecture/sample_02/features/number_trivia/domain/repositories/number_trivia_repository.dart';

typedef _ConcreteOrRandomChooser = Future<TriviaNumber> Function();

class NumberTriviaRepositoryImpl extends NumberTriviaRepository {
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NumberTriviaRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, TriviaNumber>> getConcreteNumberTrivia(
    int number,
  ) async {
    return await _getTrivia(
      () => remoteDataSource.getConcreteNumberTrivia(number),
    );
  }

  @override
  Future<Either<Failure, TriviaNumber>> getRandomNumberTrivia() async {
    return await _getTrivia(() => remoteDataSource.getRandomNumberTrivia());
  }

  Future<Either<Failure, TriviaNumber>> _getTrivia(
    _ConcreteOrRandomChooser getConcreteOrRandom,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTrivia = await getConcreteOrRandom();
        localDataSource.cacheNumberTrivia(remoteTrivia as NumberTriviaModel);
        return Right(remoteTrivia);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localTrivia = await localDataSource.getLastNumberTrivia();
        return Right(localTrivia);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
