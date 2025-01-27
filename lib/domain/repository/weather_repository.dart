import 'package:weather_api_app/domain/entities/forecast.dart';
import 'package:weather_api_app/domain/entities/location.dart';
import 'package:weather_api_app/domain/entities/day_forecast.dart';

abstract class WeatherRepository {
  Future<ForecastEntity> getForecastByCity(String city, int quantityOfDays);
  Future<ForecastEntity> getForecastByLocation(
      LocationEntity location, int quantityOfDays);
}
