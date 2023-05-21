import 'package:dio/dio.dart';
import 'package:widget_test_practice/clean_architecture/sample_05/core%20/exception.dart';
import 'package:widget_test_practice/clean_architecture/sample_05/features/films/data/models/film_model.dart';
import 'package:widget_test_practice/clean_architecture/sample_05/features/films/domain/usecases%20/films_usecase.dart';

abstract class FilmRemoteDataSource {
  Future<List<FilmModel>> getFilms({required FilmsParams params});
}

class FilmsRemoteDataSourceImpl implements FilmRemoteDataSource {
  final Dio dio;
  final baseUrl = 'https://www.swapi.tech/api';

  FilmsRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<FilmModel>> getFilms({required FilmsParams params}) async {
    try {
      final response = await dio.get(baseUrl + params.path);
      switch (response.statusCode) {
        case 200:
          final result = (response.data['result']);
          final films = (result as List)
              .map((filmModel) => FilmModel.fromJson(filmModel))
              .toList();
          return films;
        case 400:
          throw ServerException(message: 'Bad Request');
        case 401:
          throw ServerException(message: 'Unathorized');
        case 500:
          throw ServerException(message: 'Internal Server Error');
        default:
          throw ServerException(message: 'Error');
      }
    } on TypeError catch (_) {
      throw CastException(message: 'Cast Error');
    } on UnsupportedError catch (_) {
      throw ServerException(message: 'Server Error');
    } catch (e) {
      rethrow;
    }
  }
}
