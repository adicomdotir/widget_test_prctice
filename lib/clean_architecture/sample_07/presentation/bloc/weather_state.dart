import 'package:equatable/equatable.dart';
import 'package:widget_test_practice/clean_architecture/sample_07/domain/entities/weather_entitiy.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object?> get props => [];
}

class WeatherEmpty extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final WeatherEntity result;

  const WeatherLoaded(this.result);

  @override
  List<Object?> get props => [result];
}

class WeatherLoadFail extends WeatherState {
  final String message;

  const WeatherLoadFail(this.message);

  @override
  List<Object?> get props => [message];
}
