part of 'geo_bloc.dart';

sealed class GeoEvent extends Equatable {
  const GeoEvent();

  @override
  List<Object> get props => [];
}

final class GetCitiesEvent extends GeoEvent {
  final String cityPrefix;
  const GetCitiesEvent(this.cityPrefix);

  @override
  List<Object> get props => [cityPrefix];
}
