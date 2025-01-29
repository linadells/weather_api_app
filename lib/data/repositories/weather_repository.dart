import 'package:weather_api_app/data/datasources/weather_service.dart';
import 'package:weather_api_app/data/models/forecast.dart';
import 'package:weather_api_app/domain/entities/forecast.dart';
import 'package:weather_api_app/domain/entities/location.dart';
import 'package:weather_api_app/domain/repository/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherAPIService _weatherApiService;
  final String _baseUrl;
  final String _apiKey;

  WeatherRepositoryImpl(this._weatherApiService, this._apiKey, this._baseUrl);

  @override
  Future<ForecastEntity> getForecastByLocation(
      LocationEntity location, int days) async {
    try {
      final res = await _weatherApiService.getData(
          baseUrl: _baseUrl,
          queryParams: {
            'key': _apiKey,
            'q': '${location.lat}, ${location.lon}',
            'days': days
          });
      return ForecastModel.fromJson(res.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ForecastEntity> getForecastByCity(String city, int days) async {
    try {
      final res = await _weatherApiService.getData(
          baseUrl: _baseUrl,
          queryParams: {'key': _apiKey, 'q': city, 'days': days});
      return ForecastModel.fromJson(res.data);
    } catch (e) {
      rethrow;
    }
  }
}
