import 'package:dio/dio.dart';
import 'package:widget_test_practice/dio_sample/api_endpoint.dart';
import 'package:widget_test_practice/dio_sample/api_service.dart';
import 'package:widget_test_practice/dio_sample/custom_exception.dart';
import 'package:widget_test_practice/dio_sample/dio_service.dart';

void main() async {
  Dio dio = Dio();
  final apiService = ApiService(DioService(dioClient: dio));
  apiService.getDocumentData(
    endpoint: ApiEndpoint.auth(AuthEndpoint.LOGIN),
    requiresAuthToken: false,
    converter: (response) {
      // print((response as CustomException).code);
      // print((response as CustomException).exceptionType);
      // print((response as CustomException).message);
      // print((response as CustomException).name);
      // print((response as CustomException).statusCode);
    },
  );
}
