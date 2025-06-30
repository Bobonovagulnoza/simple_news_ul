import 'package:dartz/dartz.dart';
import 'package:news_app/core/error/failure.dart';
import 'package:news_app/core/network/dio_interceptor.dart';
import 'package:news_app/core/network/network_helper.dart';
import 'package:news_app/features/home/data/models/article_model.dart';

abstract class NewsRemoteDatasource {
  Future<Either<Failure, List<ArticleModel>>> getNews();
}

class NewsRemoteDatasourceImpl extends NewsRemoteDatasource {
  final NetworkHelper networkHelper;
  NewsRemoteDatasourceImpl(DioClient dioClient)
    : networkHelper = NetworkHelper(dioClient.client);

  @override
  Future<Either<Failure, List<ArticleModel>>> getNews() async {
    return networkHelper.fetchList(
      '/everything?domains=wsj.com&apiKey=d37df172bff345f485d51a28f9f0ba59',
      (json) => ArticleModel.fromJson(json),
    );
  }
}
