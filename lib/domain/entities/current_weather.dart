class CurrentWeatherEntity {
  double currentTemp, minTemp, maxTemp, humidity;
  String icon;
  CurrentWeatherEntity(
      {required this.currentTemp,
      required this.humidity,
      required this.icon,
      required this.maxTemp,
      required this.minTemp});
}
