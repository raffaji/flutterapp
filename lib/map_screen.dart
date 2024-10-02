import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';  // Correct package import
import 'package:latlong2/latlong.dart';        // Correct coordinates import
import 'constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // This method will be called when a marker is tapped
  Future<void> fetchWeather(LatLng location) async {
    final response = await http.get(
      Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$apikey&units=metric',
      ),
    );

    if (response.statusCode == 200) {
      // Parse the weather data
      final weatherData = response.body; // You might want to decode this
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Weather Info'),
            content: Text(weatherData), // Display raw data for now
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Close'),
              ),
            ],
          );
        },
      );
    } else {
      // Handle the error
      print('Failed to load weather data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Map'),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(51.5, -0.09), // Default map center
          zoom: 10.0,                  // Initial zoom level
          onTap: (tapPosition, point) {
            // Call fetchWeather when tapping on the map
            fetchWeather(point);
          },
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'], // For different tile servers
          ),
        ],
      ),
    );
  }
}