// ignore_for_file: camel_case_types
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wheather/home/model/homemodel.dart';

class Api_http {

  Future<HomeModel?> weatherData(String city) async {
  String link =
      "https://api.openweathermap.org/data/2.5/weather?q=$city,IN&appid=";
    var response = await http.get(Uri.parse(link));
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      HomeModel h1 = HomeModel.fromJson(json);
      return h1;
    }
    return null;
  }
}
