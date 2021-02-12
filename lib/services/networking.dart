import 'package:http/http.dart' as http;
import 'dart:convert'; //jsonDecode comes from here

class NetworkHelper {
  NetworkHelper(this.url);

  final String url;

//делаем запрос и получаем ответ
  Future getData() async {
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      //сам ответ
      String data = response.body;
      //чтобы прочитать json
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}
