import 'package:dio/dio.dart';

class HttpService {
  static final HttpService _instance = HttpService._internal();
  final _dio = Dio();

  factory HttpService() {
    return _instance;
  }

  HttpService._internal();

  Future<T> get<T>(
    String url,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    final response = await _dio.get(url);
    if (response.statusCode == 200) {
      final data = response.data;
      return fromJson(data);
    }
    throw Exception('Error al tomar los datos');
  }
}
