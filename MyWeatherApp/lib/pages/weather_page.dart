import 'package:flutter/material.dart';
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
  _fetchWeather() async{
    String cityName = await _weatherService.getCurrentCity();

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }catch(e){
      print(e);


    }
  }

  //weather animations


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
            Text(_weather?.cityName ?? "loading city ..."),
            Text('${_weather?.temperature.round()}°C'),

          ],
        ),
      ),
    );
  }
}
