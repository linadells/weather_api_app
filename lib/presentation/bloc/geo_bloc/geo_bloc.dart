import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_api_app/domain/repository/geo_repository.dart';

part 'geo_event.dart';
part 'geo_state.dart';

class GeoBloc extends Bloc<GeoEvent, GeoState> {
  GeoRepository _geoRepository;
  GeoBloc(this._geoRepository) : super(GeoInitialState()) {
    on<GetCitiesEvent>(_getCities);
  }

  Future<void> _getCities(GetCitiesEvent event, Emitter<GeoState> emit) async {
    if (event.cityPrefix.isEmpty) {
      emit(GeoInitialState());
      return;
    }
    emit(GeoLoadingState());
    try {
      final List<String> cities =
          await _geoRepository.getCities(event.cityPrefix, 5);
      emit(GeoSuggestionsState(cities));
    } catch (e) {
      emit(GeoErrorState(e.toString()));
    }
  }
}
