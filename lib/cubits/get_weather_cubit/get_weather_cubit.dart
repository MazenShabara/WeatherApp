import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_state.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/services/weather_services.dart';

// كلاس جاهز عشان اورث منو الخصائص بتاعتو
class GetWeatherCubit extends Cubit<WeatherState> {
  GetWeatherCubit() : super(NoWeatherState()); // initialState

  WeatherModel? weatherModel;
  getWeather({required String cityName}) async {
    try {
      weatherModel = (await WeatherServices(
        Dio(),
      ).getCurrentMethod(cityName: cityName))!;
      emit(WeatherLoadedState(weatherModel!)); // ينقلني بقا علي حاله الطقس
    } on Exception catch (e) {
      emit(
        WeatherFailureState(e.toString()),
      ); // عشان ابعت ان البلد دي فيها مشكله
    }
  }
}
