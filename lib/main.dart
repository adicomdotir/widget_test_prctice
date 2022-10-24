import 'constants.dart';
import 'dependency_injector.dart';
import 'package:flutter/material.dart';
import 'details/car_details_bloc.dart';
import 'list/cars_list_bloc.dart';
import 'list/cars_list_page.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  var carsListBloc = locator<CarsListBloc>();
  var carDetailsBloc = locator<CarDetailsBloc>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ListPage(),
    );
  }

  @override
  void dispose() {
    carsListBloc.dispose();
    carDetailsBloc.dispose();
    super.dispose();
  }
}
