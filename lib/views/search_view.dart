import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_cubit.dart';
import 'package:weather_app/model/weather_model.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  //
  GlobalKey<FormState> textForm = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.amber,
        title: Text(
          "Search a City",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(
              context,
              rootNavigator: true,
            ).pushNamedAndRemoveUntil("/", (Route<dynamic> route) => false);
          },
          icon: Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Form(
            key: textForm,
            child: TextFormField(
              /*  // تستخدم لما اكون محتاج استقبل قيمه جديده كل ميوزر يبقا بيكتب 
              onChanged: (value) {
                print(value);
              }, */
              onFieldSubmitted: (value) async {
                if (textForm.currentState!.validate()) {
                  print("searching for");
                }
                // weatherModel = await WeatherServices(
                //   Dio(),
                // ).getCurrentMethod(cityName: value);
                //cubit  عشان اخليها تفعل
                var getWeatherCubit = BlocProvider.of<GetWeatherCubit>(context);
                getWeatherCubit.getWeather(cityName: value); // trigger
                // log(weatherModel!.cityName); // print in debug console cityName
                Navigator.of(context, rootNavigator: true).pop();

                // if (value == "london") {
                //   Navigator.of(context, rootNavigator: true).push(
                //     MaterialPageRoute(builder: (context) => WeatherInfo()),
                //   );
                // }
              },
              enabled: true,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.search,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "please enter a city name";
                }
                return null;
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 30,
                  horizontal: 20,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(13),
                ),
                hintText: "Enter City Name",
                labelText: "Search",
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// global variable
WeatherModel? weatherModel;
