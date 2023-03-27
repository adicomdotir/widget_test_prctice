// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:widget_test_practice/clean_architecture/airplane_clean/domain/entities/destination_entity.dart';

class DestinationModel extends DestinationEntity {
  final String id;
  final String name;
  final String city;
  final String imageUrl;
  final double rating;
  final int price;

  const DestinationModel({
    required this.id,
    required this.name,
    required this.city,
    required this.imageUrl,
    required this.rating,
    required this.price,
  }) : super();

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'city': city,
      'imageUrl': imageUrl,
      'rating': rating,
      'price': price,
    };
  }

  factory DestinationModel.fromJson(String id, Map<String, dynamic> map) {
    return DestinationModel(
      id: map['id'] as String,
      name: map['name'] as String,
      city: map['city'] as String,
      imageUrl: map['imageUrl'] as String,
      rating: map['rating'] as double,
      price: map['price'] as int,
    );
  }
}
