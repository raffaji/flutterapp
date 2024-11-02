import 'dart:convert';

import 'package:test_1/constants.dart';
import 'package:test_1/weather/model/weather_model.dart';

import 'package:http/http.dart' as http;

class WeatherApi {
  final String baseUrl = "http://api.weatherapi.com/v1/current.json";

  Future<WeatherModel> getCurrentWeather(String location) async {
    String apiUrl = "$baseUrl?key=$apikey&q=$location";
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        return WeatherModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception("Failed to load weather ${response.statusCode} ${response.body}");
      }
    } catch (e,stackTrace) {
      throw Exception("Failed to load weather $e $stackTrace");
    }
  }
}
