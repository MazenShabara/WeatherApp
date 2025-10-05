import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:weather_app/model/weather_model.dart';

class WeatherServices {
  final Dio dio = Dio();

  final String baseUrl = "https://api.weatherapi.com/v1";
  final String apiKey = "3cefdb0a66844d2380b142841250110";

  WeatherServices(Dio dio);

  Future<WeatherModel?> getCurrentMethod({required String cityName}) async {
    try {
      Response response = await dio.get(
        "${baseUrl}/forecast.json?key=${apiKey}&q=${cityName}&days=1",
      );
      // This represents the data that will be returned to me.

      WeatherModel weatherModel = WeatherModel.fromJson(response.data);

      return weatherModel;
    } on DioException catch (e) {
      // TODO
      final String errorMessage =
          e.response?.data["error"]["message"] ??
          "oops there was an error ! try later";
      throw Exception(errorMessage);
    } catch (e) {
      log(e.toString()); // to print error in console // can remove this line
      throw Exception("oops there was an error ! try later");
    }
  }
}
