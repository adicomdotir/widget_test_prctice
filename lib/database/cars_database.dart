import 'dart:async';
import 'dart:convert';
import '../models/car.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../list/cars_list_bloc.dart';
import '../constants.dart';

class CarsDatabase implements CarsDataProvider {
  static final CarsDatabase _instance = CarsDatabase._internal();

  factory CarsDatabase() {
    return _instance;
  }

  CarsDatabase._internal();

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
