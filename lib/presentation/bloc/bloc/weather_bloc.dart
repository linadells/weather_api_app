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
  WeatherBloc(this.weatherRepository) : super(WeatherLoadingState()) {
    on<GetWeatherOfCurrentLocationEvent>(GetWeatherOfCurrentLocation);
    on<GetWeatherOfCityEvent>(GetWeatherOfCity);
  }

  GetWeatherOfCurrentLocation(GetWeatherOfCurrentLocationEvent event,
      Emitter<WeatherState> emit) async {
    try {
      LocationPermission permission;
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          emit(WeatherErrorState('Location permissions are denied'));
        }
      }
      if (permission == LocationPermission.deniedForever) {
        emit(WeatherErrorState(
            'Location permissions are permanently denied, we cannot request permissions.'));
      }

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
