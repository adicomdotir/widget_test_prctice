import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:widget_test_practice/constants.dart';
import 'package:widget_test_practice/list/cars_list_bloc.dart';
import 'package:widget_test_practice/models/car.dart';

class CarsDatabase extends CarsDataProvider {
  @override
  Future<CarsList> loadCars() async {
    try {
      final parsed = List<dynamic>.from(
          json.decode(await rootBundle.loadString(dataJsonFilePath))[carsKey]);
      final list = parsed.map((json) => Car.fromJson(json)).toList();
      return CarsList(
        list,
        null,
      );
    } catch (exception) {
      return CarsList(
        null,
        exception.toString(),
      );
    }
  }
}
