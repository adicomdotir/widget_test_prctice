abstract class BaseApiService {
  final String baseUrl = 'newsapi.org';
  final String apiKey = 'your_api_key';

  Future<dynamic> getAllNewsResponse(
    String url,
    String countryCode,
    String newsType,
  );
}
