import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:widget_test_practice/clean_architecture/sample_02/core/error/exceptions.dart';
import 'package:widget_test_practice/clean_architecture/sample_02/features/number_trivia/data/models/number_trivia_model.dart';

abstract class NumberTriviaLocalDataSource {
  Future<void> cacheNumberTrivia(NumberTriviaModel remoteTrivia);

  Future<NumberTriviaModel> getLastNumberTrivia();
}

const CACHED_NUMBER_TRIVIA = 'CACHED_NUMBER_TRIVIA';

class NumberTriviaLocalDataSourceImpl extends NumberTriviaLocalDataSource {
  final SharedPreferences sharedPreferences;

  NumberTriviaLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel remoteTrivia) {
    return sharedPreferences.setString(
      CACHED_NUMBER_TRIVIA,
      jsonEncode(remoteTrivia.toJson()),
    );
  }

  @override
  Future<NumberTriviaModel> getLastNumberTrivia() {
    final json = sharedPreferences.getString(CACHED_NUMBER_TRIVIA);
    if (json == null) {
      throw CacheException();
    } else {
      final numberTriviaModel = NumberTriviaModel.fromJson(jsonDecode(json));
      return Future.value(numberTriviaModel);
    }
  }
}
