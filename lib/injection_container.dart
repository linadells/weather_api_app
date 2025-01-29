import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:weather_api_app/data/datasources/geo_service.dart';
import 'package:weather_api_app/data/datasources/weather_service.dart';
import 'package:weather_api_app/data/repositories/geo_repository.dart';
import 'package:weather_api_app/data/repositories/weather_repository.dart';
import 'package:weather_api_app/domain/repository/geo_repository.dart';
import 'package:weather_api_app/domain/repository/weather_repository.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  try {
    final forecastApiKey = await loadConfig("forecastApiKey");
    final forecastApiUrl = await loadConfig("forecastApiUrl");
    final cityApiUrl = await loadConfig("cityApiUrl");

    sl.registerSingleton<Dio>(Dio());
    sl.registerSingleton<WeatherAPIService>(WeatherAPIService(sl()));
    sl.registerSingleton<WeatherRepository>(
        WeatherRepositoryImpl(sl(), forecastApiKey, forecastApiUrl));
    sl.registerSingleton<GeoService>(GeoService(sl()));
    sl.registerSingleton<GeoRepository>(GeoRepositoryImpl(sl(), cityApiUrl));
  } catch (e) {
    print("Error during dependency registration: $e");
  }
}

Future<String> loadConfig(String param) async {
  final configString = await rootBundle.loadString('config.json');
  final config = json.decode(configString);
  return config['$param'] ?? 'https://default.url';
}
