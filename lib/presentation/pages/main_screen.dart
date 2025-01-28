import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_api_app/core/styles.dart';
import 'package:weather_api_app/domain/entities/day_forecast.dart';
import 'package:weather_api_app/domain/entities/forecast.dart';
import 'package:weather_api_app/presentation/bloc/bloc/weather_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_api_app/presentation/pages/splash_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late final TextEditingController _cityController;

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _cityController = TextEditingController();
    BlocProvider.of<WeatherBloc>(context)
        .add(const GetWeatherOfCurrentLocationEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state is WeatherLoadingState)
          return Center(
            child: CircularProgressIndicator(),
          );
        else if (state is WeatherLoadedState) {
          ForecastEntity forecast = state.forecastEntity;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: kGreyColor,
              title: Text(
                'Weather App',
                style: kMediumText,
              ),
            ),
            body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/location_background.jpg'),
                    fit: BoxFit.cover),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _cityController,
                              decoration: InputDecoration(
                                hintText: 'Input city',
                                hintStyle: kSmallText,
                                filled: true,
                                fillColor: kWhiteColor,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.search, color: kWhiteColor),
                            onPressed: () {
                              BlocProvider.of<WeatherBloc>(context).add(
                                GetWeatherOfCityEvent(_cityController.text),
                              );
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: Column(
                          children: [
                            Text(forecast.cityName, style: kBigText),
                            Icon(Icons.wb_sunny, size: 70, color: Colors.white),
                            Text(
                                '${forecast.todayWeather.currentTemp.toStringAsFixed(1)}°',
                                style: kBigText),
                            Text(
                              '${forecast.todayWeather.minTemp}° - ${forecast.todayWeather.maxTemp}° | ${forecast.todayWeather.humidity}%',
                              style: kMediumText,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: forecast.quantityOfDays,
                          itemBuilder: (context, index) {
                            DayForecastEntity dayForecast =
                                forecast.forecast[index];
                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              elevation: 5,
                              margin: EdgeInsets.symmetric(vertical: 5),
                              child: ListTile(
                                title: Row(
                                  children: [
                                    Text(
                                        DateFormat('EEEE')
                                            .format(dayForecast.date),
                                        style: kSmallText),
                                    Spacer(),
                                    Icon(Icons.wb_sunny, color: Colors.orange),
                                    // Image.network(
                                    //   '${dayForecast.icon}',
                                    //   width: 40,
                                    //   height: 40,
                                    //   fit: BoxFit.cover,
                                    // ),
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
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else if (state is WeatherErrorState) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Error'),
                content: Text(state.error),
                actions: <Widget>[
                  TextButton(
                    child: Text('ОК'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
        return SplashScreen();
      },
    );
  }
}
