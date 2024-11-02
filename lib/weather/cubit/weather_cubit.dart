import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_1/weather/api/weather_api.dart';

import '../model/weather_model.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherApi weatherApi;
  WeatherCubit(this.weatherApi) : super(WeatherInitial());

  void getWeatherData(String city) async {
    emit(WeatherLoading());
    try {
      WeatherModel weatherModel = await weatherApi.getCurrentWeather(city);

      emit(WeatherLoaded(weatherModel));
    } catch (e) {
      emit(WeatherError(e.toString()));
    }
  }
}


/*

      UI  => setState() => build() => UI update


      UI (inital state)  => Cubit => Builder(UI) => New State => UI (new state)


*/

