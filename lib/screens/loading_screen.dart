import 'package:flutter/material.dart';
import 'location.dart';

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

  @override
  Widget build(BuildContext context) {
//'myMarginAsDouble ?? 30' - if it's not null then use it, otherwise use 30
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(30),
        color: Colors.red,
      ),
    );
  }
}
