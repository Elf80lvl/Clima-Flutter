import 'package:flutter/material.dart';
import 'location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; //jsonDecode comes from here

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
//запускается когда виджет создается, до build
  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    print(location.latitude);
  }

  void getData() async {
    http.Response response = await http.get(
        'https://api.openweathermap.org/data/2.5/weather?q=London&appid=aede869765fab32e916b3f86f78ba1be');
    if (response.statusCode == 200) {
      //String data = response.body;
      var decodedData = jsonDecode(response.body);
      double temperature = decodedData['main']['temp'];
      int condition = decodedData['weather'][0]['id'];
      String cityName = decodedData['name'];

      print(cityName);
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
//'myMarginAsDouble ?? 30' - if it's not null then use it, otherwise use 30
    getData();
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(30),
        color: Colors.red,
      ),
    );
  }
}

//aede869765fab32e916b3f86f78ba1be
