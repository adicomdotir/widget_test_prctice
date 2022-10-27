import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:widget_test_practice/core/api/movies_endppoint.dart';
import 'package:widget_test_practice/data/datasources/movies/movies_remote_data_source.dart';
import 'package:widget_test_practice/core/api/movies_api.dart';

import '../../../fixtures/fixture_reader.dart';
import 'movies_remote_data_source_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late MoviesRemoteDataSourceImpl dataSource;
  late MockClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockClient();
    dataSource = MoviesRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockHttpClientSuccess200(String jsonFile) {
    when(mockHttpClient.get(any)).thenAnswer(
      (_) async => http.Response(
        fixture(jsonFile),
        200,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        },
      ),
    );
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(any)).thenAnswer(
      (_) async => http.Response('Something went wrong', 404),
    );
  }

  group('getMovies', () {
    final tLanguage = MoviesApi.en;
    final tEndpoint = MoviesEndpoint.withGenre;

    test(
      'should preform a GET request on a URL',
      () {
        // arrange
        setUpMockHttpClientSuccess200('movies_now_playing.json');
        // act
        dataSource.getMovies(tEndpoint, tLanguage, -1);
        // assert
        verify(mockHttpClient.get(
          MoviesApi.getMovies(tEndpoint, tLanguage, -1),
        ));
      },
    );

    test(
      'should return List<Movie> when response code is 200 (success)',
      () async {
        // arrange
        setUpMockHttpClientSuccess200('movies_now_playing.json');
        // act
        final result = await dataSource.getMovies(tEndpoint, tLanguage, -1);
        // arrange
        expect(result, isA<List<Movie>>());
      },
    );

    test(
      'should throw a ServerException when response code is 404 or other',
      () async {
        // arrange
        setUpMockHttpClientFailure404();
        // act
        final call = dataSource.getMovies;
        // assert
        expect(
          () => call(tEndpoint, tLanguage, -1),
          throwsA(TypeMatcher<ServerException>()),
        );
      },
    );
  });

  group('searchMovies', () {
    final tLanguage = MoviesApi.es;
    final tQuery = 'k';

    test(
      'should return List<Movie> when response code is 200 (success)',
      () async {
        // arrange
        setUpMockHttpClientSuccess200('movies_now_playing.json');
        // act
        final result = await dataSource.searchMovies(tLanguage, tQuery);
        // assert
        expect(result, isA<List<Movie>>());
      },
    );

    test(
      'should throw a ServerException when response code is 404 or other',
      () async {
        // arrange
        setUpMockHttpClientFailure404();
        // act
        final call = dataSource.searchMovies;
        // assert
        expect(
          () => call(tLanguage, tQuery),
          throwsA(TypeMatcher<ServerException>()),
        );
      },
    );
  });

  group('getMovieDetail', () {
    final tLanguage = MoviesApi.es;
    final tMovieId = 399566;

    test(
      'should return a Movie when response code is 200 (success)',
      () async {
        // arrange
        setUpMockHttpClientSuccess200('movie_detail.json');
        // act
        final result = await dataSource.getMovieDetail(tLanguage, tMovieId);
        // assert
        expect(result, isA<Movie>());
      },
    );

    test(
      'should throw a ServerException when response code is 404 or other',
      () async {
        // arrange
        setUpMockHttpClientFailure404();
        // act
        final call = dataSource.getMovieDetail;
        // assert
        expect(
          () => call(tLanguage, tMovieId),
          throwsA(TypeMatcher<ServerException>()),
        );
      },
    );
  });
}
