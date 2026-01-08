import 'package:dio/dio.dart';
import 'package:news/core/network/api_interceptor.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();
  late final Dio dio;

  factory DioClient() => _instance;

  DioClient._internal() {
    dio = Dio();
    dio.interceptors.add(ApiInterceptor());
  }
}
