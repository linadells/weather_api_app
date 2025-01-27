import 'package:flutter/material.dart';
import 'package:weather_api_app/presentation/bloc/bloc/weather_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_api_app/presentation/pages/splash_screen.dart';
import 'package:weather_api_app/presentation/pages/weather_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    context.read<WeatherBloc>().add(const GetWeatherOfCurrentLocationEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state is WeatherLoadingState)
          return Center(
            child: CircularProgressIndicator(),
          );
        else if (state is WeatherLoadedState)
          return WeatherScreen(state.forecastEntity);
        return SplashScreen();
      },
    );
  }
}
