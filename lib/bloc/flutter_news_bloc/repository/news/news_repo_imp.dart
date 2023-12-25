import 'package:flutter/services.dart';
import 'package:widget_test_practice/bloc/flutter_news_bloc/data/remote/api_endpoints.dart';
import 'package:widget_test_practice/bloc/flutter_news_bloc/data/remote/base_api_service.dart';
import 'package:widget_test_practice/bloc/flutter_news_bloc/data/remote/network_api_service.dart';

import 'news_repo.dart';

class NewsRepoImp extends NewsRepo {
  final BaseApiService _apiService = NetworkApiService();
  static const int _pageSize = 10;

  //. This method read data from server
  @override
  Future getNewsData(String countryCode, String newsType) async {
    try {
      dynamic response = await _apiService.getAllNewsResponse(
        ApiEndPoints().getNewsList,
        countryCode,
        newsType,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // This method read data from local JSON file
  @override
  Future getCountriesData() async {
    try {
      dynamic response =
          await rootBundle.loadString('assets/json/countries_data.json');
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
