import 'package:clima/screens/city_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});
  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  dynamic temperature;
  String weatherIcon; //будущая иконка погоды
  String cityName;
  String weatherMessage;

  @override
  void initState() {
    super.initState();

    //чтобы иметь возможность передать данные сюда надо испотзовать "widget.locationWeather" вместо "locationWeather"
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      //если по какой-то причине не получили инфу о погоде
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'Error';
        weatherMessage = 'Unable to get weather data';
        cityName = '';
        //заканчиваем работу функции; если погоды нет, то след. строки не нужны, иначе краш
        return;
      }

      dynamic temp = weatherData['main']['temp'];
      //чтобы показывать температуру целым числом
      temperature = temp.toInt();
      temperature = temp.round();
      //получаем код погоды
      var condition = weatherData['weather'][0]['id'];
      //передаем код погоды и получаем иконку в String
      weatherIcon = weather.getWeatherIcon(condition);
      cityName = weatherData['name'];
      //print(weatherData);

      print(weatherData);

      weatherMessage = weather.getMessage(temperature);
      //print(temp);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    padding: EdgeInsets.only(top: 20),
                    onPressed: () async {
                      var weatherData = await weather.getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 30.0,
                      color: Colors.grey,
                    ),
                  ),
                  //кнопка города
                  FlatButton(
                    onPressed: () async {
                      //принимаем переменную - название города с предыдущего окна
                      var typedName = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return CityScreen();
                        }),
                      );
                      //print(typedName);
                      if (typedName != null) {
                        var weatherData =
                            await weather.getCityWeather(typedName);
                        updateUI(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 30.0,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0, bottom: 50),
                child: Text(
                  "$weatherMessage in $cityName!",
                  textAlign: TextAlign.center,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
