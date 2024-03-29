import 'package:dartz/dartz.dart';
import 'package:widget_test_practice/clean_architecture/sample_05/core%20/exception.dart';
import 'package:widget_test_practice/clean_architecture/sample_05/core/failure.dart';
import 'package:widget_test_practice/clean_architecture/sample_05/features/films/data/datasources%20/film_local_datasource.dart';
import 'package:widget_test_practice/clean_architecture/sample_05/features/films/data/datasources%20/film_remote_datasource.dart';
import 'package:widget_test_practice/clean_architecture/sample_05/features/films/domain/entities/film.dart';
import 'package:widget_test_practice/clean_architecture/sample_05/features/films/domain/repository%20/film_repository.dart';
import 'package:widget_test_practice/clean_architecture/sample_05/features/films/domain/usecases%20/films_usecase.dart';

class FilmRepositoryImpl implements FilmRepository {
  final FilmRemoteDataSource remoteDataSource;
  final FilmLocalDataSource localDataSource;

  FilmRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<Film>>> getFilms({
    required FilmsParams params,
  }) async {
    try {
      final filmModels = await localDataSource.getFilms();
      final films = filmModels.map((film) => Film.fromModel(film)).toList();
      return Right(films);
    } on CacheException catch (_) {
      try {
        final filmModels = await remoteDataSource.getFilms(params: params);
        localDataSource.saveFilms(filmModels: filmModels);
        final films = filmModels.map((film) => Film.fromModel(film)).toList();
        return Right(films);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      } on CastException catch (e) {
        return Left(CastFailure(message: e.message));
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, Film>> toggleFilmAsFavorite({
    required String uid,
    required FilmsParams params,
  }) async {
    try {
      final filmModel =
          await localDataSource.toggleFilmAsFavorite(params: params, uid: uid);
      final film = Film.fromModel(filmModel);
      return Right(film);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }
}
