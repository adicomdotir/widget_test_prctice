import 'package:widget_test_practice/dependency_injector.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widget_test_practice/list/cars_list_bloc.dart';
import '../database/mock_car_data_provider.dart';

void main() {
  setupLocator();
  final carsListBloc = locator<CarsListBloc>();

  test(
    'List of Cars is well sorted in alphabetical order',
    () async {
      carsListBloc.injectDataProviderForTest(MockCarDataProvider());
      carsListBloc.loadItems();

      final carsListData = await carsListBloc.outCars.take(1).toList();
      final carsList = carsListData.first.items;

      final databaseCarsData = await MockCarDataProvider().loadCars();
      databaseCarsData.items
          ?.sort(carsListBloc.alphabetizeItemsByTitleIgnoreCases);

      for (var i = 0; i < carsList!.length; i++) {
        final actualTitle = carsList.elementAt(i).title;
        final expectedTitle = databaseCarsData.items![i].title;
        expect(actualTitle, equals(expectedTitle));

        final actualDescription = carsList.elementAt(i).description;
        final expectedDescription = databaseCarsData.items![i].description;
        expect(actualDescription, equals(expectedDescription));

        final actualPricePerDay = carsList.elementAt(i).pricePerDay;
        final expectedPricePerDay = databaseCarsData.items![i].pricePerDay;
        expect(actualPricePerDay, equals(expectedPricePerDay));

        final actualSelection = carsList.elementAt(i).selected;
        final expectedSelection = i == 0; // Hyundai Sonata 2017 is selected
        expect(actualSelection, expectedSelection);

        final actualFeatures = carsList.elementAt(i).features;
        final expectedFeatures = databaseCarsData.items![i].features;

        expect(listEquals(actualFeatures, expectedFeatures), true);
      }
    },
  );

  test(
    'Stream is updated when a Car is Selected',
    () async {
      carsListBloc.injectDataProviderForTest(MockCarDataProvider());
      await carsListBloc.loadItems();

      carsListBloc.selectItem(2); // Selects Mercedes-Benz 2017

      final carsListData = await carsListBloc.outCars.take(2).toList();
      final carsList = carsListData.last.items;

      expect(carsList?.elementAt(0).selected, true);
      expect(carsList?.elementAt(1).selected, true);
      expect(carsList?.elementAt(2).selected, false);
      expect(carsList?.elementAt(3).selected, false);
      expect(carsList?.elementAt(4).selected, false);
      expect(carsList?.elementAt(5).selected, false);
    },
  );

  test(
    'Stream is updated when a Car is Deselected',
    () async {
      carsListBloc.injectDataProviderForTest(MockCarDataProvider());
      await carsListBloc.loadItems();

      carsListBloc.selectItem(2); // Selects Mercedes-Benz 2017

      var carsListData = await carsListBloc.outCars.take(2).toList();
      var carsList = carsListData.last.items;

      expect(carsList?.elementAt(0).selected, true);
      expect(carsList?.elementAt(1).selected, true);
      expect(carsList?.elementAt(2).selected, false);
      expect(carsList?.elementAt(3).selected, false);
      expect(carsList?.elementAt(4).selected, false);
      expect(carsList?.elementAt(5).selected, false);

      carsListBloc.deselectItem(2); // Deselects Mercedes-Benz 2017

      carsListData = await carsListBloc.outCars.take(2).toList();
      carsList = carsListData.last.items;

      expect(carsList?.elementAt(0).selected, true);
      expect(carsList?.elementAt(1).selected, false);
      expect(carsList?.elementAt(2).selected, false);
      expect(carsList?.elementAt(3).selected, false);
      expect(carsList?.elementAt(4).selected, false);
      expect(carsList?.elementAt(5).selected, false);
    },
  );
}
