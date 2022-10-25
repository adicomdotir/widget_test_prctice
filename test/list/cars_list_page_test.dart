import 'package:widget_test_practice/dependency_injector.dart';
import 'package:widget_test_practice/models/car.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widget_test_practice/list/cars_list_bloc.dart';
import 'package:widget_test_practice/list/cars_list_page.dart';
import 'package:widget_test_practice/constants.dart';

import '../database/mock_car_data_provider.dart';
import '../database/mock_car_data_provider_error.dart';

void main() {
  setupLocator();
  final carsListBloc = locator<CarsListBloc>();

  testWidgets(
    '''Cars are displayed with summary details, and selected car is highlighted 
    in blue.''',
    (WidgetTester tester) async {
      carsListBloc.injectDataProviderForTest(MockCarDataProvider());

      final cars = await MockCarDataProvider().loadCars();
      cars.items?.sort(carsListBloc.alphabetizeItemsByTitleIgnoreCases);

      await tester.pumpWidget(const ListPageWrapper());
      await tester.pump(Duration.zero);

      final carListKey = find.byKey(const Key(carsListKey));
      expect(carListKey, findsOneWidget);

      _verifyAllCarDetails(cars.items!, tester);

      carsListBloc.selectItem(1);

      // 1
      bool widgetSelectedPredicate(Widget widget) =>
          widget is Card && widget.color == Colors.blue.shade200;
      // 2
      bool widgetUnselectedPredicate(Widget widget) =>
          widget is Card && widget.color == Colors.white;

      expect(
        find.byWidgetPredicate(widgetSelectedPredicate),
        findsOneWidget,
      );
      expect(
        find.byWidgetPredicate(widgetUnselectedPredicate),
        findsNWidgets(5),
      );
    },
  );

  testWidgets(
    'Proper error message is shown when an error occurred',
    (WidgetTester tester) async {
      carsListBloc.injectDataProviderForTest(MockCarDataProviderError());

      await tester.pumpWidget(const ListPageWrapper());
      await tester.pump(Duration.zero);

      final errorFinder = find.text(
        errorMessage.replaceFirst(
          errorMessage,
          mockErrorMessage,
        ),
      );
      expect(errorFinder, findsOneWidget);
    },
  );

  testWidgets(
    '''After encountering an error, and stream is updated, Widget is also 
    updated.''',
    (WidgetTester tester) async {
      carsListBloc.injectDataProviderForTest(MockCarDataProviderError());

      await tester.pumpWidget(const ListPageWrapper());
      await tester.pump(Duration.zero);

      final errorFinder = find.text(
        errorMessage.replaceFirst(
          errorMessage,
          mockErrorMessage,
        ),
      );
      final retryButtonFinder = find.text(retryButton);
      expect(errorFinder, findsOneWidget);
      expect(retryButtonFinder, findsOneWidget);

      carsListBloc.injectDataProviderForTest(MockCarDataProvider());
      await tester.tap(retryButtonFinder);

      await tester.pump(Duration.zero);

      final cars = await MockCarDataProvider().loadCars();
      _verifyAllCarDetails(cars.items!, tester);
    },
  );
}

void _verifyAllCarDetails(
  List<Car> carsList,
  WidgetTester tester,
) async {
  for (final car in carsList) {
    final carTitleFinder = find.text(car.title);
    final carPricePerDayFinder = find.text(
      pricePerDayText.replaceFirst(
        wildString,
        car.pricePerDay.toStringAsFixed(2),
      ),
    );
    await tester.ensureVisible(carTitleFinder);
    expect(carTitleFinder, findsOneWidget);
    await tester.ensureVisible(carPricePerDayFinder);
    expect(carPricePerDayFinder, findsOneWidget);
  }
}

class ListPageWrapper extends StatelessWidget {
  const ListPageWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ListPage(),
    );
  }
}
