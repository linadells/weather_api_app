import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_api_app/core/styles.dart';
import 'package:weather_api_app/domain/entities/day_forecast.dart';

class DayForecast extends StatelessWidget {
  const DayForecast({
    super.key,
    required this.dayForecast,
  });

  final DayForecastEntity dayForecast;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: kWhiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        title: Row(
          children: [
            Text(DateFormat('EEEE').format(dayForecast.date),
                style: kSmallText),
            Spacer(),
            Image.network(
              dayForecast.icon.startsWith('http')
                  ? dayForecast.icon
                  : 'https:${dayForecast.icon}',
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 10),
            Text(
              '${dayForecast.temp}°',
              style: kSmallText,
            ),
            SizedBox(width: 10),
            Text(
              '${dayForecast.humidity}%',
              style: kSmallText,
            ),
          ],
        ),
      ),
    );
  }
}
