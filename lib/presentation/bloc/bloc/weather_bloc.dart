import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_api_app/domain/entities/forecast.dart';
import 'package:weather_api_app/domain/entities/location.dart';
import 'package:weather_api_app/domain/repository/weather_repository.dart';
import 'package:geolocator/geolocator.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherRepository weatherRepository;
  WeatherBloc(this.weatherRepository) : super(WeatherInitialState()) {
    on<GetWeatherOfCurrentLocationEvent>(GetWeatherOfCurrentLocation);
    on<GetWeatherOfCityEvent>(GetWeatherOfCity);
  }

  GetWeatherOfCurrentLocation(GetWeatherOfCurrentLocationEvent event,
      Emitter<WeatherState> emit) async {
    try {
      await Future.delayed(const Duration(seconds: 2));

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);

      LocationEntity locationEntity =
          LocationEntity(lat: position.latitude, lon: position.longitude);

      emit(WeatherLoadingState());

      ForecastEntity forecast =
          await weatherRepository.getForecastByLocation(locationEntity, 8);

      emit(WeatherLoadedState(forecast));
    } catch (e) {
      print(e);
    }
  }

  GetWeatherOfCity(
      GetWeatherOfCityEvent event, Emitter<WeatherState> emit) async {
    try {
      emit(WeatherLoadingState());

      ForecastEntity forecast =
          await weatherRepository.getForecastByCity(event.city, 8);

      emit(WeatherLoadedState(forecast));
    } catch (e) {
      print(e);
    }
  }
}
