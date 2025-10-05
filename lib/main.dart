import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_cubit.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_state.dart';
import 'package:weather_app/views/home_view.dart';
import 'package:weather_app/views/search_view.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetWeatherCubit(),
      child: const CustomMaterialApp(),
    );
  }
}

class CustomMaterialApp extends StatelessWidget {
  const CustomMaterialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetWeatherCubit, WeatherState>(
      builder: (context, state) {
        final cubit = BlocProvider.of<GetWeatherCubit>(context);
        final weatherCondition = cubit.weatherModel?.weatherCon;

        final isInitial = weatherCondition == null;

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: isInitial
                ? Colors.grey
                : getThemeColor(weatherCondition),
            scaffoldBackgroundColor: isInitial
                ? Colors.white
                : getThemeColor(weatherCondition)[100],
            appBarTheme: AppBarTheme(
              backgroundColor: isInitial
                  ? Colors.white
                  : getThemeColor(weatherCondition),
              foregroundColor: isInitial ? Colors.black : Colors.white,
              elevation: 0,
            ),
          ),
          initialRoute: "/",
          routes: {
            "/": (context) => const HomeScreen(),
            "search": (context) => SearchScreen(),
          },
        );
      },
    );
  }
}

//  ألوان حسب الحالة الجوية
MaterialColor getThemeColor(String? condition) {
  if (condition == null) return Colors.grey;

  switch (condition) {
    case 'Sunny':
    case 'Clear':
      return Colors.orange;

    case 'Partly cloudy':
      return Colors.amber;

    case 'Cloudy':
    case 'Overcast':
      return Colors.grey;

    case 'Mist':
    case 'Fog':
      return Colors.blueGrey;

    case 'Rain':
    case 'Drizzle':
      return Colors.indigo;

    case 'Freezing':
    case 'Sleet':
      return Colors.lightBlue;

    case 'Snow':
    case 'Blizzard':
      return Colors.blue;

    case 'Thunder':
    case 'Storm':
      return Colors.deepPurple;

    case 'Ice':
      return Colors.cyan;

    default:
      return Colors.blueGrey;
  }
}
