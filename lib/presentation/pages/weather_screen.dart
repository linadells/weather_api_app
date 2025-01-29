import 'package:flutter/material.dart';
import 'package:weather_api_app/core/styles.dart';
import 'package:weather_api_app/domain/entities/day_forecast.dart';
import 'package:weather_api_app/domain/entities/forecast.dart';
import 'package:weather_api_app/presentation/widgets/background.dart';
import 'package:weather_api_app/presentation/widgets/current_weather.dart';
import 'package:weather_api_app/presentation/widgets/day_forecast.dart';
import 'package:weather_api_app/presentation/widgets/inputcity.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({
    super.key,
    required this.forecast,
    required TextEditingController cityController,
  }) : _cityController = cityController;

  final ForecastEntity forecast;
  final TextEditingController _cityController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kGreyColor,
        title: Text(
          'Weather App',
          style: kMediumText,
        ),
      ),
      body: BackgroundWidget(
        imageUrl: forecast.todayWeather.isDay
            ? 'assets/images/day.jpg'
            : 'assets/images/night.jpeg',
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InputCityWidget(cityController: _cityController),
                SizedBox(height: 20),
                CurrentWeather(forecast: forecast),
                Expanded(
                  child: ListView.builder(
                    itemCount: forecast.quantityOfDays,
                    itemBuilder: (context, index) {
                      DayForecastEntity dayForecast = forecast.forecast[index];
                      return DayForecast(dayForecast: dayForecast);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
