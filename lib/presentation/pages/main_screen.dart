import 'package:flutter/material.dart';
import 'package:weather_api_app/core/styles.dart';
import 'package:weather_api_app/domain/entities/forecast.dart';
import 'package:weather_api_app/presentation/bloc/weather_bloc/weather_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_api_app/presentation/pages/search_screen.dart';
import 'package:weather_api_app/presentation/pages/weather_screen.dart';
import 'package:weather_api_app/presentation/widgets/alert_dialog.dart';
import 'package:weather_api_app/presentation/widgets/background.dart';

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
        if (state is WeatherLoadingState) {
          return BackgroundWidget(
            imageUrl: 'assets/images/background.jpg',
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Loading weather forecast',
                    softWrap: true,
                    overflow: TextOverflow.visible,
                    style:
                        kMediumText.copyWith(decoration: TextDecoration.none),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CircularProgressIndicator(
                    color: kWhiteColor,
                  ),
                ],
              ),
            ),
          );
        } else if (state is WeatherLoadedState) {
          ForecastEntity forecast = state.forecastEntity;
          return WeatherScreen(
              forecast: forecast, cityController: _cityController);
        } else if (state is WeatherErrorState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            buildAlertDialog(
                context: context,
                errorTitle: state.error,
                errorText:
                    'Where do you want to try to find the weather forecast?',
                actions: [
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
                      BlocProvider.of<WeatherBloc>(context)
                          .add(const GetWeatherOfCurrentLocationEvent());
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Your location',
                      style: kSmallText,
                    ),
                  ),
                ]);
          });
        }
        return SearchScreen(cityController: _cityController);
      },
    );
  }
}
