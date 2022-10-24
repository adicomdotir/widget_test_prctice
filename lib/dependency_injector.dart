import 'database/cars_database.dart';
import 'details/car_details_bloc.dart';
import 'list/cars_list_bloc.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerFactory<CarsDataProvider>(() => CarsDatabase());
  locator.registerSingleton(CarsListBloc());
  locator.registerSingleton(CarDetailsBloc());
}
