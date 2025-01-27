class DayForecastEntity {
  double temp, humidity;
  String icon;
  DateTime date;

  DayForecastEntity(
      {required this.date,
      required this.temp,
      required this.humidity,
      required this.icon});
}
