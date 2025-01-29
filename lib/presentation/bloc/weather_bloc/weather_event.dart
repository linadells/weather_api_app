part of 'weather_bloc.dart';

sealed class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

final class GetWeatherOfCurrentLocationEvent extends WeatherEvent {
  const GetWeatherOfCurrentLocationEvent();
}

final class GetWeatherOfCityEvent extends WeatherEvent {
  final String city;
  const GetWeatherOfCityEvent(this.city);

  @override
  List<Object> get props => [city];
}
