import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_api_app/domain/entities/day_forecast.dart';
import 'package:weather_api_app/domain/entities/forecast.dart';
import 'package:weather_api_app/presentation/bloc/bloc/weather_bloc.dart';

class WeatherScreen extends StatefulWidget {
  final ForecastEntity _forecast;
  const WeatherScreen(this._forecast);

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late final TextEditingController _cityController;
  @override
  void initState() {
    super.initState();
    _cityController = TextEditingController();
  }

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                TextField(
                  controller: _cityController,
                ),
                IconButton(
                  icon: Icon(Icons.find_in_page),
                  onPressed: () {
                    BlocProvider.of<WeatherBloc>(context)
                        .add(GetWeatherOfCityEvent(_cityController.text));
                  },
                ),
              ],
            ),
            Text(
              widget._forecast.cityName,
            ),
            Icon(Icons.sunny),
            Text(
              '${widget._forecast.todayWeather.currentTemp}°',
            ),
            Text('${widget._forecast.todayWeather.minTemp}-'
                '${widget._forecast.todayWeather.maxTemp}, '
                '${widget._forecast.todayWeather.humidity}%'),
            SizedBox(
              width: 5,
              height: 5,
            ),
            ListView.builder(
              itemCount: widget._forecast.quantityOfDays,
              itemBuilder: (context, index) {
                DayForecastEntity dayForecast =
                    widget._forecast.forecast[index];
                return ListTile(
                  title: Row(
                    children: [
                      Text(
                        DateFormat('EEEE').format(dayForecast.date),
                      ),
                      Icon(Icons.sunny),
                      Text('${dayForecast.temp}°'),
                      Text('${dayForecast.humidity}%'),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
