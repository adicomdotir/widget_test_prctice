import 'package:widget_test_practice/models/car.dart';

abstract class CarsDataProvider {
  Future<CarsList> loadCars();
}
