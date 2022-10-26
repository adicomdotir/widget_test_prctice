import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:widget_test_practice/dependency_injector.dart';
import 'package:widget_test_practice/models/car.dart';

abstract class CarsDataProvider {
  Future<CarsList> loadCars();
}

class CarsListBloc {
  CarsDataProvider provider = locator<CarsDataProvider>();
  final BehaviorSubject<CarsList> _itemsController =
      BehaviorSubject<CarsList>();

  Stream<CarsList> get outCars => _itemsController.stream;

  Future loadItems() async {
    final items = await provider.loadCars();
    if (items.items != null) {
      items.items?.sort(alphabetizeItemsByTitleIgnoreCases);
    }
    _itemsController.sink.add(items);
  }

  void injectDataProviderForTest(CarsDataProvider carsDataProvider) {
    provider = carsDataProvider;
  }

  int alphabetizeItemsByTitleIgnoreCases(Car a, Car b) {
    return a.title.toLowerCase().compareTo(b.title.toLowerCase());
  }

  void selectItem(int id) {
    late StreamSubscription subscription;
    subscription = outCars.listen(
      (carList) async {
        final newList = <Car>[];
        for (final car in carList.items!) {
          if (car.id == id) {
            newList.add(Car(
              id: car.id,
              title: car.title,
              description: car.description,
              url: car.url,
              pricePerDay: car.pricePerDay,
              selected: true,
              features: car.features,
            ));
          } else {
            newList.add(car);
          }
        }
        _itemsController.sink.add(
          CarsList(
            newList,
            null,
          ),
        );
        subscription.cancel();
      },
    );
  }

  void deselectItem(int id) {
    late StreamSubscription subscription;
    subscription = outCars.listen(
      (carList) async {
        final newList = <Car>[];
        for (final car in carList.items!) {
          if (car.id == id) {
            newList.add(Car(
              id: car.id,
              title: car.title,
              description: car.description,
              url: car.url,
              pricePerDay: car.pricePerDay,
              selected: false,
              features: car.features,
            ));
          } else {
            newList.add(car);
          }
        }
        _itemsController.sink.add(
          CarsList(
            newList,
            null,
          ),
        );
        subscription.cancel();
      },
    );
  }

  void dispose() {
    _itemsController.close();
  }
}
