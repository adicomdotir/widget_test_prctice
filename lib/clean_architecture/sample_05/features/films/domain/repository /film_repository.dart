import 'package:dartz/dartz.dart';
import 'package:widget_test_practice/clean_architecture/sample_05/core/failure.dart';
import 'package:widget_test_practice/clean_architecture/sample_05/features/films/domain/usecases%20/films_usecase.dart';

import '../entities/film.dart';

abstract class FilmRepository {
  Future<Either<Failure, List<Film>>> getFilms({required FilmsParams params});
  Future<Either<Failure, Film>> toggleFilmAsFavorite({
    required String uid,
    required FilmsParams params,
  });
}
