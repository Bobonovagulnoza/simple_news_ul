import 'package:dio/dio.dart';

class DioClient {
  final Dio _client = Dio();

  DioClient() {
    _client.options = BaseOptions(
      baseUrl: "https://newsapi.org/v2",
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      sendTimeout: const Duration(seconds: 10),
    );

    _client.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print('➡️ [REQUEST] ${options.method} ${options.uri}');
          // options.headers['Authorization'] = 'Bearer YOUR_TOKEN';
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print(
            '✅ [RESPONSE] ${response.statusCode} ${response.requestOptions.uri}',
          );
          return handler.next(response);
        },
        onError: (DioException error, handler) {
          print(
            '⛔ [ERROR] ${error.response?.statusCode} ${error.requestOptions.uri}',
          );
          return handler.next(error);
        },
      ),
    );
  }

  Dio get client => _client;
}
