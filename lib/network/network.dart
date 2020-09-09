import 'dart:convert';

import 'package:current_weather_app/model/current_weather_model.dart';
import 'package:current_weather_app/util/current_weather_util.dart';
import 'package:http/http.dart' as http;

class Network {
  Future<CurrentWeatherModel> getCurrentWeather({String cityName}) async {
    var finalUrl = "http://api.openweathermap.org/data/2.5/weather?q=" +
        cityName +
        "&appid=" +
        Util.appId +
        "&units=metric";

    final response = await http.get(
      Uri.encodeFull(finalUrl),
    );

    // print("URL: ${Uri.encodeFull(finalUrl)}");

    if (response.statusCode == 200) {
      // Here I convert the json response to actual DART(PODO) Object

      // print("Weather Data: ${response.body}");

      return CurrentWeatherModel.fromJson(
        json.decode(response.body),
      );
    } else {
      throw new Exception("Error getting weather information!");
    }
  }
}
