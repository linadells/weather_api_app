import 'dart:convert';

import 'package:weather_api_app/data/models/forecast.dart';
import 'package:http/http.dart' as http;
import 'package:weather_api_app/domain/entities/location.dart';

class WeatherAPIService {
  final String baseUrl;
  final String apiKey;

  WeatherAPIService({required this.apiKey, required this.baseUrl});

  Future<ForecastModel> getWeatherForecastByCity(String city, int days) async {
    final response = await http.get(
        Uri.parse('$baseUrl?key=$apiKey&q=$city&days=$days&aqi=no&alerts=no'));

    if (response.statusCode == 200) {
      return ForecastModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Couldn`t load forecast');
    }
  }

  Future<ForecastModel> getWeatherForecastByLocation(
      LocationEntity location, int days) async {
    final response = await http.get(Uri.parse(
        '$baseUrl?key=$apiKey&q=${location.lon}, ${location.lat}&days=$days&aqi=no&alerts=no'));

    if (response.statusCode == 200) {
      return ForecastModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Couldn`t load forecast');
    }
  }
}
