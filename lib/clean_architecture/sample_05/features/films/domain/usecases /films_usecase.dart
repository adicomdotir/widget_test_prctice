import 'package:dartz/dartz.dart';
import 'package:widget_test_practice/clean_architecture/sample_05/core/failure.dart';
import 'package:widget_test_practice/clean_architecture/sample_05/features/films/domain/repository%20/film_repository.dart';

import '../entities/film.dart';

class FilmsParams {
  final String path;
  FilmsParams({
    required this.path,
  });
}

class FilmsUsecase implements FilmRepository {
  final FilmRepository repository;

  FilmsUsecase({required this.repository});

  @override
  Future<Either<Failure, List<Film>>> getFilms({
    required FilmsParams params,
  }) async {
    return await repository.getFilms(params: params);
  }

  @override
  Future<Either<Failure, Film>> toggleFilmAsFavorite({
    required String uid,
    required FilmsParams params,
  }) async {
    return await repository.toggleFilmAsFavorite(uid: uid, params: params);
  }
}
