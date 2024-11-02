import 'package:bloc/bloc.dart';
import 'weather_event.dart';
import 'weather_state.dart';
import 'package:test_1/Blocapi/bloc_api.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherApi weatherApi; // Declare WeatherApi

  WeatherBloc(this.weatherApi) : super(const WeatherInitial(isSearchVisible: false));

  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is WeatherRequested) {
      yield const WeatherLoadInProgress(); // Emit loading state

      try {
        // Call your WeatherApi to fetch the weather data
        final weather = await weatherApi.getCurrentWeather(event.city); // API call
        yield WeatherLoadSuccess(weather: weather); // Emit success state with weather data
      } catch (e) {
        yield WeatherLoadFailure(exception: e is Exception ? e : Exception(e.toString())); // Handle errors
      }
    } else if (event is WeatherRefreshed) {
      yield const WeatherLoadInProgress(); // Emit loading state

      // Assuming you have a mechanism to retrieve the last requested city
      String lastRequestedCity = 'Your last city logic here'; // Logic to remember last city
      try {
        final weather = await weatherApi.getCurrentWeather(lastRequestedCity); // API call
        yield WeatherLoadSuccess(weather: weather); // Emit success state with weather data
      } catch (e) {
        yield WeatherLoadFailure(exception: e is Exception ? e : Exception(e.toString())); // Handle errors
      }
    }
  }
}
