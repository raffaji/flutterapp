import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_1/weather/api/weather_api.dart';
import 'package:test_1/weather/cubit/weather_cubit.dart';

class WeatherUI extends StatefulWidget {
  const WeatherUI({super.key});

  @override
  State<WeatherUI> createState() => _WeatherUIState();
}

class _WeatherUIState extends State<WeatherUI> {
  late WeatherCubit weatherCubit;

  @override
  void initState() {
    weatherCubit = WeatherCubit(WeatherApi());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: SearchBar(
          leading: IconButton(
            icon: Icon(Icons.adaptive.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          hintText: "Search City",
          elevation: WidgetStateProperty.all(0),
          onSubmitted: (value) {
            if (value.isNotEmpty) {
              weatherCubit.getWeatherData(value);
            }
          },
        ),
      ),
      body: BlocProvider.value(
        value: weatherCubit,
        child: BlocBuilder<WeatherCubit, WeatherState>(
            bloc: weatherCubit,
            builder: (context, state) {
              ///For inital state
              if (state is WeatherInitial) {
                return Center(
                  child: Text("Search for the location to get weather data"),
                );
              }

              ///For loading state
              if (state is WeatherLoading) {
                return Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }

              if (state is WeatherError) {
                return Center(
                  child: SingleChildScrollView(
                    child: Text(
                      state.message,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.error,
                          ),
                    ),
                  ),
                );
              }

              if (state is WeatherLoaded) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 50,
                        ),
                        Text(
                          (state).weatherModel.location?.name.toString() ?? '',
                          style: const TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        Text(
                          (state).weatherModel.location?.country.toString() ??
                              '',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "${(state).weatherModel.current?.tempC.toString() ?? ""} °c",
                            style: const TextStyle(
                              fontSize: 60,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          ((state)
                                  .weatherModel
                                  .current
                                  ?.condition
                                  ?.text
                                  .toString() ??
                              ""),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: SizedBox(
                        height: 200,
                        child: Image.network(
                          "https:${(state).weatherModel.current?.condition?.icon}"
                              .replaceAll("64x64", "128x128"),
                          scale: 0.7,
                        ),
                      ),
                    ),
                    Card(
                      elevation: 4,
                      color: Theme.of(context).colorScheme.surfaceContainerHigh,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              DateTileWidget(
                                  title: "Humidity",
                                  data: (state)
                                          .weatherModel
                                          .current
                                          ?.humidity
                                          ?.toString() ??
                                      ""),
                              DateTileWidget(
                                title: "Wind Speed",
                                data:
                                    "${(state).weatherModel.current?.windKph?.toString()} km/h",
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              DateTileWidget(
                                  title: "UV",
                                  data: (state)
                                          .weatherModel
                                          .current
                                          ?.uv
                                          ?.toString() ??
                                      ""),
                              DateTileWidget(
                                title: "Percipitation",
                                data:
                                    "${(state).weatherModel.current?.precipMm?.toString()} mm",
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              DateTileWidget(
                                  title: "Local Time",
                                  data: (state)
                                          .weatherModel
                                          .location
                                          ?.localtime
                                          ?.split(" ")
                                          .last ??
                                      ""),
                              DateTileWidget(
                                  title: "Local Date",
                                  data: (state)
                                          .weatherModel
                                          .location
                                          ?.localtime
                                          ?.split(" ")
                                          .first ??
                                      ""),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                );
              }

              return Center(child: Text('Something went wrong'));
            }),
      ),
    );
  }
}

class DateTileWidget extends StatelessWidget {
  const DateTileWidget({
    super.key,
    required this.data,
    required this.title,
  });

  final String data;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          FittedBox(
            child: Text(
              data,
              style: const TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
