//import 'dart:js';

import 'package:flutter/material.dart';
import 'location.dart';
import 'package:clima/services/networking.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const apiKey = 'aede869765fab32e916b3f86f78ba1be';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  //запускается когда виджет создается, до build. Не работает при хотрелоад, нужен хотрестарт
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    Location location = Location();
    //получаем текущее местоположение
    await location.getCurrentLocation();

    //создаем объект с нужным url
    NetworkHelper networkHelper = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/onecall?lat=${location.latitude}&lon=${location.longitude}&exclude=minutely,hourly,daily,alerts&appid=$apiKey&units=metric');

    //получаем весь ответ в json
    var weatherData = await networkHelper.getData();

    //print(weatherData);
    //print(weatherData['current']['temp']);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        //переходим на новое окно и передаем даные о погоде
        return LocationScreen(
          locationWeather: weatherData,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        //анимация загрузки из пакета flutter_spinkit.dart
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }
}
