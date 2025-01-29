import 'package:weather_api_app/domain/entities/current_weather.dart';

class CurrentWeatherModel extends CurrentWeatherEntity {
  CurrentWeatherModel(
      {required super.currentTemp,
      required super.humidity,
      required super.icon,
      required super.maxTemp,
      required super.minTemp,
      required super.isDay});

  factory CurrentWeatherModel.fromJson(Map<String, dynamic> json) {
    var todayForecast = json['forecast']['forecastday'].firstWhere((day) {
      var forecastDate = DateTime.parse(day['date']);
      var today = DateTime.now();
      return forecastDate.year == today.year &&
          forecastDate.month == today.month &&
          forecastDate.day == today.day;
    });

    var dayCondition = todayForecast['day']['condition'];
    double minTemp = todayForecast['day']['mintemp_c'].toDouble();
    double maxTemp = todayForecast['day']['maxtemp_c'].toDouble();
    double currentTemp = (minTemp + maxTemp) / 2;

    return CurrentWeatherModel(
      isDay: json['current']['is_day'] == 1,
      currentTemp: currentTemp,
      humidity: json['current']['humidity'].toDouble(),
      icon: dayCondition['icon'],
      maxTemp: maxTemp,
      minTemp: minTemp,
    );
  }
}
