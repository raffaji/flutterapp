import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_1/Blocapi/bloc_api.dart';
import 'package:test_1/Bloc%20model/bloc_weathermodel.dart';
import 'package:test_1/Bloc/weather_bloc.dart';
import 'package:test_1/Bloc/weather_event.dart';
import 'package:test_1/Bloc/weather_state.dart';

class BlocTile extends StatelessWidget {
  const BlocTile({super.key});

  @override
  Widget build(BuildContext context) {
    final WeatherApi weatherApi = WeatherApi(); // Initialize your API
    return BlocProvider(
      create: (context) => WeatherBloc(weatherApi),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Weather App'),
        ),
        body: Column(
          children: [
            _SearchBar(),
            Expanded(
              child: BlocBuilder<WeatherBloc, WeatherState>(
                builder: (context, state) {
                  if (state is WeatherInitial) {
                    return const Center(child: Text('Enter a city to get weather'));
                  } else if (state is WeatherLoadInProgress) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is WeatherLoadSuccess) {
                    return _WeatherInfo(weatherModel: state.weather);
                  } else if (state is WeatherLoadFailure) {
                    return Center(child: Text(state.exception as String));
                  } else {
                    return const Center(child: Text('Unexpected State'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchBar extends StatefulWidget {
  @override
  __SearchBarState createState() => __SearchBarState();
}

class __SearchBarState extends State<_SearchBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'City Name',
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              final cityName = _controller.text;
              if (cityName.isNotEmpty) {
                context.read<WeatherBloc>().add(WeatherRequested(city:cityName));
              }
            },
          ),
        ],
      ),
    );
  }
}

class _WeatherInfo extends StatelessWidget {
  final Weatherblocmodel weatherModel;

  const _WeatherInfo({required this.weatherModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          weatherModel.location?.name ?? '',
          style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        Text(
          "${weatherModel.current?.tempC} °C",
          style: const TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
        ),
        Text(
          weatherModel.current?.condition?.text ?? '',
          style: const TextStyle(fontSize: 20),
        ),
        // Add more weather info as needed
      ],
    );
  }
}
