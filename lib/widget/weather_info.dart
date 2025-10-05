import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_cubit.dart';
import 'package:weather_app/model/weather_model.dart';

class WeatherInfo extends StatelessWidget {
  const WeatherInfo({super.key, required this.weatherModel});
  final WeatherModel weatherModel;
  @override
  Widget build(BuildContext context) {
    WeatherModel weatherModel = BlocProvider.of<GetWeatherCubit>(
      context,
    ).weatherModel!;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Text(
            weatherModel.cityName,
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          Text(
            "updated at ${weatherModel.date.hour}:${weatherModel.date.minute} ", // date
            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 25),
          ),
          SizedBox(height: 32),
          // row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network("https:${weatherModel.imgUrl!}"),
              SizedBox(width: 32),
              Text(
                weatherModel.temp.toString(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
              ),
              SizedBox(width: 32),
              Column(
                children: [
                  Text("maxTemp: ${weatherModel.maxTemp.round()}"),
                  Text("minTemp:${weatherModel.minTemp.round()}"),
                ],
              ),
            ],
          ),
          SizedBox(height: 32),
          Text(
            weatherModel.weatherCon,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
          ),
        ],
      ),
    );
  }
}
