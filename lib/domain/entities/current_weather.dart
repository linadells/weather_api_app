class CurrentWeatherEntity {
  double currentTemp, minTemp, maxTemp, humidity;
  bool isDay;
  String icon;
  CurrentWeatherEntity(
      {required this.currentTemp,
      required this.humidity,
      required this.icon,
      required this.maxTemp,
      required this.minTemp,
      required this.isDay});
}
