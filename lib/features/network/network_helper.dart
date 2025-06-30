import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:news_app/core/error/exeption_handler.dart';
import 'package:news_app/core/error/failure.dart';

typedef FromJson<T> = T Function(dynamic json);

class NetworkHelper {
  final Dio client;
  NetworkHelper(this.client);

  Future<Either<Failure, List<T>>> fetchList<T>(
    String url,
    FromJson<T> fromJson,
  ) async {
    try {
      final response = await client.get(url);
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        final data = response.data;
        if (data is Map<String, dynamic> && data['articles'] is List) {
          final dataList = (data['articles'] as List)
              .map((e) => fromJson(e))
              .toList();
          return Right(dataList);
        }
        return Left(ServerFailure("Kutilgan format list emas."));
      }
      return Left(ServerFailure("Xatolik status code: ${response.statusCode}"));
    } on DioException catch (e) {
      return Left(handleDioExeptions(e));
    } catch (e) {
      return Left(GenericFailure("Kutilmagan xatolik: $e"));
    }
  }

  // Future<Either<Failure, T>> fetchOne<T>(
  //   String url,
  //   FromJson<T> fromJson,
  // ) async {
  //   try {
  //     final response = await client.get(url);
  //     if (response.statusCode! >= 200 && response.statusCode! < 300) {
  //       return Right(fromJson(response.data));
  //     } else {
  //       return Left(
  //         ServerFailure("Xatolik status code: ${response.statusCode}"),
  //       );
  //     }
  //   } on DioException catch (e) {
  //     return Left(handleDioExeptions(e));
  //   } catch (e) {
  //     return Left(GenericFailure("Kutilmagan xatolik: $e"));
  //   }
  // }
}
