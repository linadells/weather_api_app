import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:weather_api_app/data/datasources/weather_service.dart';
import 'package:weather_api_app/data/repositories/weather_repository.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  try {
    final apiKey = await loadConfig("apiKey");
    final apiUrl = await loadConfig("apiUrl");

    sl.registerSingleton(WeatherAPIService(apiKey: apiKey, baseUrl: apiUrl));
    sl.registerSingleton(WeatherRepositoryImpl(weatherApiService: sl()));
  } catch (e) {
    print("Error during dependency registration: $e");
  }
}

Future<String> loadConfig(String param) async {
  final configString = await rootBundle.loadString('lib/config.json');
  final config = json.decode(configString);
  return config['$param'] ?? 'https://default.url';
}
