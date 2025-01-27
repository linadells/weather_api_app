import 'package:weather_api_app/domain/entities/day_forecast.dart';

class DayForecastModel extends DayForecastEntity {
  DayForecastModel(
      {required super.date,
      required super.temp,
      required super.humidity,
      required super.icon});

  factory DayForecastModel.fromJson(Map<String, dynamic> json) {
    var condition = json['day']['condition'];
    return DayForecastModel(
      date: DateTime.parse(json['date']),
      temp: json['day']['avgtemp_c'].toDouble(),
      humidity: json['day']['avghumidity'].toDouble(),
      icon: condition['icon'],
    );
  }
}
