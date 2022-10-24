import '../constants.dart';

class Car {
  final int id;
  final String title;
  final String description;
  final String url;
  final double pricePerDay;
  bool selected;
  final List<dynamic> features;

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

  final String? errorMessage;

  CarsList(
    this.items,
    this.errorMessage,
  );
}
