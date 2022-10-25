import 'package:driveme/dependency_injector.dart';
import 'package:driveme/models/car.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:driveme/list/cars_list_bloc.dart';
import 'package:driveme/list/cars_list_page.dart';
import 'package:driveme/constants.dart';

import '../database/mock_car_data_provider.dart';
import '../database/mock_car_data_provider_error.dart';

void main() {
  setupLocator();
  final carsListBloc = locator<CarsListBloc>();

  testWidgets(
    '''Cars are displayed with summary details, and selected car is highlighted 
    in blue.''',
    (WidgetTester tester) async {
      // TODO 4: Inject and Load Mock Car Data

      // TODO 5: Load & Sort Mock Data for Verification

      // TODO 6: Load and render Widget

      // TODO 7: Check Cars List's component's existence via key

      // TODO 9: Call Verify Car Details function

      // TODO 10: Select a Car

      // TODO 11: Verify that Car is highlighted in blue
    },
  );

  testWidgets(
    'Proper error message is shown when an error occurred',
    (WidgetTester tester) async {
      // TODO 12: Inject and Load Error Mock Car Data

      // TODO 13: Load and render Widget

      // TODO 14: Verify that Error Message is shown
    },
  );

  // TODO Replace testWidgets('''After encountering an error...'''
  testWidgets(
    '''After encountering an error, and stream is updated, Widget is also 
    updated.''',
    (WidgetTester tester) async {
      // TODO 15: Inject and Load Error Mock Car Data

      // TODO 16: Load and render Widget

      // TODO 17: Verify that Error Message and Retry Button is shown

      // TODO 18: Inject and Load Mock Car Data

      // TODO 19: Reload Widget

      // TODO 20: Load and Verify Car Data
    },
  );
}

// TODO 8: Create a function to verify list's existence

class ListPageWrapper extends StatelessWidget {
  const ListPageWrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ListPage(),
    );
  }
}
