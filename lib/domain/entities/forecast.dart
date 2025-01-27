import 'package:weather_api_app/domain/entities/current_weather.dart';
import 'package:weather_api_app/domain/entities/day_forecast.dart';

class ForecastEntity {
  int quantityOfDays;
  CurrentWeatherEntity todayWeather;
  List<DayForecastEntity> forecast;
  String cityName;
  ForecastEntity(
      {required this.cityName,
      required this.quantityOfDays,
      required this.forecast,
      required this.todayWeather});
}
