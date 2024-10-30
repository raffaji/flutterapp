

sealed class WeatherEvent {
  const WeatherEvent();
}

// Event to request loading weather data for a given city
final class WeatherRequested extends WeatherEvent {
  const WeatherRequested({required this.city});
  final String city;
}

// Event to request reloading or refreshing the weather data
final class WeatherRefreshed extends WeatherEvent {
  const WeatherRefreshed();
}
