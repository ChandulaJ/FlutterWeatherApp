import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:myweatherapp/services/weather_services.dart';

import '../models/weather_model.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
//api key

  final _weatherService = WeatherService('dee2d070f3f11eaf3abf4a200586cefc');
  Weather? _weather;

  //fetch weather data
  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  //weather animations
  String getWeatherAnimations(String? mainCondition) {
    if (mainCondition == null){ return 'assets/sunny.json';}
    else {
      switch (mainCondition.toLowerCase()) {
        case "clouds":
        case "mist":
        case "smoke":
        case "haze":
        case "dust":
        case "fog":
          return 'assets/cloudy.json';

        case "rain":
        case "drizzle":
        case "shower rain":
          return "assets/sunRain.json";

        case "thunderstorm":
          return "assets/thunderstorm.json";
        case "clear":
          return "assets/sunny.json";
        case "default":
          return "assets/sunny.json";
      }
    }
    return "assets/sunny.json";
  }

  //init state

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_weather?.cityName ?? "loading city ...",style: ,),
            //animation
            Lottie.asset(getWeatherAnimations(_weather?.mainCondition)),

            Text('${_weather?.temperature.round()}°C'),

            Text(_weather?.mainCondition ?? "")
          ],
        ),
      ),
    );
  }
}
