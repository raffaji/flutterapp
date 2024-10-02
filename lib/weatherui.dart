import 'package:flutter/material.dart';
import 'package:test_1/api.dart';
import 'package:test_1/weathermodel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiResponse? response;
  bool isLoading = false;
  String message = "Search for a location to get weather data";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            _buildSearchBar(),
            const SizedBox(height: 20),
            isLoading
                ? const CircularProgressIndicator()
                : Expanded(
                    child: SingleChildScrollView(child: _buildWeatherContent())),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
   return SearchBar(
           hintText: "Search any location",
            onSubmitted: _getWeatherData,
          leading: IconButton(
            icon: Icon(Icons.adaptive.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          elevation: WidgetStatePropertyAll(0),
        );    
  }

  Widget _buildWeatherContent() {
    if (response == null) {
      return Text(message);
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLocationInfo(),
          const SizedBox(height: 10),
          _buildTemperatureInfo(),
          const SizedBox(height: 10),
          _buildWeatherIcon(),
          const SizedBox(height: 10),
          _buildAdditionalWeatherData(),
        ],
      );
    }
  }

  Widget _buildLocationInfo() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Icon(Icons.location_on, size: 50),
        Text(
          "${response?.location?.name ?? ""}, ${response?.location?.country ?? ""}",
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
        ),
      ],
    );
  }

  Widget _buildTemperatureInfo() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "${response?.current?.tempC ?? ""} °C",
            style: const TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
          ),
        ),
        Text(
          response?.current?.condition?.text ?? "",
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildWeatherIcon() {
    return Center(
      child: SizedBox(
        height: 200,
        child: Image.network(
          "https:${response?.current?.condition?.icon}"
              .replaceAll("64x64", "128x128"),
          scale: 0.7,
        ),
      ),
    );
  }

  Widget _buildAdditionalWeatherData() {
    return Card(
      elevation: 4,
      color: Colors.white,
      child: Column(
        children: [
          _buildDataRow([
            _buildDataTile("Humidity", "${response?.current?.humidity ?? ""}%"),
            _buildDataTile("Wind Speed", "${response?.current?.windKph ?? ""} km/h"),
          ]),
          _buildDataRow([
            _buildDataTile("UV", "${response?.current?.uv ?? ""}"),
            _buildDataTile("Precipitation", "${response?.current?.precipMm ?? ""} mm"),
          ]),
          _buildDataRow([
            _buildDataTile("Local Time", response?.location?.localtime?.split(" ").last ?? ""),
            _buildDataTile("Local Date", response?.location?.localtime?.split(" ").first ?? ""),
          ]),
        ],
      ),
    );
  }

  Widget _buildDataRow(List<Widget> children) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: children,
    );
  }

  Widget _buildDataTile(String title, String data) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          Text(
            data,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Future<void> _getWeatherData(String location) async {
    setState(() => isLoading = true);
    try {
      response = await WeatherApi().getCurrentWeather(location);
      message = "Weather data for $location";
    } catch (e) {
      message = "Failed to get weather data";
      response = null;
    } finally {
      setState(() => isLoading = false);
    }
  }
}
