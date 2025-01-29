part of 'geo_bloc.dart';

sealed class GeoState extends Equatable {
  const GeoState();

  @override
  List<Object> get props => [];
}

class GeoInitialState extends GeoState {}

class GeoLoadingState extends GeoState {}

class GeoSuggestionsState extends GeoState {
  final List<String> cities;

  GeoSuggestionsState(this.cities);

  @override
  List<Object> get props => [cities];
}

class GeoErrorState extends GeoState {
  final String message;

  GeoErrorState(this.message);

  @override
  List<Object> get props => [message];
}
