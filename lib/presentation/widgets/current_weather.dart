import 'package:flutter/material.dart';
import 'package:weather_api_app/core/styles.dart';
import 'package:weather_api_app/domain/entities/forecast.dart';

class CurrentWeather extends StatelessWidget {
  const CurrentWeather({
    super.key,
    required this.forecast,
  });

  final ForecastEntity forecast;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(forecast.cityName, style: kBigText),
          SizedBox(
            height: 5,
          ),
          Image.network(
            forecast.todayWeather.icon.startsWith('http')
                ? forecast.todayWeather.icon
                : 'https:${forecast.todayWeather.icon}',
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
          SizedBox(
            height: 5,
          ),
          Text('${forecast.todayWeather.currentTemp.toStringAsFixed(1)}°',
              style: kBigText),
          Text(
            '${forecast.todayWeather.minTemp}° - ${forecast.todayWeather.maxTemp}° | ${forecast.todayWeather.humidity}%',
            style: kMediumText,
          ),
        ],
      ),
    );
  }
}
