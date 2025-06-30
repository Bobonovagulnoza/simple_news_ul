import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/core/error/failure.dart';
import 'package:news_app/core/network/dio_interceptor.dart';
import 'package:news_app/core/network/network_helper.dart';
import 'package:news_app/features/home/data/datasource/news_remote_datasource.dart';
import 'package:news_app/features/home/data/repository/news_repository_impl.dart';
import 'package:news_app/features/home/domain/entitiy/article_entity.dart';
import 'package:news_app/features/home/domain/repository/news_repository.dart';
import 'package:news_app/features/home/domain/usecase/news_usecase.dart';

// Dio
final dioClientProvider = Provider<DioClient>((ref) => DioClient());

// Network helper uchunham yozamiz
final networkHelperProvider = Provider<NetworkHelper>(
  (ref) => NetworkHelper(ref.read(dioClientProvider).client),
);

// Datasource uchun
final newsRemoteDatasourceProvider = Provider<NewsRemoteDatasource>(
  (ref) => NewsRemoteDatasourceImpl(ref.read(dioClientProvider)),
);

// Repository uchun provider
final newsRepositoryProvider = Provider<NewsRepository>(
  (ref) => NewsRepositoryImpl(ref.read(newsRemoteDatasourceProvider)),
);

// GetNewsUsace Provider
final getNewsUseCaseProvider = Provider<GetNewsUseCase>(
  (ref) => GetNewsUseCase(ref.read(newsRepositoryProvider)),
);

// news ma'lumotlarni yuklash uchun FUTURE provider
final newsProvider = FutureProvider<Either<Failure, List<ArticleEntity>>>((
  ref,
) async {
  return ref.read(getNewsUseCaseProvider).call();
});
