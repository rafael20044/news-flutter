import 'package:dio/dio.dart';
import 'package:news/core/environment/environment.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.path.contains('newsapi.org')) {
      options.headers['X-api-key'] = Environment.apiKey.value;
    }
    super.onRequest(options, handler);
  }
}
