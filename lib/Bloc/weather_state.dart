import 'package:test_1/Bloc model/bloc_weathermodel.dart';

sealed class WeatherState {
  const WeatherState();
}
final class WeatherInitial extends WeatherState {
  const WeatherInitial({required bool isSearchVisible});
}
final class WeatherLoadInProgress extends WeatherState {
  const WeatherLoadInProgress();
}
final class WeatherLoadSuccess extends WeatherState {
  const WeatherLoadSuccess({required this.weather});
  final Weatherblocmodel weather;
}
final class WeatherLoadFailure extends WeatherState {
  const WeatherLoadFailure({required this.exception});
  final Exception exception;
}