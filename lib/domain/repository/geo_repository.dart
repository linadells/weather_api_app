import 'package:http/http.dart';

abstract class GeoRepository {
  Future<List<String>> getCities(String cityPrefix, int namesLimit);
}
