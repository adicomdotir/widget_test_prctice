import 'package:get_it/get_it.dart';
import 'package:widget_test_practice/database/cars_database.dart';
import 'package:widget_test_practice/list/cars_list_bloc.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerFactory<CarsDataProvider>(() => CarsDatabase());
  locator.registerSingleton(CarsListBloc());
}
