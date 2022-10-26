// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:widget_test_practice/constants.dart';

class Car {
  final int id;
  final String title;
  final String description;
  final String url;
  final double pricePerDay;
  final bool selected;
  final List<String> features;

  Car({
    required this.id,
    required this.title,
    required this.description,
    required this.url,
    required this.pricePerDay,
    required this.selected,
    required this.features,
  });

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json[carsIdKey],
      title: json[carsTitleKey],
      description: json[carsDescriptionKey],
      url: json[carsUrlKey],
      pricePerDay: json[carsPricePerDayKey],
      selected: false,
      features: json[carsFeaturesKey],
    );
  }
}

class CarsList {
  final List<Car>? items;

  CarsList(this.items, String? message);
}
