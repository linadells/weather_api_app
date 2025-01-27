import 'package:weather_api_app/data/datasources/weather_service.dart';
import 'package:weather_api_app/domain/entities/forecast.dart';
import 'package:weather_api_app/domain/entities/location.dart';
import 'package:weather_api_app/domain/repository/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherAPIService weatherApiService;

  WeatherRepositoryImpl({required this.weatherApiService});

  Future<ForecastEntity> getForecastByLocation(
      LocationEntity location, int days) async {
    try {
      return await weatherApiService.getWeatherForecastByLocation(
          location, days);
    } catch (e) {
      // TODO:обробити
      rethrow;
    }
  }

  Future<ForecastEntity> getForecastByCity(String city, int days) async {
    try {
      return await weatherApiService.getWeatherForecastByCity(city, days);
    } catch (e) {
      // TODO:обробити
      rethrow;
    }
  }
}
