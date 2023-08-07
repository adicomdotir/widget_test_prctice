import 'package:bloc/bloc.dart';
import 'package:widget_test_practice/clean_architecture/sample_07/domain/usecases/get_current_weather.dart';
import 'package:rxdart/rxdart.dart';

import 'weather_event.dart';
import 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetCurrentWeatherUseCase _getCurrentWeatherUseCase;

  WeatherBloc(this._getCurrentWeatherUseCase) : super(WeatherEmpty()) {
    on<OnCityChanged>(
      (event, emit) async {
        emit(WeatherLoading());
        final result = await _getCurrentWeatherUseCase.execute(event.cityName);
        result.fold(
          (failure) {
            emit(WeatherLoadFail(failure.message));
          },
          (data) {
            emit(WeatherLoaded(data));
          },
        );
      },
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
