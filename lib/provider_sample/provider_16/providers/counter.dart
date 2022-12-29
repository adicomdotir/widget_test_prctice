import 'package:flutter/material.dart';

class Counter with ChangeNotifier {
  int counter = 0;

  Counter();

  void increment() {
    counter++;
    notifyListeners();
  }
}