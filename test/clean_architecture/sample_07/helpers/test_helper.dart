import 'package:mockito/annotations.dart';
import 'package:widget_test_practice/clean_architecture/sample_07/data/data_sources/remote_data_source.dart';
import 'package:widget_test_practice/clean_architecture/sample_07/domain/repositories/weather_repository.dart';
import 'package:http/http.dart' as http;

@GenerateMocks(
  [
    WeatherRepository,
    WeatherRemoteDataSource,
  ],
  customMocks: [MockSpec<http.Client>(as: #MockHttpClient)],
)
void main() {}
