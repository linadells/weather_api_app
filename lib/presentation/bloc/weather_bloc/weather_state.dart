part of 'weather_bloc.dart';

sealed class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

final class WeatherLoadingState extends WeatherState {}

final class WeatherLoadedState extends WeatherState {
  ForecastEntity forecastEntity;
  WeatherLoadedState(this.forecastEntity);
  @override
  List<Object> get props => [forecastEntity];
}

final class WeatherErrorState extends WeatherState {
  final String error;
  const WeatherErrorState(this.error);
}
