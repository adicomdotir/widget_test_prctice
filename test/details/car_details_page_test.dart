import 'package:widget_test_practice/constants.dart';
import 'package:widget_test_practice/dependency_injector.dart';
import 'package:widget_test_practice/models/car.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widget_test_practice/details/car_details_page.dart';
import 'package:widget_test_practice/list/cars_list_bloc.dart';

import '../database/mock_car_data_provider.dart';

CarsList? cars;

void main() {
  setupLocator();
  final carsListBloc = locator<CarsListBloc>();

  // TODO Replace testWidgets('Unselected Car Details Page...'
  testWidgets(
    'Unselected Car Details Page should be shown as Unselected',
    (WidgetTester tester) async {
      // TODO 21: Inject and Load Mock Car Data
      carsListBloc.injectDataProviderForTest(MockCarDataProvider());
      await carsListBloc.loadItems();

      // TODO 22: Load & Sort Mock Data for Verification
      final cars = await MockCarDataProvider().loadCars();
      cars.items?.sort(carsListBloc.alphabetizeItemsByTitleIgnoreCases);

      // TODO 23: Load and render Widget
      await tester.pumpWidget(const DetailsPageSelectedWrapper(2));
      await tester.pump(Duration.zero);

      // TODO 24: Verify Car Details
      final carDetailKey = find.byKey(const Key(carDetailsKey));
      expect(carDetailKey, findsOneWidget);
      final pageTitleFinder =
          find.text(cars.items![1].title); // 2nd car in sorted list
      expect(pageTitleFinder, findsOneWidget);

      final notSelectedTextFinder = find.text(notSelectedTitle);
      expect(notSelectedTextFinder, findsOneWidget);

      final descriptionTextFinder = find.text(cars.items![1].description);
      expect(descriptionTextFinder, findsOneWidget);

      final featuresTitleTextFinder = find.text(featuresTitle);
      expect(featuresTitleTextFinder, findsOneWidget);

      final allFeatures = StringBuffer();
      for (final feature in cars.items![1].features) {
        allFeatures.write('\n $feature \n');
      }

      final featureTextFinder = find.text(allFeatures.toString());
      await tester.ensureVisible(featureTextFinder);
      expect(featureTextFinder, findsOneWidget);

      final selectButtonFinder = find.text(selectButton);
      await tester.scrollUntilVisible(selectButtonFinder, 500.0);
      expect(selectButtonFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Selected Car Details Page should be shown as Selected',
    (WidgetTester tester) async {
      // TODO 25: Inject and Load Mock Car Data
      carsListBloc.injectDataProviderForTest(MockCarDataProvider());
      await carsListBloc.loadItems();

      // TODO 26: Load and render Widget
      await tester.pumpWidget(
          const DetailsPageSelectedWrapper(3)); // Hyundai Sonata 2017
      await tester.pump(Duration.zero);

      // TODO 27: Load Mock Data for Verification
      final actualCarsList = await MockCarDataProvider().loadCars();
      final actualCars = actualCarsList.items;

      // TODO 28: First Car is Selected, so Verify that
      final carDetailKey = find.byKey(const Key(carDetailsKey));
      expect(carDetailKey, findsOneWidget);

      final pageTitleFinder = find.text(actualCars![2].title);
      expect(pageTitleFinder, findsOneWidget);

      final notSelectedTextFinder = find.text(selectedTitle);
      expect(notSelectedTextFinder, findsOneWidget);

      final descriptionTextFinder = find.text(actualCars![2].description);
      expect(descriptionTextFinder, findsOneWidget);

      final featuresTitleTextFinder = find.text(featuresTitle);
      expect(featuresTitleTextFinder, findsOneWidget);

      final actualFeaturesStringBuffer = StringBuffer();
      for (final feature in actualCars![2].features) {
        actualFeaturesStringBuffer.write('\n $feature \n');
      }

      final featuresTextFinder =
          find.text(actualFeaturesStringBuffer.toString());
      await tester.ensureVisible(featuresTextFinder);
      expect(featuresTextFinder, findsOneWidget);

      final selectButtonFinder = find.text(removeButton);
      //await tester.ensureVisible(selectButtonFinder);
      await tester.scrollUntilVisible(selectButtonFinder, 500.0);

      expect(selectButtonFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Selecting Car Updates the Widget',
    (WidgetTester tester) async {
      // TODO 29: Inject and Load Mock Car Data
      carsListBloc.injectDataProviderForTest(MockCarDataProvider());
      await carsListBloc.loadItems();

      // TODO 30: Load & Sort Mock Data for Verification
      final cars = await MockCarDataProvider().loadCars();
      cars.items?.sort(carsListBloc.alphabetizeItemsByTitleIgnoreCases);

      // TODO 31: Load and render Widget for the first car
      await tester.pumpWidget(
          const DetailsPageSelectedWrapper(2)); // Mercedes-Benz 2017
      await tester.pump(Duration.zero);

      // TODO 32: Tap on Select and Deselect to ensure widget updates
      final selectButtonFinder = find.text(selectButton);
      await tester.scrollUntilVisible(selectButtonFinder, 500.0);
      await tester.tap(selectButtonFinder);

      await tester.pump(Duration.zero);

      final deselectButtonFinder = find.text(removeButton);
      //await tester.ensureVisible(deselectButtonFinder);
      await tester.scrollUntilVisible(deselectButtonFinder, 500.0);

      await tester.tap(deselectButtonFinder);

      await tester.pump(Duration.zero);

      final newSelectButtonFinder = find.text(selectButton);
      //await tester.ensureVisible(newSelectButtonFinder);
      await tester.scrollUntilVisible(newSelectButtonFinder, 500.0);

      expect(newSelectButtonFinder, findsOneWidget);
    },
  );
}

class DetailsPageSelectedWrapper extends StatelessWidget {
  final int id;

  const DetailsPageSelectedWrapper(this.id, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CarDetailsPage(id: id),
    );
  }
}
