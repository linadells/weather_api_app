import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_api_app/injection_container.dart';
import 'package:weather_api_app/presentation/bloc/geo_bloc/geo_bloc.dart';
import 'package:weather_api_app/presentation/bloc/weather_bloc/weather_bloc.dart';
import 'package:weather_api_app/presentation/pages/main_screen.dart';
import 'package:weather_api_app/presentation/pages/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => WeatherBloc(sl()),
      ),
      BlocProvider(
        create: (context) => GeoBloc(sl()),
      ),
    ],
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
    );
  }
}
