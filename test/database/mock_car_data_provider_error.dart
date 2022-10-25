import 'package:widget_test_practice/list/cars_list_bloc.dart';
import 'package:widget_test_practice/models/car.dart';

const String mockErrorMessage = 'This is an error message';

// TODO 2: Read the Mock Test Error Data
class MockCarDataProviderError implements CarsDataProvider {
  @override
  Future<CarsList> loadCars() {
    return Future.value(CarsList(null, mockErrorMessage));
  }
}
