import 'package:geolocator/geolocator.dart';

class Location {
  double latitude;
  double longitude;

//получаем текущее местоположение с помощью пакета geolocator.dart
  Future getCurrentLocation() async {
    try {
      //по примеру из документации пакета geolocator
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
      //print(position);
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      print(e);
    }
  }
}
