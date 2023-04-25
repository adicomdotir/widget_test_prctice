import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:widget_test_practice/clean_architecture/sample_aec/features/home/data/models/people_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<PeopleModel>> getPeoples();
}

class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  @override
  Future<List<PeopleModel>> getPeoples() async {
    final result = await http.get(
      Uri.parse('http://127.0.0.1:5500/apis/people.json'),
    );
    return (jsonDecode(result.body) as List<dynamic>).map((element) {
      return PeopleModel.fromMap(element);
    }).toList();
  }
}
