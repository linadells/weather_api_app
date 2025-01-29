import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_api_app/core/styles.dart';
import 'package:weather_api_app/domain/entities/day_forecast.dart';
import 'package:weather_api_app/domain/entities/forecast.dart';
import 'package:weather_api_app/injection_container.dart';
import 'package:weather_api_app/presentation/bloc/geo_bloc/geo_bloc.dart';
import 'package:weather_api_app/presentation/bloc/weather_bloc/weather_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_api_app/presentation/pages/splash_screen.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
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
        if (state is WeatherLoadingState) {
          return Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/location_background.jpg'),
                  fit: BoxFit.cover),
            ),
            child: Center(
              child: CircularProgressIndicator(
                color: kWhiteColor,
              ),
            ),
          );
        } else if (state is WeatherLoadedState) {
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
                    image: AssetImage(forecast.todayWeather.isDay
                        ? 'assets/images/day.jpg'
                        : 'assets/images/night.jpeg'),
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
                          BlocBuilder<GeoBloc, GeoState>(
                              builder: (context, geoState) {
                            return Expanded(
                              child: Autocomplete<String>(
                                optionsBuilder: (TextEditingValue val) {
                                  if (val.text.isEmpty) {
                                    return [];
                                  }
                                  BlocProvider.of<GeoBloc>(context)
                                      .add(GetCitiesEvent(val.text));
                                  if (geoState is GeoSuggestionsState) {
                                    return geoState.cities;
                                  }
                                  return [];
                                },
                                onSelected: (String selectedVal) {
                                  _cityController.text = selectedVal;
                                },
                                fieldViewBuilder: (context, controller,
                                    focusNode, onEditingComplete) {
                                  _cityController.text = controller.text;
                                  return TextField(
                                    controller: controller,
                                    focusNode: focusNode,
                                    onEditingComplete: onEditingComplete,
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
                                  );
                                },
                              ),
                            );
                          }),
                          IconButton(
                            icon: Icon(Icons.search, color: kWhiteColor),
                            onPressed: () {
                              BlocProvider.of<WeatherBloc>(context).add(
                                GetWeatherOfCityEvent(_cityController.text),
                              );
                              _cityController.text = '';
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Center(
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
                                    Image.network(
                                      dayForecast.icon.startsWith('http')
                                          ? dayForecast.icon
                                          : 'https:${dayForecast.icon}', // Додаємо https, якщо потрібно
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
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(state.error),
                  backgroundColor: kGreyColor,
                  titleTextStyle: kBigText,
                  contentTextStyle: kMediumText,
                  content: Text(
                      'Where do you want to try to find the weather forecast?'),
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          style: kButtonStyle,
                          child: Text(
                            'Another city',
                            style: kSmallText,
                          ),
                          onPressed: () {
                            _cityController.text = '';
                            Navigator.pop(context);
                          },
                        ),
                        TextButton(
                            style: kButtonStyle,
                            onPressed: () {
                              _cityController.text = '';
                              BlocProvider.of<WeatherBloc>(context).add(
                                  const GetWeatherOfCurrentLocationEvent());
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Your location',
                              style: kSmallText,
                            ))
                      ],
                    ),
                  ],
                );
              },
            );
          });
        }
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
                  image: AssetImage('assets/images/day.jpg'),
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
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
