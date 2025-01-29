import 'package:dio/dio.dart';

class WeatherAPIService {
  final Dio _dio;

  WeatherAPIService(this._dio);

  Future<Response> getData(
      {required String baseUrl, Map<String, dynamic>? queryParams}) async {
    try {
      final response = await _dio.get(baseUrl,
          queryParameters: queryParams,
          options: Options(headers: {
            'accept': 'application/json',
          }));
      return response;
    } on DioException catch (e) {
      throw Exception(
          e.response?.data['error']['message'] ?? 'Error of getting data');
    }
  }
}
