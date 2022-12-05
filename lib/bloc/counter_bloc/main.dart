import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:widget_test_practice/bloc/counter_bloc/app.dart';
import 'package:widget_test_practice/bloc/counter_bloc/counter_observer.dart';

void main() {
  Bloc.observer = CounterObserver();
  runApp(const CounterApp());
}