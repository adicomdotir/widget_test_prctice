import 'package:http/http.dart' as http;
import 'package:widget_test_practice/core/api/movies_api.dart';

abstract class MoviesRemoteDataSource {
  Future<List<Movie>> getMovies(
    String endpoint,
    String language,
    int genreId,
  );
}

class MoviesRemoteDataSourceImpl extends MoviesRemoteDataSource {
  final http.Client client;

  MoviesRemoteDataSourceImpl({required this.client});

  @override
  Future<List<Movie>> getMovies(
      String endpoint, String language, int genreId) async {
    final response =
        await client.get(MoviesApi.getMovies(endpoint, language, genreId));
    if (response.statusCode == 200) {}
  }
}
