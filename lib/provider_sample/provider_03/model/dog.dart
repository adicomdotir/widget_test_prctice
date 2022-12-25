import 'package:flutter/material.dart';

class Dog extends ChangeNotifier {
  final String name;
  final String breed;
  int age;

  Dog({
    required this.name,
    required this.breed,
    this.age = 1,
  });

  void grow() {
    age++;
    notifyListeners();
    print('Age: $age');
  }
}
