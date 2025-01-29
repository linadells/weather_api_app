import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_api_app/domain/entities/forecast.dart';
import 'package:weather_api_app/domain/entities/location.dart';
import 'package:weather_api_app/domain/repository/geo_repository.dart';
import 'package:weather_api_app/domain/repository/weather_repository.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_api_app/utils/location_helper.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherRepository _weatherRepository;
  WeatherBloc(this._weatherRepository) : super(WeatherLoadingState()) {
    on<GetWeatherOfCurrentLocationEvent>(_getWeatherOfCurrentLocation);
    on<GetWeatherOfCityEvent>(_getWeatherOfCity);
  }

  _getWeatherOfCurrentLocation(GetWeatherOfCurrentLocationEvent event,
      Emitter<WeatherState> emit) async {
    try {
      await LocationHelper.getLocationPermission();

      Position position = await Geolocator.getCurrentPosition();

      LocationEntity locationEntity =
          LocationEntity(lat: position.latitude, lon: position.longitude);

      emit(WeatherLoadingState());

      ForecastEntity forecast =
          await _weatherRepository.getForecastByLocation(locationEntity, 8);

      emit(WeatherLoadedState(forecast));
    } catch (e) {
      emit(WeatherErrorState(e.toString()));
    }
  }

  _getWeatherOfCity(
      GetWeatherOfCityEvent event, Emitter<WeatherState> emit) async {
    try {
      emit(WeatherLoadingState());

      ForecastEntity forecast =
          await _weatherRepository.getForecastByCity(event.city, 8);

      emit(WeatherLoadedState(forecast));
    } catch (e) {
      emit(WeatherErrorState(e.toString()));
    }
  }
}
