part of 'geo_bloc.dart';

sealed class GeoEvent extends Equatable {
  const GeoEvent();

  @override
  List<Object> get props => [];
}

final class GetCitiesEvent extends GeoEvent {
  String cityPrefix;
  GetCitiesEvent(this.cityPrefix);
}
