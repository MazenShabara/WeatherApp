// عشان اقدر استخدمو ف الكيوبت بجميع الانواع اللي عندي
import 'package:flutter/widgets.dart';
import 'package:weather_app/model/weather_model.dart';

class WeatherState {}

// ممكن نسمي دي InitialState
class NoWeatherState extends WeatherState {}

class WeatherLoadedState extends WeatherState {
  final WeatherModel weatherModel;

  WeatherLoadedState(this.weatherModel);
}

class WeatherFailureState extends WeatherState {
  final String errorMes;

  WeatherFailureState(this.errorMes);
}
