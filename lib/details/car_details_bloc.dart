import 'dart:async';
import '../dependency_injector.dart';
import 'package:rxdart/rxdart.dart';
import '../models/car.dart';
import '../list/cars_list_bloc.dart';

class CarDetailsBloc {
  var carsListBloc = locator<CarsListBloc>();

  final BehaviorSubject<Car?> _itemController = BehaviorSubject<Car>();
  Stream<Car?> get outItem => _itemController.stream;
  StreamSubscription? _subscription;
  int? _currentId;

  void getItem(int id) async {
    print('getItem');
    _itemController.sink.add(null);

    _currentId = id;
    if (_subscription != null) {
      _subscription?.cancel();
    }

    _subscription = carsListBloc.outCars.listen(
      (listOfItems) async {
        print(listOfItems);
        for (final item in listOfItems.items!) {
          if (item.id == _currentId) {
            _itemController.sink.add(item);
            break;
          }
        }
      },
    );
  }

  void dispose() {
    if (_subscription != null) {
      _subscription?.cancel();
    }
    _itemController.close();
  }
}
