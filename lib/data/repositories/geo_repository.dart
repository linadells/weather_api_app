import 'dart:convert';

import 'package:weather_api_app/data/datasources/weather_service.dart';
import 'package:weather_api_app/domain/repository/geo_repository.dart';

class GeoRepositoryImpl implements GeoRepository {
  final WeatherAPIService _weatherApiService;
  final String _baseUrl;

  GeoRepositoryImpl(this._weatherApiService, this._baseUrl);

  @override
  Future<List<String>> getCities(String cityPrefix, int namesLimit) async {
    final res = await _weatherApiService.getData(
        baseUrl: _baseUrl,
        queryParams: {
          'city': cityPrefix,
          'format': 'json',
          'limit': namesLimit
        });
    if (res.data is List) {
      return (res.data as List<dynamic>)
          .map((city) => city['display_name'].toString())
          .toList();
    } else {
      throw Exception("Unexpected response format: ${res.data}");
    }
  }
}
