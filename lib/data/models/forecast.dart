import 'package:weather_api_app/data/models/current_weather.dart';
import 'package:weather_api_app/data/models/day_forecast.dart';
import 'package:weather_api_app/domain/entities/day_forecast.dart';
import 'package:weather_api_app/domain/entities/forecast.dart';

class ForecastModel extends ForecastEntity {
  ForecastModel(
      {required super.cityName,
      required super.quantityOfDays,
      required super.forecast,
      required super.todayWeather});

  factory ForecastModel.fromJson(Map<String, dynamic> json) {
    var forecastList = (json['forecast']['forecastday'] as List)
        .map((day) => DayForecastModel.fromJson(day))
        .toList();
    CurrentWeatherModel todayWeather = CurrentWeatherModel.fromJson(json);
    return ForecastModel(
      cityName: json['location']['name'],
      quantityOfDays: forecastList.length,
      forecast: forecastList,
      todayWeather: todayWeather,
    );
  }
}
