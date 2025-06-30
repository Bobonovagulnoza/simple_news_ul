import 'package:dio/dio.dart';
import 'failure.dart';

Failure handleDioExeptions(DioException e) {
  final statusCode = e.response?.statusCode;

  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      return ConnectionFailure("Internetga ulanmagan bo'lishi mumkin.");
    case DioExceptionType.badResponse:
      if (statusCode == 404) {
        return ServerFailure("Ma'lumot topilmadi");
      } else if (statusCode != null && statusCode >= 500) {
        return ServerFailure("Server xatosi: $statusCode");
      }

      return ServerFailure("Xato javob: $statusCode");
    default:
      return GenericFailure("Kutilmagan xato: ${e.message}");
  }
}
