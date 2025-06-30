import 'package:dartz/dartz.dart';
import 'package:news_app/core/error/failure.dart';
import 'package:news_app/features/home/data/datasource/news_remote_datasource.dart';
import 'package:news_app/features/home/domain/entitiy/article_entity.dart';
import 'package:news_app/features/home/domain/repository/news_repository.dart';

class NewsRepositoryImpl extends NewsRepository {
  NewsRepositoryImpl(this.remoteDatasource);
  final NewsRemoteDatasource remoteDatasource;

  @override
  Future<Either<Failure, List<ArticleEntity>>> getNews() async {
    final result = await remoteDatasource.getNews();
    return result.fold(
      (failure) => Left(failure),
      (articles) => Right(articles.map((e) => e.toEntity()).toList()),
    );
  }
}
