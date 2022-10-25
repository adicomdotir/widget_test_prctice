// ignore_for_file: public_member_api_docs, sort_constructors_first
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
}

class CarsList {
  CarsList(List<Car>? lists, String? message);
}
