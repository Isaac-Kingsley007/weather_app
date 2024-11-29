// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather.dart';

//"https://api.openweathermap.org/data/2.5/weather?lat=12.9791549&lon=80.1991722&units=metric&appid=aa9f6951dfb53dd827bc55796360bc95",

class WeatherService {
  final BASEURL = "https://api.openweathermap.org/data/2.5/weather";
  final APIKEY = "aa9f6951dfb53dd827bc55796360bc95";

  Future<Weather> getWeather(double lat, double lon) async {
    final uri = '$BASEURL?lat=$lat&lon=$lon&units=metric&appid=$APIKEY';
    final url = Uri.parse(uri);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw "UnSucessfull Call";
    }
  }

  Future<Position> getLocation() async {
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Future.error("Permission Denied");
      }
    }

    return await Geolocator.getCurrentPosition();
  }
}
