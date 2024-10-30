import 'dart:convert';
import 'package:test_1/constants.dart';
import 'package:test_1/Bloc model/bloc_weathermodel.dart';
import 'package:http/http.dart' as http;

   
    
class WeatherApi {
  final String baseUrl = "http://api.weatherapi.com/v1/current.json";

  Future<Weatherblocmodel> getCurrentWeather(String location) async {
    String apiUrl = "$baseUrl?key=$apikey&q=$location";
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        // Use WeatherBlocModel's fromJson to parse the response
        return Weatherblocmodel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception("Failed to load weather");
      }
    } catch (e) {
      throw Exception("Failed to load weather: $e");
    }
  }
}

