import 'package:clima/screens/location.dart';
import 'package:clima/services/networking.dart';

const apiKey = 'aede869765fab32e916b3f86f78ba1be';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  //получаем погоду по запросу города
  Future getCityWeather(cityName) async {
    var url = '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric';
    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = await networkHelper.getData();
    print(weatherData);
    //print(weatherData['coord']);
    return weatherData;
  }

  //узнаем погоду по местоположению
  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    //получаем текущее местоположение
    await location.getCurrentLocation();
    //создаем объект с нужным url
    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&exclude=minutely,hourly,daily,alerts&appid=$apiKey&units=metric');
    //получаем весь ответ в json
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
